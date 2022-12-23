
;numeracja pkt adresowych wyrzuconych z qgis
(defun @numeracja_dzialek (/ $filepath $fil $fl $data $el $x $y $HH $LU $UL $NR $liczba $wsp)
 (vl-load-com)
  (setq $lsp_adress_num "C:/Users/Desktop/test/Signaline/automatyczna numeracja dzialek")
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
;=======HOUSE HOLDY=============
    (setq $el (car $data))    ; odczyt wspl HH
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $HH (atof $el))
    (setq $data (cdr $data))  ; skrocenie listy o HH
;=======LOKALE USLUGOWE=============
    (setq $el (car $data))    ; odczyt wspl LU
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $LU (atof $el))
    (setq $data (cdr $data))  ; skrocenie listy o LU
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
    (setq $UL (strcat "ul. " $UL " " $NR))
    (setq $NR "")
    (if (= $HH 0)             ; jezeli 0 HH
      (progn
        (setq $liczba (rtos $LU))
        (setq $liczba (strcat "HH:" $liczba "LU"))
      )
      (progn
        (if (= $LU 0)         ;jezeli 0 LU
          (progn
            (setq $liczba (rtos $HH))
            (setq $liczba (strcat "HH:" $liczba))
          )
          (progn              ; jezeli HH i Lu <>0
            (setq $liczba (rtos $HH))
            (setq $liczba (strcat "HH:" $liczba " LU:" (RTOS $LU)))
          )
        )
      )
    )
    (command "-insert" "numeracja_blok_2" $wsp "" "" "" $liczba $UL)
    ;(command "_explode" "_l")  ; explode tabelki
  )
)
