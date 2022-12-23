(defun @textalign ()
  (setq $line (entget (ssname (ssget '((0 . "LWPOLYLINE"))) 0)))
  (setq $text (ssname (ssget '((0 . "Mtext"))) 0))
  (setq $pA (cdr (assoc 10 $line)))
  (setq $pB (cdr (assoc 10 (reverse $line))))
  (setq $angle (- (@RtD (angle $pB $pA)) 90))  ; -90
  
  (LM:setattributevalue($text "rl@totation" rtos($angle 2 3)))
)
(defun changeAtributte (blk tag val / $ent $name)
    (setq $ent blk)
    (setq $name "none")
    (setq $name (cdr (assoc '0 (entget $ent))))
    (while (not (equal $name "SEQEND"))  ; SKALA
      (setq $LST (entget $ent))
      (setq $attag (cdr (assoc '2 $LST)))
      (setq $attag (strcase $attag))
      (if (= $attag "SKALA")
        (if (/= $SKALA "s")
          (progn
            (setq $VAL_new $SKALA)
            (setq $VAL (subst (cons 1 $VAL_new) (assoc 1 $LST) $LST))
            (entmod $VAL)
            (entupd $ent)
          )
        )
      )
    )
)
      
(defun LM:setattributevalue ( blk tag val / end enx )
    (while
        (and
            (null end)
            (setq blk (entnext blk))
            (= "ATTRIB" (cdr (assoc 0 (setq enx (entget blk)))))
        )
        (if (= (strcase tag) (strcase (cdr (assoc 2 enx))))
            (if (entmod (subst (cons 1 val) (assoc 1 (reverse enx)) enx))
                (progn
                    (entupd blk)
                    (setq end val)
                )
            )
        )
    )
)
