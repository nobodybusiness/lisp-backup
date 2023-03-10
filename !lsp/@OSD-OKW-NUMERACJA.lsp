(defun c:@OSD_OKW_NUMERACJA_ARROW ()
  (vl-load-com)
  (setq ss (ssget))
  (setq i 0)
  (setq osdOrOkw (getint "OSD <1> OKW <2>"))
  (setq startingOSDprefix (getstring "OSD_OKW_Prefix: "))
  (setq startingOSDnumber (getreal "OSD_OKW: "))

  (if (= osdOrOkw 1)
    (setq osdOrOkwText "OSD")
  )
  (if (= osdOrOkw 2)
    (setq osdOrOkwText "OKW")
  )
  (while (< i (sslength ss))
    (setq currentOSDnumber (+ startingOSDnumber i))
    (setq currentOSD (strcat startingOSDprefix (rtos currentOSDnumber 2 0)))
    (setq $ent_ename (ssname ss i))
    (setq $ent_data (entget $ent_ename))
    (setq $text (cdr (assoc 304 $ent_data)))
    (setq x1 (strcat osdOrOkwText currentOSD))
    (setq $newText (vl-string-subst x1 (strcat osdOrOkwText "_") $text))
    (setq $VAL (subst (cons 304 $newText) (assoc 304 $ent_data) $ent_data))
    (entmod $VAL)
    (entupd $ent_ename)
    (setq i (+ i 1))
  )
)
(defun c:@OSD_OKW_NUMERACJA_MTEXT ()
	;DODAC WERSJE DLA BUDYNKOW, A NIE WEERSJI S
  (vl-load-com)
  (setq ss (ssget))
  (setq i 0)
  (setq startingOSDprefix (getstring "OSD_Prefix: "))
  (setq startingOSDnumber (getreal "OSD: "))
  (setq startingOKWprefix (getstring "OKW_Prefix: "))
  (setq startingOKWnumber (getreal "OKW: "))

  (while (< i (sslength ss))
    (setq alternativeAssoc 0)
    (setq currentOSDnumber (+ startingOSDnumber i))
    (if (/= startingOKWnumber nil)
      (setq currentOKWnumber (+ startingOKWnumber i))
      (setq currentOKWnumber "")
    )
    (setq currentOSD (strcat startingOSDprefix (rtos currentOSDnumber 2 0)))
    (if (/= startingOKWnumber nil)
      (setq currentOKW (strcat startingOKWprefix (rtos currentOKWnumber 2 0)))
      (setq currentOKW startingOKWprefix)
    )
    (setq $ent_ename (ssname ss i))
    (setq $ent_data (entget $ent_ename))
    (setq $text (cdr (assoc '1 $ent_data)))
    (if (/= (vl-string-search "OSD_" $text) 0)
      (progn
        (setq $text (cdr (assoc '3 $ent_data)))
        (setq alternativeAssoc 1)
      )
    )
    (setq x1 (strcat "OSD" currentOSD))
    (setq x2 (strcat "OKW" currentOKW))
    (setq $newText (vl-string-subst x1 "OSD_" $text))
    (setq $newText2 (vl-string-subst x2 "OKW_" $newText))
    (if (/= alternativeAssoc 1)
      (setq $VAL (subst (cons 1 $newText2) (assoc 1 $ent_data) $ent_data))
      (setq $VAL (subst (cons 1 $newText2) (assoc 3 $ent_data) $ent_data))
    )
    (entmod $VAL)
    (entupd $ent_ename)
    (setq i (+ i 1))
  )
)
