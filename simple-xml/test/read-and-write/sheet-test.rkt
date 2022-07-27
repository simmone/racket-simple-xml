#lang racket

(require rackunit/text-ui)
(require racket/date)

(require racket/runtime-path)
(define-runtime-path sheet_xml_file "sheet.xml")

(require rackunit "../../main.rkt")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-sheet"

    (let ([xml_hash (xml->hash sheet_xml_file)])
      (check-equal? (hash-ref xml_hash "worksheet's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.xmlns") "http://schemas.openxmlformats.org/spreadsheetml/2006/main")
      (check-equal? (hash-ref xml_hash "worksheet1.xmlns:r") "http://schemas.openxmlformats.org/officeDocument/2006/relationships")

      ;; 3
      (check-equal? (hash-ref xml_hash "worksheet1.dimension's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.dimension1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.dimension1.ref") "A1:F4")

      ;; 6
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView's count") 1)

      ;; 8
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection's count") 3)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection1.pane") "bottomLeft")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection2") "")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection2.pane") "topRight")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection3") "")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.selection3.pane") "bottomRight")

      ;; 15
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.workbookViewId") "0")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1.ySplit") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1.xSplit") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1.topLeftCell") "B2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1.activePane") "bottomRight")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetViews1.sheetView1.pane1.state") "frozen")

      ;; 23
      (check-equal? (hash-ref xml_hash "worksheet1.sheetFormatPr's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetFormatPr1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetFormatPr1.defaultRowHeight") "13.5")

      ;; 26
      (check-equal? (hash-ref xml_hash "worksheet1.cols's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col's count") 4)

      ;; 28
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col1.min") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col1.max") "2")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col1.width") "50")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col2") "")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col2.min") "3")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col2.max") "4")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col2.width") "8")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col3") "")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col3.min") "5")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col3.max") "5")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col3.width") "14")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col4") "")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col4.min") "6")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col4.max") "6")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col4.width") "8")

      ;; 44
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row's count") 4)

      ;; 46
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.r") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.spans") "1:6")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c's count") 6)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c1.r") "A1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c1.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c1.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c1.v1") "16")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c2.r") "B1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c2.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c2.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c2.v1") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c3.r") "C1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c3.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c3.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c3.v1") "2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c4.r") "D1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c4.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c4.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c4.v1") "3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c5.r") "E1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c5.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c5.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c5.v1") "4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c6.r") "F1")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c6.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c6.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row1.c6.v1") "5")

      ;; 73
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.r") "2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.spans") "1:6")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c's count") 6)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c1.r") "A2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c1.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c1.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c1.v1") "8")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c2.r") "B2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c2.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c2.v1") "100")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c3.r") "C2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c3.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c3.v1") "300")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c4.r") "D2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c4.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c4.v1") "200")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c5.r") "E2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c5.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c5.v1") "0.6934")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c6.r") "F2")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c6.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row2.c6.v1") "43360")

      ;; 95
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.r") "3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.spans") "1:6")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c's count") 6)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c1.r") "A3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c1.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c1.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c1.v1") "13")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c2.r") "B3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c2.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c2.v1") "200")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c3.r") "C3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c3.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c3.v1") "400")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c4.r") "D3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c4.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c4.v1") "300")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c5.r") "E3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c5.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c5.v1") "139999.89223")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c6.r") "F3")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c6.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row3.c6.v1") "43361")

      ;; 117
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.r") "4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.spans") "1:6")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c's count") 6)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c1.r") "A4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c1.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c1.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c1.v1") "6")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c2.r") "B4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c2.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c2.v1") "300")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c3.r") "C4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c3.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c3.v1") "500")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c4.r") "D4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c4.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c4.v1") "400")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c5.r") "E4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c5.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c5.v1") "23.34")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c6.r") "F4")
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c6.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.sheetData1.row4.c6.v1") "43362")

      ;; 139
      (check-equal? (hash-ref xml_hash "worksheet1.phoneticPr's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.phoneticPr1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.phoneticPr1.fontId") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.phoneticPr1.type") "noConversion")

      ;; 143
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.left") "0.7")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.right") "0.7")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.top") "0.75")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.bottom") "0.75")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.header") "0.3")
      (check-equal? (hash-ref xml_hash "worksheet1.pageMargins1.footer") "0.3")

      ;; 151
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1") "")
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1.paperSize") "9")
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1.orientation") "portrait")
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1.horizontalDpi") "200")
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1.verticalDpi") "200")
      (check-equal? (hash-ref xml_hash "worksheet1.pageSetup1.r:id") "rId1")
      
      ;; 158
      (check-equal? (hash-count xml_hash) 158)
    ))

   (test-case
    "write-sheet-xml"

    (let ([xml '("worksheet"
                 ("xmlns" . "http://schemas.openxmlformats.org/spreadsheetml/2006/main")
                 ("xmlns:r" . "http://schemas.openxmlformats.org/officeDocument/2006/relationships")
                 ("dimension" ("ref". "A1:F4"))
                 ("sheetViews"
                  ("sheetView"
                   ("workbookViewId" . "0")
                   ("pane" ("ySplit" . "1") ("xSplit" . "1") ("topLeftCell" . "B2") ("activePane" . "bottomRight") ("state" . "frozen"))
                   ("selection" ("pane" . "bottomLeft"))
                   ("selection" ("pane" . "topRight"))
                   ("selection" ("pane" . "bottomRight"))))
                 ("sheetFormatPr" ("defaultRowHeight" . "13.5"))
                 ("cols"
                  ("col" ("min" . "1") ("max" . "2") ("width" . "50"))
                  ("col" ("min" . "3") ("max" . "4") ("width" . "8"))
                  ("col" ("min" . "5") ("max" . "5") ("width" . "14"))
                  ("col" ("min" . "6") ("max" . "6") ("width" . "8")))
                 ("sheetData"
                  ("row" ("r" . "1") ("spans" . "1:6")
                   ("c" ("r" . "A1") ("t" . "s") ("v" "16"))
                   ("c" ("r" . "B1") ("t" . "s") ("v" "1"))
                   ("c" ("r" . "C1") ("t" . "s") ("v" "2"))
                   ("c" ("r" . "D1") ("t" . "s") ("v" "3"))
                   ("c" ("r" . "E1") ("t" . "s") ("v" "4"))
                   ("c" ("r" . "F1") ("t" . "s") ("v" "5")))

                  ("row" ("r" . "2") ("spans" . "1:6")
                   ("c" ("r" . "A2") ("t" . "s") ("v" "8"))
                   ("c" ("r" . "B2") ("v" "100"))
                   ("c" ("r" . "C2") ("v" "300"))
                   ("c" ("r" . "D2") ("v" "200"))
                   ("c" ("r" . "E2") ("v" "0.6934"))
                   ("c" ("r" . "F2") ("v" "43360")))

                  ("row" ("r" . "3") ("spans" . "1:6")
                   ("c" ("r" . "A3") ("t" . "s") ("v" "13"))
                   ("c" ("r" . "B3") ("v" "200"))
                   ("c" ("r" . "C3") ("v" "400"))
                   ("c" ("r" . "D3") ("v" "300"))
                   ("c" ("r" . "E3") ("v" "139999.89223"))
                   ("c" ("r" . "F3") ("v" "43361")))

                  ("row" ("r" . "4") ("spans" . "1:6")
                   ("c" ("r" . "A4") ("t" . "s") ("v" "6"))
                   ("c" ("r" . "B4") ("v" "300"))
                   ("c" ("r" . "C4") ("v" "500"))
                   ("c" ("r" . "D4") ("v" "400"))
                   ("c" ("r" . "E4") ("v" "23.34"))
                   ("c" ("r" . "F4") ("v" "43362"))))

                 ("phoneticPr" ("fontId" . "1") ("type" . "noConversion"))
                 ("pageMargins" ("left" . "0.7") ("right" . "0.7") ("top" . "0.75") ("bottom" . "0.75") ("header" . "0.3") ("footer" . "0.3"))
                 ("pageSetup" ("paperSize" . "9") ("orientation" . "portrait") ("horizontalDpi" . "200") ("verticalDpi" . "200") ("r:id" . "rId1")))])

      (call-with-input-file sheet_xml_file
        (lambda (p)
          (check-equal? (lists->xml xml)
                        (port->string p)))))
  )))

(run-tests test-xml)
