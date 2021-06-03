#lang racket

(require xml)
(require xml/xexpr)

(require detail)

(provide (contract-out
          [xml->hash (-> path-string? (or/c #f hash?))]
          [remove-one-map (-> hash? hash?)]
          [lists->xml (-> list? string?)]
          [xml-trim (-> string? string?)]
          [lists->xml_content (-> list? string?)]
          [lists->compact_xml (-> list? string?)]
          ))

(define (xml->hash xml)
  (detail
   #:formats? #f
;;   #:formats? '("xml_debug.pdf")
   (lambda ()
     (detail-page
      #:line_break_length? 80
      #:font_size? 'small
      (lambda ()
        (detail-h1 "Decode XML Process")
        (detail-line (format "XML File:~a" xml))

        (let ([xml_xexpr
               ;; load xml file to xexpr to start parsing
               (call-with-input-file
                   xml
                 (lambda (origin_port)
                   ;; remove all the spaces
                   (call-with-input-string
                    (regexp-replace* #rx"> *<"
                                     (regexp-replace* #rx"\n|\r" (port->string origin_port) "")
                                     "><")
                    (lambda (filtered_port)
                      (list (xml->xexpr (document-element (read-xml filtered_port))))))))])

          (let ([xml_hash (make-hash)])
            ;; parent_node means parent node name, start from #f
            (let loop-node ([parent_node #f]
                            [xml_list xml_xexpr])

              (let ([node_count.sym (format "~a's count" parent_node)])
                (detail-line "")
                (detail-line "***************************************")
                (detail-line (format "parent_node:[~a]\n" parent_node))
                (detail-line (format "node_count.sym:[~a][~a]\n"
                                     node_count.sym
                                     (hash-ref xml_hash node_count.sym 0)))
                (detail-line (format "xml_list:[~a]\n" xml_list))
                (detail-line "***************************************")
                
                (if (not (null? xml_list))
                    (let ([node (car xml_list)])
                      (detail-line (format "node:[~a]" node))
                      (if (not (list? node))
                          (if (null? node) ;; node is symbol
                              (begin
                                (detail-line "null node, next loop")
                                (loop-node node (cdr xml_list)))
                              (if (symbol? node)
                                  (begin
                                    (detail-line "node is a symbol")
                                    (let* ([origin_node_prefix (format "~a.~a" parent_node node)]
                                           [node_count (hash-ref xml_hash origin_node_prefix 1)]
                                           [node_prefix (format "~a.~a~a" parent_node node node_count)])

                                      (detail-line "")
                                      (detail-line "***************************************")
                                      (detail-line (format "orign node:[~a]" origin_node_prefix))
                                      (detail-line (format "node count:[~a]" node_count))
                                      (detail-line (format "node prefix:[~a]" node_prefix))
                                      (detail-line "***************************************")

                                      (when (hash-has-key? xml_hash node_prefix)
                                        (let ([new_node_prefix (format "~a~a~a" parent_node node (add1 node_count))])
                                          (hash-set! xml_hash origin_node_prefix (add1 node_count))
                                          (set! node_prefix new_node_prefix)
                                          (detail-line (format "exists, prefix changed to:[~a]" new_node_prefix))))

                                      (loop-node node_prefix (cdr xml_list))))
                                  (begin
                                    (detail-line "node is value")
                                    (hash-set! xml_hash parent_node node))))
                          (begin ;; node is a list
                            (let* ([prefix #f]
                                   [first_node (car node)]
                                   [attr_list (cadr node)]
                                   [content_list (cddr node)]
                                   [prefix (format "~a~a" (if parent_node (format "~a." parent_node) "") first_node)]
                                   [count_sym (format "~a's count" prefix)])

                              (detail-line "")
                              (detail-line "***************************************")
                              (detail-line "node is a list")
                              (detail-line (format "first_node:[~a]" first_node))
                              (detail-line (format "prefix:[~a]" prefix))
                              (detail-line (format "attrs:[~a]" attr_list))
                              (detail-line (format "content:[~a]" content_list))
                              (detail-line "***************************************")

                              (hash-set! xml_hash count_sym (add1 (hash-ref xml_hash count_sym 0)))
                              (set! prefix (format "~a~a~a"
                                                   (if parent_node (format "~a." parent_node) "")
                                                   first_node
                                                   (hash-ref xml_hash count_sym)))
                              (detail-line (format "it is a list sym, prefix changed to:[~a]" prefix))

                              (detail-line "")
                              (detail-line "***************************************")
                              (detail-line "process the attrs")
                              (let loop-attr ([attrs attr_list])
                                (when (not (null? attrs))
                                      (hash-set! xml_hash (format "~a.~a" prefix (caar attrs)) (cadar attrs))
                                      (loop-attr (cdr attrs))))
                              (detail-line (format "xml_hash after process attrs:[~a]" xml_hash))
                              (detail-line "***************************************")

                              (detail-line (format "process ~a's content" prefix))
                              (cond
                               [(and (= (length content_list) 1) (not (list? (car content_list))))
                                (detail-line (format "content is a value: [~a]" (car content_list)))
                                (hash-set! xml_hash prefix (car content_list))]
                               [(null? content_list)
                                (detail-line "value is null")
                                (hash-set! xml_hash prefix "")]
                               [else
                                (detail-line (format "process value: [~a]" content_list))
                                (loop-node prefix content_list)])

                              (detail-line "process next node")
                              (if (and (= (length xml_list) 1) (not (list? (car xml_list))))
                                  (hash-set! xml_hash parent_node (cadr xml_list))
                                  (loop-node parent_node (cdr xml_list)))
                              ))))
                    (detail-line "xml_list is null, end loop"))))

            (detail-line "remove all's only one node's sequence suffix.")
            (set! xml_hash (remove-one-map xml_hash))

            (detail-new-page)
            (detail-line "")
            (detail-line "***************************************")
            (detail-line (format "xml_hash:[~a]" xml_hash))
            (detail-line "***************************************")
            xml_hash)))))))

(define (remove-one-map xml_hash)
  (let ([scanned_hash (make-hash)])
    (let loop ([origin_pairs (hash->list xml_hash)]
               [removed_pairs (hash->list xml_hash)])
      (if (not (null? origin_pairs))
          (let* ([val (car origin_pairs)]
                 [k (car val)]
                 [v (cdr val)])
            (if (and (not (hash-has-key? scanned_hash k)) (number? v) (= v 1))
                (let ([match_res (regexp-match #rx"^(.+)('s count)" k)])
                  (hash-set! scanned_hash k "")
                  (if match_res
                      (let ([new_pairs 
                             (map
                              (lambda (pair)
                                (cons
                                 (regexp-replace* (regexp (format "^~a1" (second match_res))) (car pair) (second match_res))
                                 (cdr pair)))
                              removed_pairs)])
                        (loop new_pairs new_pairs))
                      (loop (cdr origin_pairs) removed_pairs)))
                (loop (cdr origin_pairs) removed_pairs)))
          (make-hash removed_pairs)))))

(define (lists->xml xml_list)
  (add-xml-head (lists->xml_content xml_list)))

(define (lists->compact_xml xml_list)
  (add-xml-head (xml-trim (lists->xml_content xml_list))))

(define (xml-trim xml)
  (regexp-replace* #rx">\n *<" xml "><"))

(define (add-xml-head xml_str)
  (format "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n\n~a" xml_str))

(define (lists->xml_content xml_list)
  (call-with-output-string
    (lambda (xml_port)
      (let loop ([out_p xml_port]
                 [nodes xml_list]
                 [prefix_spaces ""])
        (when (and (not (null? nodes)) ((or/c string? symbol?) (car nodes)))
          (let* ([properties (filter (cons/c (or/c string? symbol?) (or/c string? symbol?)) (cdr nodes))]
                 [children (filter-not (cons/c (or/c string? symbol?) (or/c string? symbol?)) (cdr nodes))]
                 [value_children (filter (or/c string? symbol?) children)]
                 [list_children (filter list? children)])
            (fprintf out_p
                            "~a<~a~a"
                            prefix_spaces
                            (car nodes)
                            (call-with-output-string
                             (lambda (property_port)
                               (let loop-properties ([properties (filter (cons/c (or/c string? symbol?) (or/c string? symbol?)) (cdr nodes))])
                                 (when (not (null? properties))
                                   (fprintf property_port" ~a=\"~a\"" (caar properties) (cdar properties))
                                   (loop-properties (cdr properties)))))))

             (if (null? children)
                 (fprintf out_p "/>\n")
                 (begin
                   (fprintf out_p ">")
                   (if (not (null? value_children))
                       (fprintf out_p "~a</~a>\n" (apply string-append (map (lambda (v) (format "~a" v)) value_children)) (car nodes))
                       (fprintf out_p "\n~a~a</~a>\n"
                                (call-with-output-string
                                 (lambda (children_port)
                                   (let loop-children ([children list_children])
                                     (when (not (null? children))
                                       (loop children_port (car children) (string-append prefix_spaces "  "))
                                       (loop-children (cdr children))))))
                                prefix_spaces
                                (car nodes)))))))))))
