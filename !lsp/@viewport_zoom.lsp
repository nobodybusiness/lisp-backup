(defun @viewport_zoom ()
  (command "mspace"
           "zoom" "_e"
           "zoom" "_ob" pause ""
  )
  (princ)
  (setq get (ssget "x" '((0 . "viewport") (-4 . ">") (69 . 1))))
  (setq $ent_ename (ssname get 0))
  (setq $ent_data (entget $ent_ename))
  (setq heightInPaper (cdr (assoc 41 $ent_data)))
  (setq viewHeight (cdr (assoc 45 $ent_data)))

  (setq scale (/ (* 0.2 viewHeight) heightInPaper))
  (command "zoom" "_s" scale)
  (command "._pspace")
)
