(defun c:st ()
  (vl-load-com)
  (setq $blk nil)
  (setq $blk (ssget '((0 . "INSERT") (2 . "numeracja_blok"))))
  (setq $ent (ssname $blk 0))
  (setq $name "none")
  (setq $name (cdr (assoc '0 (entget $ent))))
  (while (not (equal $name "SEQEND"))  ; asystent
    (setq $LST (entget $ent))
    (setq $attag (cdr (assoc '2 $LST)))
    (setq $attag (strcase $attag))
    (if (= $attag "ULICA")
      (setq $VAL_ZM (CDR (assoc 1 $LST)))
    )
    (setq $ent (entnext $ent))
    (setq $name (cdr (assoc '0 (entget $ent))))
  )
  (setq $pt (getpoint "Pkt wstawienia:"))
  
  ;test isSlup?
  (if (= isSlup 1)
    (setq variable "nazwa_slupa_v1")
    (setq variable "nazwa_studni_v2")
  )
  
  (command "insert" variable $pt "1" "1" "")
  (setq $studnia (entlast))
	(command "_explode" $studnia)
	(setq $studnia (entlast))

	;*******************
  (setq $ent_data (entget $studnia))
  (setq $text (cdr (assoc 1 $ent_data)))

  (setq textToChange "#nazwaStudni")

  (setq textToInsert $VAL_ZM)

  (setq $newText (vl-string-subst textToInsert textToChange $text))
  (setq $VAL (subst (cons 1 $newText) (assoc 1 $ent_data) $ent_data))
  (entmod $VAL)
  (entupd $studnia)

	;*******************

  ;przesuniecie studni po wstawieniu
  ;(setq $studnia (entlast))
  (command "_move" $studnia "" $pt pause)
  (princ)
)
(defun c:sl()
  (setq isSlup 1)
  (c:st)
  (setq isSlup 0)
)
