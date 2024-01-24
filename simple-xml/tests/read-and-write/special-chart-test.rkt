#lang racket

(require rackunit/text-ui rackunit)
(require racket/date)

(require racket/runtime-path)
(define-runtime-path special_char_xml_file "special_char_test.xml")

(require "../../main.rkt")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-special-char"

    (let ([xml_hash (xml->hash special_char_xml_file)])
      
      (check-equal? (hash-ref xml_hash "sst's count") 1)
      (check-equal? (hash-ref xml_hash "sst1.count") "9")
      (check-equal? (hash-ref xml_hash "sst1.uniqueCount") "9")

      (check-equal? (hash-ref xml_hash "sst1.si's count") 9)

      (check-equal? (hash-ref xml_hash "sst1.si1.t1") "<test>")
      (check-equal? (hash-ref xml_hash "sst1.si2.t1") "<foo> ")
      (check-equal? (hash-ref xml_hash "sst1.si3.t1") " <baz>")
      (check-equal? (hash-ref xml_hash "sst1.si4.t1") "< bar>")
      (check-equal? (hash-ref xml_hash "sst1.si5.t1") "< fro >")
      (check-equal? (hash-ref xml_hash "sst1.si6.t1") "<bas >")
      (check-equal? (hash-ref xml_hash "sst1.si7.t1") "<maybe")
      (check-equal? (hash-ref xml_hash "sst1.si8.t1") "<< not >>")
      (check-equal? (hash-ref xml_hash "sst1.si9.t1") "show>")
      ))
  ))

(run-tests test-xml)
