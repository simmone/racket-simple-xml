#lang racket

(require "xml.rkt")

(provide (contract-out
          [xml->hash (-> (or/c path-string? input-port?) (or/c #f hash?))]
          [xml-trim (-> string? string?)]
          [lists->xml_content (-> list? string?)]
          [lists->xml (-> list? string?)]
          [lists->compact_xml (-> list? string?)]
          ))
