#lang racket

(require rackunit/text-ui)
(require racket/date)

(require racket/runtime-path)
(define-runtime-path sharedStrings_xml_file "sharedStrings.xml")
(define-runtime-path sharedStrings_formated_xml_file "sharedStrings_formated.xml")
(define-runtime-path sharedStrings_compact_xml_file "sharedStrings_compact.xml")

(require rackunit "../../main.rkt")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-shared-string"

    (let ([xml_hash (xml->hash sharedStrings_xml_file)])
      
      (check-equal? (hash-ref xml_hash "sst's count") 1)
      (check-equal? (hash-ref xml_hash "sst.count") "17")
      (check-equal? (hash-ref xml_hash "sst.uniqueCount") "17")
      (check-equal? (hash-ref xml_hash "sst.xmlns") "http://schemas.openxmlformats.org/spreadsheetml/2006/main")

      (check-equal? (hash-ref xml_hash "sst.si's count") 17)

      (check-equal? (hash-ref xml_hash "sst.si1.t") "")
      (check-equal? (hash-ref xml_hash "sst.si1.t's count") 1)
      (check-equal? (hash-ref xml_hash "sst.si1.phoneticPr") "")
      (check-equal? (hash-ref xml_hash "sst.si1.phoneticPr's count") 1)
      (check-equal? (hash-ref xml_hash "sst.si1.phoneticPr.fontId") "1")
      (check-equal? (hash-ref xml_hash "sst.si1.phoneticPr.type") "noConversion")

      (check-equal? (hash-ref xml_hash "sst.si10.t") "Center")
      (check-equal? (hash-ref xml_hash "sst.si10.t's count") 1)
      (check-equal? (hash-ref xml_hash "sst.si10.phoneticPr") "")
      (check-equal? (hash-ref xml_hash "sst.si10.phoneticPr's count") 1)
      (check-equal? (hash-ref xml_hash "sst.si10.phoneticPr.fontId") "1")
      (check-equal? (hash-ref xml_hash "sst.si10.phoneticPr.type") "noConversion")

      (check-equal? (hash-ref xml_hash "sst.si17.t") "month/brand")
      (check-equal? (hash-ref xml_hash "sst.si17.t's count") 1)
      (check-equal? (hash-ref xml_hash "sst.si17.phoneticPr") "")
      (check-equal? (hash-ref xml_hash "sst.si17.phoneticPr's count") 1)
      (check-equal? (hash-ref xml_hash "sst.si17.phoneticPr.fontId") "1")
      (check-equal? (hash-ref xml_hash "sst.si17.phoneticPr.type") "noConversion")

      (check-equal? (hash-count xml_hash) 107)))

   (test-case
    "write-sharedString-xml"

    (let ([xml '("sst"
                 ("xmlns" . "http://schemas.openxmlformats.org/spreadsheetml/2006/main")
                 ("count" . "17")
                 ("uniqueCount" . "17")
                 ("si" ("t") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "201601") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "201602") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "201603") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "201604") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "201605") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Asics") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Bottom") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "CAT") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Center") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Center/Middle") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Left") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Middle") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Puma") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Right") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Top") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "month/brand") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion"))))])

      (call-with-input-file sharedStrings_formated_xml_file
        (lambda (p)
          (check-equal? (lists->xml xml)
                        (port->string p))))

      (call-with-input-file sharedStrings_compact_xml_file
        (lambda (p)
          (check-equal? (lists->compact_xml xml)
                        (port->string p))))))


  ))

(run-tests test-xml)
