#lang info

(define scribblings
  '(("scribble/simple-xml.scrbl" (multi-page) (tool 100))))

(define compile-omit-paths '("test"))
(define test-omit-paths '("src" "main.rkt" "scribble" "info.rkt"))
