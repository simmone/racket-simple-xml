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
      (check-equal? (hash-ref xml_hash "worksheet.xmlns") "http://schemas.openxmlformats.org/spreadsheetml/2006/main")
      (check-equal? (hash-ref xml_hash "worksheet.xmlns:r") "http://schemas.openxmlformats.org/officeDocument/2006/relationships")

      ;; 3
      (check-equal? (hash-ref xml_hash "worksheet.dimension") "")
      (check-equal? (hash-ref xml_hash "worksheet.dimension's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.dimension.ref") "A1:F4")

      ;; 6
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView's count") 1)

      ;; 8
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.selection's count") 3)
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.selection1") "")
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.selection1.pane") "bottomLeft")
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.selection2") "")
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.selection2.pane") "topRight")
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.selection3") "")
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.selection3.pane") "bottomRight")

      ;; 15
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.workbookViewId") "0")
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane") "")
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane.ySplit") "1")
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane.xSplit") "1")
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane.topLeftCell") "B2")
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane.activePane") "bottomRight")
      (check-equal? (hash-ref xml_hash "worksheet.sheetViews.sheetView.pane.state") "frozen")

      ;; 23
      (check-equal? (hash-ref xml_hash "worksheet.sheetFormatPr") "")
      (check-equal? (hash-ref xml_hash "worksheet.sheetFormatPr's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetFormatPr.defaultRowHeight") "13.5")

      ;; 26
      (check-equal? (hash-ref xml_hash "worksheet.cols's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.cols.col's count") 4)

      ;; 28
      (check-equal? (hash-ref xml_hash "worksheet.cols.col1") "")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col1.min") "1")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col1.max") "2")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col1.width") "50")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col2") "")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col2.min") "3")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col2.max") "4")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col2.width") "8")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col3") "")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col3.min") "5")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col3.max") "5")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col3.width") "14")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col4") "")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col4.min") "6")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col4.max") "6")
      (check-equal? (hash-ref xml_hash "worksheet.cols.col4.width") "8")

      ;; 44
      (check-equal? (hash-ref xml_hash "worksheet.sheetData's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row's count") 4)

      ;; 46
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.r") "1")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.spans") "1:6")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c's count") 6)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c1.r") "A1")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c1.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c1.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c1.v") "16")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c2.r") "B1")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c2.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c2.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c2.v") "1")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c3.r") "C1")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c3.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c3.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c3.v") "2")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c4.r") "D1")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c4.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c4.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c4.v") "3")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c5.r") "E1")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c5.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c5.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c5.v") "4")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c6.r") "F1")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c6.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c6.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row1.c6.v") "5")

      ;; 73
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.r") "2")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.spans") "1:6")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c's count") 6)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c1.r") "A2")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c1.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c1.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c1.v") "8")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c2.r") "B2")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c2.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c2.v") "100")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c3.r") "C2")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c3.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c3.v") "300")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c4.r") "D2")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c4.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c4.v") "200")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c5.r") "E2")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c5.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c5.v") "0.6934")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c6.r") "F2")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c6.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row2.c6.v") "43360")

      ;; 95
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.r") "3")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.spans") "1:6")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c's count") 6)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c1.r") "A3")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c1.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c1.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c1.v") "13")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c2.r") "B3")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c2.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c2.v") "200")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c3.r") "C3")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c3.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c3.v") "400")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c4.r") "D3")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c4.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c4.v") "300")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c5.r") "E3")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c5.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c5.v") "139999.89223")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c6.r") "F3")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c6.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row3.c6.v") "43361")

      ;; 117
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.r") "4")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.spans") "1:6")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c's count") 6)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c1.r") "A4")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c1.t") "s")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c1.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c1.v") "6")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c2.r") "B4")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c2.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c2.v") "300")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c3.r") "C4")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c3.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c3.v") "500")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c4.r") "D4")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c4.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c4.v") "400")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c5.r") "E4")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c5.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c5.v") "23.34")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c6.r") "F4")
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c6.v's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.sheetData.row4.c6.v") "43362")

      ;; 139
      (check-equal? (hash-ref xml_hash "worksheet.phoneticPr's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.phoneticPr") "")
      (check-equal? (hash-ref xml_hash "worksheet.phoneticPr.fontId") "1")
      (check-equal? (hash-ref xml_hash "worksheet.phoneticPr.type") "noConversion")

      ;; 143
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins") "")
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.left") "0.7")
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.right") "0.7")
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.top") "0.75")
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.bottom") "0.75")
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.header") "0.3")
      (check-equal? (hash-ref xml_hash "worksheet.pageMargins.footer") "0.3")

      ;; 151
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup's count") 1)
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup") "")
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup.paperSize") "9")
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup.orientation") "portrait")
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup.horizontalDpi") "200")
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup.verticalDpi") "200")
      (check-equal? (hash-ref xml_hash "worksheet.pageSetup.r:id") "rId1")
      
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
