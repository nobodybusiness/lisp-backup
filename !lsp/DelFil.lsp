;; Modified by Chip Harper 09/24/03
;;
;; By R. ROBERT BELL
;;
;; Lisp s³u¿y do usuwania filtrów warstw.

(defun C:DelFil ()
 (vl-Load-Com)
 (vl-Catch-All-Apply '(lambda ()
                       (vla-Remove
                        (vla-GetExtensionDictionary
                         (vla-Get-Layers
                          (vla-Get-ActiveDocument
                           (vlax-Get-Acad-Object)))) "ACAD_LAYERFILTERS")))
 (prompt "\n...")
 (prompt "\n***All layer filters have been deleted!***")
 (princ)
)
; (C:LayerFiltersDelete)
; (princ)
