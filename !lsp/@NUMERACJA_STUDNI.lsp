;numeracja studni wyrzuconych z qgis
(defun c:@numeracja_studni (/ $filepath $fil $fl $data $el $x $y $HH $LU $UL $NR $liczba $wsp)
  (vl-load-com)
  (setq $lsp_adress_num "C:/Users/Desktop/Piotr P/test/automatyczna numeracja dzialek")
  (setq $filepath $lsp_adress_num)  ; ustawia sciezke do folderu z dwg
  (setq $fl (open (strcat $lsp_adress_num "/pts.txt") "r"))  ; otwarcie do odczytania pliku z danymi
  (while (setq $fil (read-line $fl))           ;petla do odczytu linni
    (if (not (null $fil))
      (setq $data (append $data (list $fil)))  ; przypisanie  danych do listy
    )
  )
  (close $fl)   ; zamkniecie pliku txt
  (while $data  ; petla przypisania danych z listy do zmiennych
;=======WSP X=============
    (setq $el (car $data))    ; odczyt wspl x
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $x (atof $el))
    (setq $data (cdr $data))  ; skrocenie listy o x
;=======WSP Y=============
    (setq $el (car $data))    ; odczyt wspl y
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $y (atof $el))
    (setq $data (cdr $data))  ; skrocenie listy o y
;=======ULICA=============
    (setq $el (car $data))    ; odczyt wspl UL
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $UL $el)
    (setq $data (cdr $data))  ; skrocenie listy o UL
;=======NUMER=============
    (setq $el (car $data))    ; odczyt wspl NR
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $NR $el)
    (setq $data (cdr $data))  ; skrocenie listy o NR
;=======Wstawienie bloku============
    (setq $x (rtos $x))
    (setq $y (rtos $y))
    (setq $wsp (strcat $x "," $y))

    (command "-insert" "numeracja_blok" $wsp "0.5" "0.5" "" "" $NR $UL)
    ;(command "_explode" "_l")  ; explode tabelki
  )
)
