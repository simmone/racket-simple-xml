#lang info

(define scribblings
  '(("scribble/simple-xml.scrbl" (multi-page) (tool 100))))

(define compile-omit-paths '("tests"))
(define test-omit-paths '("xml.rkt" "main.rkt" "scribble" "info.rkt"))
