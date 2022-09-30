#lang racket

(require rackunit/text-ui rackunit)

(require racket/runtime-path)
(define-runtime-path broken_xml_file "broken.xml")

(require "../../main.rkt")

(define test-xml
  (test-suite
   "test-broken"

   (test-case
    "test-broken"

    (check-exn
     exn:fail?
     (lambda ()
       (xml->hash broken_xml_file)))

    (check-exn
     exn:fail?
     (lambda ()
       (xml->hash (open-input-file broken_xml_file))))
    )

  ))

(run-tests test-xml)
