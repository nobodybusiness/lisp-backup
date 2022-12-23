(defun c:@studnie_nazwa ()
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
  (command "insert" "nazwa_studni" $pt "1" "1" "" $VAL_ZM)
  
  ;przesuniecie studni po wstawieniu
  (setq $studnia (entlast))
  (command "_move" $studnia ""  $pt pause)
  (princ)
)
