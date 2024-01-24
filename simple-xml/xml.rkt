#lang racket

(require xml)
(require xml/xexpr)

(provide (contract-out
          [xml->hash (-> (or/c path-string? input-port?) (or/c #f hash?))]
          [lists->xml (-> list? string?)]
          [xml-trim (-> string? string?)]
          [lists->xml_content (-> list? string?)]
          [lists->compact_xml (-> list? string?)]
          ))

(define (xml->hash xml)
  (let ([xml_xexpr
         ;; load xml file or input port to xexpr to start parsing
         (let ([src_port
                (if (input-port? xml)
                    xml
                    (open-input-file xml))])
           ;; remove all the spaces
           (call-with-input-string
            (regexp-replace* #rx"> *<"
                             (regexp-replace* #rx"\n|\r" (port->string src_port) "")
                             "><")
            (lambda (filtered_port)
              (list (xml->xexpr (document-element (read-xml filtered_port)))))))])
    
    (let ([xml_hash (make-hash)])
      ;; parent_node means parent node name, start from #f
      (let loop-node ([parent_node #f]
                      [xml_list xml_xexpr])

        (let ([node_count.sym (format "~a's count" parent_node)])
          (if (not (null? xml_list))
              (let ([node (car xml_list)])
                (if (not (list? node))
                    (if (null? node) ;; node is symbol
                        (loop-node node (cdr xml_list))
                        (if (symbol? node)
                            (let* ([origin_node_prefix (format "~a.~a" parent_node node)]
                                   [node_count (hash-ref xml_hash origin_node_prefix 1)]
                                   [node_prefix (format "~a.~a~a" parent_node node node_count)])

                              (when (hash-has-key? xml_hash node_prefix)
                                (let ([new_node_prefix (format "~a~a~a" parent_node node (add1 node_count))])
                                  (hash-set! xml_hash origin_node_prefix (add1 node_count))
                                  (set! node_prefix new_node_prefix)))

                              (loop-node node_prefix (cdr xml_list)))
                            (hash-set! xml_hash parent_node node)))
                    (let* ([prefix #f]
                           [first_node (car node)]
                           [attr_list (cadr node)]
                           [content_list (cddr node)]
                           [prefix (format "~a~a" (if parent_node (format "~a." parent_node) "") first_node)]
                           [count_sym (format "~a's count" prefix)])
                      
                      (hash-set! xml_hash count_sym (add1 (hash-ref xml_hash count_sym 0)))
                      (set! prefix (format "~a~a~a"
                                           (if parent_node (format "~a." parent_node) "")
                                           first_node
                                           (hash-ref xml_hash count_sym)))

                      (let loop-attr ([attrs attr_list])
                        (when (not (null? attrs))
                          (hash-set! xml_hash (format "~a.~a" prefix (caar attrs)) (cadar attrs))
                          (loop-attr (cdr attrs))))

                      (cond
                       [(null? content_list)
                        (hash-set! xml_hash prefix "")]
                       [(not (list? (car content_list)))
                        (hash-set! xml_hash prefix (string-join content_list ""))]
                       [else
                        (loop-node prefix content_list)])

                      (if (and (= (length xml_list) 1) (not (list? (car xml_list))))
                          (hash-set! xml_hash parent_node (cadr xml_list))
                          (loop-node parent_node (cdr xml_list)))
                      )))
              xml_hash))))))

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
