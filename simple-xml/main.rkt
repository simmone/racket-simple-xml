#lang racket

(require "src/xml.rkt")

(provide (contract-out
          [xml->hash (-> path-string? (or/c #f hash?))]
          [lists->xml (-> list? string?)]
          [lists->compact_xml (-> list? string?)]
          ))
