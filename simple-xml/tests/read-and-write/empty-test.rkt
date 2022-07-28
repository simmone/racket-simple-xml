#lang racket

(require rackunit/text-ui)
(require racket/date)

(require racket/runtime-path)
(define-runtime-path empty_xml_file "empty.xml")

(require rackunit "../../main.rkt")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-empty-xml"

    (let ([xml_hash (xml->hash empty_xml_file)])
      
      (check-equal? (hash-count xml_hash) 4)

      (check-equal? (hash-ref xml_hash "empty's count") 1)
      (check-equal? (hash-ref xml_hash "empty1") "")
      (check-equal? (hash-ref xml_hash "empty1.attr1") "a1")
      (check-equal? (hash-ref xml_hash "empty1.attr2") "a2")
      )

    (let ([xml_hash (xml->hash (open-input-file empty_xml_file))])
      
      (check-equal? (hash-count xml_hash) 4)

      (check-equal? (hash-ref xml_hash "empty's count") 1)
      (check-equal? (hash-ref xml_hash "empty1") "")
      (check-equal? (hash-ref xml_hash "empty1.attr1") "a1")
      (check-equal? (hash-ref xml_hash "empty1.attr2") "a2")
      )
    )

   (test-case
    "write-empty-xml"

    (let ([xml '("empty" ("attr1" . "a1") ("attr2" . "a2"))])
      (call-with-input-file empty_xml_file
        (lambda (p)
          (check-equal? (lists->xml xml)
                        (port->string p))))))

  ))

(run-tests test-xml)
