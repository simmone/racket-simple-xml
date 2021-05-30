#lang racket

(require "src/xml.rkt")

(provide (contract-out
          [xml->hash (-> path-string? (or/c #f hash?))]
          [xml-trim (-> string? string?)]
          [lists->xml_content (-> list? string?)]
          [lists->xml (-> list? string?)]
          [lists->compact_xml (-> list? string?)]
          ))
