#lang racket

(require rackunit/text-ui)
(require racket/date)

(require racket/runtime-path)
(define-runtime-path broken_xml_file "broken.xml")

(require rackunit "../../main.rkt")

(define test-xml
  (test-suite
   "test-broken"

   (test-case
    "test-broken"

    (let ([xml_hash (xml->hash broken_xml_file)])
      (check-false xml_hash)
      )

    )

  ))

(run-tests test-xml)
