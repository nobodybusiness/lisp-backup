;wstawienia studni
(defun c:@STUDNIA_OZNACZENIE()
 (vl-load-com)
 (command "-insert" "studnia_blok" pause "0.5" "0.5" pause)
 (princ)
)
