;zamiana numeracji na wskazana
(defun c:@OPP_OSD_OKH_OKW ()
  (vl-load-com)
  (setq $OPP_OSD_OKH_OKW "C:/Users/Desktop/Piotr P/test/OPP_OSD_OKH_OKW/")
  (setq $data nil)
  (setq $filepath $OPP_OSD_OKH_OKW)  ; ustawia sciezke do folderu mieszkan
  (setq $fl (open (strcat $filepath "OPP_OSD_OKH_OKW.txt") "r"))  ; otwarcie do odczytania pliku z danymi
  (while (setq $fil (read-line $fl))           ;petla do odczytu linni
    (if (not (null $fil))
      (setq $data (append $data (list $fil)))  ; przypisanie  danych do listy
    )
  )
  (close $fl)  ; zamkniecie pliku txt

	;MTEXT
  (setq ss (ssget "x" '((0 . "mtext"))))
  (setq i 0)
  (while (< i (sslength ss))
    (setq $tempData $data)
    ;**********************
    (while $tempData
      (setq alternativeAssoc 0)  ;na wypadek wiekszej ilosci znakow
      (setq $ent_ename (ssname ss i))
      (setq $ent_data (entget $ent_ename))
      (setq $text (cdr (assoc '1 $ent_data)))  ;szczytanie tekstu
      (setq $textAlternative (cdr (assoc '3 $ent_data)))

      (setq textToChange (car $tempData))
      (setq textToChange (vl-string-left-trim "\"" textToChange))
      (setq textToChange (vl-string-right-trim "\"" textToChange))
      (setq $tempData (cdr $tempData))

      (setq textToInsert (car $tempData))
      (setq textToInsert (vl-string-left-trim "\"" textToInsert))
      (setq textToInsert (vl-string-right-trim "\"" textToInsert))
      (setq $tempData (cdr $tempData))

      (if (= $text nil)
        ()  ;do nothing
        (progn
          (setq $newText (vl-string-subst textToInsert textToChange $text))
          (setq $VAL (subst (cons 1 $newText) (assoc 1 $ent_data) $ent_data))
          (entmod $VAL)
          (entupd $ent_ename)
        )
      )
      (if (= $textAlternative nil)
        ()  ;do nothing
        (progn
          (setq $newTextAlternative (vl-string-subst textToInsert textToChange $textAlternative))
          (setq $VAL (subst (cons 1 $newTextAlternative) (assoc 3 $ent_data) $ent_data))
          (entmod $VAL)
          (entupd $ent_ename)
        )
      )
    )
    ;**********************
    (setq i (+ i 1))
  )
	;ARROW
  (setq ss (ssget "X" '((0 . "MULTILEADER"))))
  (setq i 0)
  (while (< i (sslength ss))
    (setq $tempData $data)
    ;**********************
    (while $tempData
      (setq alternativeAssoc 0)  ;na wypadek wiekszej ilosci znakow
      (setq $ent_ename (ssname ss i))
      (setq $ent_data (entget $ent_ename))
      (setq $text (cdr (assoc 304 $ent_data)))  ;szczytanie tekstu

      (setq textToChange (car $tempData))
      (setq textToChange (vl-string-left-trim "\"" textToChange))
      (setq textToChange (vl-string-right-trim "\"" textToChange))
      (setq $tempData (cdr $tempData))

      (setq textToInsert (car $tempData))
      (setq textToInsert (vl-string-left-trim "\"" textToInsert))
      (setq textToInsert (vl-string-right-trim "\"" textToInsert))
      (setq $tempData (cdr $tempData))

      (setq $newText (vl-string-subst textToInsert textToChange $text))
      (setq $VAL (subst (cons 304 $newText) (assoc 304 $ent_data) $ent_data))
      (entmod $VAL)
      (entupd $ent_ename)
    )
    ;**********************
    (setq i (+ i 1))
  )
)
