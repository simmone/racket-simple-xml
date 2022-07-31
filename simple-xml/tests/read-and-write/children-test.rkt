#lang racket

(require rackunit/text-ui)
(require racket/date)

(require racket/runtime-path)
(define-runtime-path children_xml_file "children.xml")

(require rackunit "../../main.rkt")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "read-children-xml"

    (let ([xml_hash (xml->hash children_xml_file)])
      (check-equal? (hash-count xml_hash) 7)

      (check-equal? (hash-ref xml_hash "children's count") 1)

      (check-equal? (hash-ref xml_hash "children1.child1's count") 1)
      (check-equal? (hash-ref xml_hash "children1.child11") "c1")
      (check-equal? (hash-ref xml_hash "children1.child11.attr1") "a1")

      (check-equal? (hash-ref xml_hash "children1.child2's count") 1)
      (check-equal? (hash-ref xml_hash "children1.child21") "c2")
      (check-equal? (hash-ref xml_hash "children1.child21.attr1") "a1")
      )

    (let ([xml_hash (xml->hash (open-input-file children_xml_file))])
      (check-equal? (hash-count xml_hash) 7)

      (check-equal? (hash-ref xml_hash "children's count") 1)

      (check-equal? (hash-ref xml_hash "children1.child1's count") 1)
      (check-equal? (hash-ref xml_hash "children1.child11") "c1")
      (check-equal? (hash-ref xml_hash "children1.child11.attr1") "a1")

      (check-equal? (hash-ref xml_hash "children1.child2's count") 1)
      (check-equal? (hash-ref xml_hash "children1.child21") "c2")
      (check-equal? (hash-ref xml_hash "children1.child21.attr1") "a1")
      )
    )

   (test-case
    "write-children-xml"

    (let ([xml '("children" ("child1" ("attr1" . "a1") "c1") ("child2" ("attr1" . "a1") "c2"))])
      (call-with-input-file children_xml_file
        (lambda (p)
          (check-equal? (lists->xml xml)
                        (port->string p))))))

  ))

(run-tests test-xml)
