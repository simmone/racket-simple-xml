#lang racket

(require rackunit/text-ui)
(require racket/date)

(require rackunit "../../src/xml.rkt")

(define test-xml
  (test-suite
   "test-remove-one-map"

   (test-case
    "test-remove-one-map"

    (let ([xml_hash (make-hash)])
      (hash-set! xml_hash "workbook's count" 1)
      (hash-set! xml_hash "workbook1.fileVersion's count" 1)
      (hash-set! xml_hash "workbook1.fileVersion1" "")
      (hash-set! xml_hash "workbook1.fileVersion1.appName" "xl")
      (hash-set! xml_hash "workbook1.sheet's count" 2)
      (hash-set! xml_hash "workbook1.sheet1.v1" "a")
      (hash-set! xml_hash "workbook1.sheet1.v2" "b")
      (hash-set! xml_hash "workbook1.sheet2.v1" "c")
      (hash-set! xml_hash "workbook1.sheet2.v2" "d")

      (set! xml_hash (remove-one-map xml_hash))
      
      (check-equal? (hash-ref xml_hash "workbook's count") 1)
      (check-equal? (hash-ref xml_hash "workbook.fileVersion's count") 1)
      (check-equal? (hash-ref xml_hash "workbook.fileVersion") "")
      (check-equal? (hash-ref xml_hash "workbook.fileVersion.appName") "xl")
      (check-equal? (hash-ref xml_hash "workbook.sheet's count") 2)
      (check-equal? (hash-ref xml_hash "workbook.sheet1.v1") "a")
      (check-equal? (hash-ref xml_hash "workbook.sheet1.v2") "b")
      (check-equal? (hash-ref xml_hash "workbook.sheet2.v1") "c")
      (check-equal? (hash-ref xml_hash "workbook.sheet2.v2") "d")
    ))

  ))

(run-tests test-xml)
