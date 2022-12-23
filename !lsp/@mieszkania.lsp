;generowanie schematu mieszkn z txt
(setq $lsp_adress_mieszkania "C:/Users/Desktop/Piotr P/test/uklad mieszkan/")

(defun @blok_tabelka (x)
  (vl-load-com)
  (command "-insert" "tabelka_blok" x "" "" "")  ;wstawia blok tabelki
  (command "_explode" "_l")  ; explode tabelki
)
(defun c:@wstawienie_blokow ()
  (vl-load-com)
  (setq $pigtail_z_innych 0)
  (setq a "0,0")
  (setq b "900,0,0")        ; PRZESUNIECIE
  (@blok_tabelka a)
  (setq $filepath $lsp_adress_mieszkania)  ; ustawia sciezke do folderu mieszkan
  (setq $fl (open (strcat $filepath "mieszkania.txt") "r"))  ; otwarcie do odczytania pliku z danymi
  (while (setq $fil (read-line $fl))           ;petla do odczytu linni
    (if (not (null $fil))
      (setq $data (append $data (list $fil)))  ; przypisanie  danych do listy
    )
  )
  (close $fl)  ; zamkniecie pliku txt
  (setq $zm_przel (getint "\nNumer pierwszej prze��cznicy:"))  ; numer pierwszej przelaczicy
;===Ustalenie na ile w��kien jest projektowane========
  (setq $zm_ilosci_wlokien (getint "\nProjektowane na 200%/100%/120%/70% <100%>:"))  ; +odczyt z excela!
  (if (= $zm_ilosci_wlokien 200)
    (setq $zm_ilosci_wlokien 1.999)
    (if (= $zm_ilosci_wlokien 70)
      (setq $zm_ilosci_wlokien 0.699)
      (setq $zm_ilosci_wlokien 0.999)
    )
  )
 ;==============================
  (setq $start_ilo_lu 0)
  (while $data  ; petla przypisania danych z list do zmiennych
    (@blok_tabelka b)
    (if (= (car $data) "\"+\"")   ; warunek: przeskok do nastepnej klatki
      (progn
        (setq $data (cdr $data))
        (setq $data (cdr $data))
        (setq $data (cdr $data))
        (setq $data (cdr $data))
        (setq $data (cdr $data))  ;!dodatkowo na mufe
        (setq $data (cdr $data))  ; usunjiecie znaku + i calej linni z excela
        (command "_.move" "_all" "" "_d" "-9blade00,0,0" "")
        (setq $wsp_x (- $wsp_x 50))
      )
    )
;=======HH=============
    (setq $el (car $data))        ; odczyt wspl HH
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $HH (atof $el))         ; string to real
    (setq $data (cdr $data))      ; skrocenie listy o HH
;=======LU=============
    (setq $el (car $data))        ; odczyt wspl LU
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $LU (atof $el))         ; string to real
    (setq $data (cdr $data))      ; skrocenie listy o LU
;=======1ST NUMBER=============
    (setq $el (car $data))        ; odczyt 1st NR
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $NR (atof $el))         ; string to real
    (setq $data (cdr $data))      ; skrocenie listy o NR
;=======last NUMBER=============
    (setq $el (car $data))        ; odczyt LNR
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $LNR (atof $el))        ; string to real
    (setq $data (cdr $data))      ; skrocenie listy o LNR
;=======LVL=============
    (setq $el (car $data))        ; odczyt wspl LVL
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $LVL (atof $el))        ; string to real
    (setq $data (cdr $data))      ; skrocenie listy o LVL
;=======MUFA=============
    (setq $el (car $data))        ; odczyt wspl MUFA
    (setq $el (vl-string-left-trim "\"" $el))
    (setq $el (vl-string-right-trim "\"" $el))
    (setq $MUFA (atof $el))       ; string to real
    (setq $data (cdr $data))      ; skrocenie listy o MUFA
;=======KONIEC PRZYPISANIA DANYCH JEDNEGO POZIOMU=============

;=======WSP STARTOWE====================
    (setq $wsp_star_x 50)
    (setq $wsp_star_y (+ 250 (* $LVL 50)))  ; w zaleznosci od pierwszego pietra z danymi
    (setq $wsp (strcat (rtos $wsp_star_x) "," (rtos $wsp_star_y)))  ; zmiana na wspl zg z zapisem cad

;=======BLOK MIESZKAN===================
    (setq i 1)            ; zmienna przesuniecia x
    (while (<= $NR $LNR)  ;petla sprawdzajaca numer mieszkania od 1st do ostatniego
      (command "-insert" "mieszkania_blok" $wsp "" "" "" $NR)  ;wstawia blok mieszkan
      (setq $wsp_x (+ $wsp_star_x (* i 50)))  ; przesuniecie po 50 co mieszkanie
      (setq $wsp (strcat (rtos $wsp_x) "," (rtos $wsp_star_y)))
      (setq i (+ i 1))
      (setq $NR (+ $NR 1))
    )
;=======LOKALE USLUGOWE=================
    (if (= $LU 0)            ; warunek obecnosci LU
      (princ)                ; do_nothing
      (progn
        (setq $zm_lokale 1)  ; startowa watrosc zmiennej lokali
        (while (<= $zm_lokale $LU)  ;petla lokali
          (setq $zm_nazwa_uslugi (strcat "U" (rtos (+ $zm_lokale $start_ilo_lu))))  ; przypisanie zmiennej nazwy dla uslug
          (command "-insert" "uslugi_blok" $wsp "" "" "" $zm_nazwa_uslugi)          ;wstawia blok lu
          (setq $wsp_x (+ $wsp_star_x (* i 50)))    ; przesuniecie po 50 co blok
          (setq $wsp (strcat (rtos $wsp_x) "," (rtos $wsp_star_y)))
          (setq i (+ i 1))
          (setq $zm_lokale (+ $zm_lokale 1))
        )
        (setq $start_ilo_lu (+ $start_ilo_lu $LU))  ; zmiana poczatku numeracji LU dla nastepnych poziomow
      )
    )

;=========BLOK PRZELOCZNIC MIESZKANIOWYCH======
    (if (= $HH 0)  ; sprawdzenie czy istnieja HH na poziomie
      (princ)
      (progn
        (if (= $zm_ilosci_wlokien 1.199)  ; zmiana dla 70/120 %
          (setq $zm_ilosci_wlokien 0.699)
        )
        (if (= $zm_ilosci_wlokien 1.999)  ; zmiana dla 70/120 %
          (setq $zm_ilosci_wlokien 1.999)
        )
        (setq j 1)       ; zmienna przesuniecia w kierunku y
        (if (= $MUFA 0)  ; warunek istnienia mufy na poziomie
          (progn
            (setq $pigtail_z_innych (+ $pigtail_z_innych $HH))  ; zachowanie do pozniejszego wykorzystania
            (setq $l_przel_msk 0)
          )
          (progn
            (setq $HH (+ $HH $pigtail_z_innych))  ; wykorzystanie z innych poziom�w
            (setq $pigtail_z_innych 0)
            (setq $l_przel_msk (+ 1 (fix (* $zm_ilosci_wlokien $HH))))  ; liczba przel mieszkaniowych na poziomach
          )
        )
        (setq $max_przel_msk (- (+ $zm_przel $l_przel_msk) 1))
        (while (<= $zm_przel $max_przel_msk)  ;petla
          (command "-insert" "przel_mieszk_blok" $wsp "" "" "" $zm_przel)  ;wstawia blok przelacznic

          (if (= j 1)  ; zmienne po y
            (progn
              (setq $wsp_y (+ $wsp_star_y (* j 25)))
              (setq $wsp (strcat (rtos $wsp_x) "," (rtos $wsp_y)))
              (setq $zm_przel (+ $zm_przel 1))
              (setq j 0)
            )
            (progn
              (setq $wsp_x (+ $wsp_x 25))
              (setq $wsp_y (+ $wsp_star_y (* j 25)))
              (setq $wsp (strcat (rtos $wsp_x) "," (rtos $wsp_y)))
              (setq $zm_przel (+ $zm_przel 1))
              (setq j 1)
            )
          )
        )
      )
    )
;======BLOK PRZELACZNIC USLUGOWYCH==========
;! JESZCZE JAKIS BLAD - PIERWSZA PRZELACZNICA ZLE SIE WSTAWIA
    (if (= $LU 0)      ; warunek obecnosci LU
      (princ)          ; do_nothing
      (progn
        (if (= $zm_ilosci_wlokien 0.699)  ; zmiana 70/120%
          (setq $zm_ilosci_wlokien 1.199)
        )
        (if (= $zm_ilosci_wlokien 0.999)  ; zmiana dla 70/120 %
          (setq $zm_ilosci_wlokien 0.999)
        )
        ;(if (= $MUFA 0)  ; warunek istnienia mufy na poziomie
        ; (progn
        ;  (setq $pigtail_z_innych_LU (+ $pigtail_z_innych_LU $LU))  ; zachowanie do pozniejszego wykorzystania
        ; (setq $l_przel_usl 0)
        ;)
        ;(progn
        ; (setq $LU (+ $LU $pigtail_z_innych_LU))  ; wykorzystanie z innych poziom�w
        ;(setq $pigtail_z_innych_LU 0)
        (setq $l_przel_usl (+ 1 (fix (* $zm_ilosci_wlokien $LU))))  ; liczba przel USL na poziomach
        ;)
        ;)
        (setq $max_przel_usl (- (+ $zm_przel $l_przel_usl) 1))
        (setq j 1)  ; pierwsze przesuniecie w y
        (while (<= $zm_przel $max_przel_usl)  ;petla
          (command "-insert" "przel_uslugi_blok" $wsp "" "" "" $zm_przel)  ;wstawia blok przelacznic

          (if (= j 1)  ; zmienne po y
            (progn
              (setq $wsp_y (+ $wsp_star_y (* j 25)))
              (setq $wsp (strcat (rtos $wsp_x) "," (rtos $wsp_y)))
              (setq $zm_przel (+ $zm_przel 1))
              (setq j 0)
            )
            (progn
              (setq $wsp_x (+ $wsp_x 25))
              (setq $wsp_y (+ $wsp_star_y (* j 25)))
              (setq $wsp (strcat (rtos $wsp_x) "," (rtos $wsp_y)))
              (setq $zm_przel (+ $zm_przel 1))
              (setq j 1)
            )
          )
        )
      )
    )
  )
;===========overkill============
  (command "-overkill" "_all" "" "_T" "_N" "_E" "_N" "_P" "_N" "")

)
(defun C:@opisy_1 ()
  (setq $pkt_wst (getpoint "PKT wstawienia:"))
  ;(setq $nr_osd (getstring "Numer OSD:<_>"))
  ;(if (= $nr_osd "")
    ;(setq $nr_osd "_")
 ; )
  ;(setq $nr_OKW (getstring "Numer OKW:<_>"))
  ;(if (= $NR_OKW "")
   ; (setq $NR_OKW "_")
 ; )
  (setq $nr_osd "_")
  (setq $nr_OKW "_")
  (setq $wlokna_okw (getstring "W�okna OKW: <2X6>"))
  (if (= $wlokna_okw "")
    (setq $wlokna_okw "2X6")
  )
  (setq $WLOKNA_W_KABLU (getstring "W�okna w kablu: <_-_>"))
  (if (= $WLOKNA_W_KABLU "")
    (setq $WLOKNA_W_KABLU "_-_")
    (setq $WLOKNA_W_KABLU (strcat "1-" $WLOKNA_W_KABLU))
  )
  (setq $IL_wlokna_okw
    (cond
      ((= $wlokna_okw "2X6") "12")
      ((= $wlokna_okw "4X4") "16")
      ((= $wlokna_okw "2X12") "24")
      ((= $wlokna_okw "4X6") "24")
      ((= $wlokna_okw "4X8") "32")
      ((= $wlokna_okw "3X12") "36")
      ((= $wlokna_okw "4X12") "48")
      ((= $wlokna_okw "8X6") "48")
      ((= $wlokna_okw "8X8") "64")
      ((= $wlokna_okw "6X12") "72")
      ((= $wlokna_okw "12X6") "72")
      ((= $wlokna_okw "10X8") "80")
      ((= $wlokna_okw "8X12") "96")
      ((= $wlokna_okw "12X12") "144")
      ((/= $wlokna_okw NIL) "?")
    )
  )
  (setq $tekst1 (strcat "OSD" $nr_osd "/OKW" $NR_OKW "/" $il_wlokna_okw "J_(" $WLOKNA_W_KABLU ")"))
  (setq $tekst2 (strcat "HPC_1626_CT_" $wlokna_okw "G657"))
  (command "-insert" "osd" $pkt_wst "" "" "" $tekst1 $tekst2 "")  ;wstawia blok osd - multiline
)

(defun C:@opisy_2 ()
  ;dodaj petle od danego wlokna ile wlokien -> automat numeru tuby!
  ;(setq $pkt_wst (getpoint "PKT wstawienia:"))
  (setq $poziom (getstring "Poziom:"))
  (if (= $poziom "0")
    (setq $poziom "parter")
    (setq $poziom (strcat "pi�tro " $poziom))
  )
  (setq $liczba_tub (getint "Liczba tub<1>"))
  (if (= $liczba_tub nil)
    (setq $liczba_tub 1)
  )
  (setq $od_tub (getint "od tuby<1>"))
  (if (= $od_tub nil)
    (setq $od_tub 1)
  )
  (setq $color_tuba "")
  (setq krotnosc_tuby (getint "krotnosc tuby"))
  (repeat $liczba_tub
    (setq $tuba $od_tub)
    (setq $color_tuba_zm
      (cond
        ((= $tuba 1) ", Tuba 1, Cz, w�. ")
        ((= $tuba 2) ", Tuba 2, Ni, w�. ")
        ((= $tuba 3) ", Tuba 3, Bi, w�. ")
        ((= $tuba 4) ", Tuba 4, Zi, w�. ")
        ((= $tuba 5) ", Tuba 5, Fi, w�. ")
        ((= $tuba 6) ", Tuba 6, Po, w�. ")
        ((= $tuba 7) ", Tuba 7, Sz, w�. ")
        ((= $tuba 8) ", Tuba 8, Zo, w�. ")
        ((= $tuba 9) ", Tuba 9, Br, w�. ")
        ((= $tuba 10) ", Tuba 10, Ro, w�. ")
        ((= $tuba 11) ", Tuba 11, Ca, w�. ")
        ((= $tuba 12) ", Tuba 12, Tu, w�. ")
      )
    )
    (setq $wlk_w_tubie_wl (strcat (rtos (+ (* (- $od_tub 1) krotnosc_tuby) 1) 2 0) "-" (rtos (* $od_tub krotnosc_tuby) 2 0)))  ;;(getstring (strcat "wl w�okna w tubie " (rtos $od_tub 2 0) "<od-do>")))
    (if (= $liczba_tub 1)
      (setq $color_tuba (strcat $color_tuba $color_tuba_zm $wlk_w_tubie_wl))
      (setq $color_tuba (strcat $color_tuba $color_tuba_zm $wlk_w_tubie_wl))
    )
    (setq $od_tub (+ 1 $od_tub))
  )
  (vl-load-com)
  (setq $il_mieszk nil)
  (setq $ile_mieszk (ssget '((0 . "INSERT") (2 . "mieszkania_blok"))))
  (setq $i 0)
  (setq $ile_mieszk_length (sslength $ile_mieszk))
  (setq $VAL 0)
  (setq $nr_miesz_min 999)
  (setq $nr_miesz_max 0)
  (setq $nr_dodat "")
  (while (< $i $ile_mieszk_length)
    (setq $ent (ssname $ile_mieszk $i))
    (setq $name "none")
    (setq $name (cdr (assoc '0 (entget $ent))))
    (while (not (equal $name "SEQEND"))
      (setq $LST (entget $ent))
      (setq $attag (cdr (assoc '2 $LST)))
      (setq $attag (strcase $attag))
      (if (= $attag "NUMER_MIESZKANIA")
        (setq $VAL (CDR (assoc 1 $LST)))
      )
      (setq $ent (entnext $ent))
      (setq $name (cdr (assoc '0 (entget $ent))))
    )
    (setq $VAL_ZM (atoi $VAL))
    (if (/= (rtos $val_zm 2 0) $VAL)
      (setq $nr_dodat (strcat $nr_dodat ", " $VAL))
    )
    (setq $nr_miesz_min
      (if (< $VAL_ZM $nr_miesz_min)
        (progn
          $VAL_ZM
        )
        (progn
          $nr_miesz_min
        )
      )
    )
    (setq $nr_miesz_max
      (if (> $VAL_ZM $nr_miesz_max)
        (progn
          $VAL_ZM
        )
        (progn
          $nr_miesz_max
        )
      )
    )
    (setq $i (+ 1 $i))
    (setq $HH_z_i $i)
  )
  (setq $czy_LU (getint "czy LU?<1-tak,0-nie>"))
  (if (= $czy_LU 1)
    (@LU_do_opis)
    (progn
      ;(setq $tekst1 (strcat $poziom ", " "(lok. " (rtos $nr_miesz_min 2 0) "-" (rtos $nr_miesz_max 2 0) ") (liczba HH: " (rtos $i 2 0) ")"))

      (command "-insert" "osd_2" $pkt_wst "" "" "" $tekst1 $tekst2 $color_tuba "")
			
    )
  )
)
(defun c:@ile_HH_LU ()
  (vl-load-com)
  (setq $ile_mieszk nil)
  (setq $ile_mieszk (ssget '((0 . "INSERT") (2 . "mieszkania_blok"))))
  (if $ile_mieszk
    (setq $ile_mieszk_length (sslength $ile_mieszk))
    (setq $ile_mieszk_length 0)
  )
;=====================================
  (setq $ile_lu nil)
  (setq $ile_lu (ssget '((0 . "INSERT") (2 . "uslugi_blok"))))
  (if $ile_lu
    (setq $ile_lu_length (sslength $ile_lu))
    (setq $ile_lu_length 0)
  )
;=====================================
  (print (strcat (rtos $ile_mieszk_length 2 0) "HH+" (rtos $ile_lu_length) "LU"))
  (princ)

)
(defun c:@opis ()
  (C:@opisy_1)
  (c:@opisy_2)
)
(defun c:@licz_wkl ()
  (setq i 1)
  (setq $pocz_pigtail 1)
  (setq $ost_pigtail (getint "ost. pigtail:"))
  (setq $liczba_pigtaili (- (+ 1 $ost_pigtail) $pocz_pigtail))
  (setq $typ_kabla 12)
  (while (< (* i $typ_kabla) $liczba_pigtaili)
    (setq i (+ 1 i))
  )
  (setq i (- i 1))
  (setq $wlk_na_ost_tubie (- $liczba_pigtaili (* i $typ_kabla)))
  (setq $colorWkl
    (cond
      ((= $wlk_na_ost_tubie 1) " Cz.")
      ((= $wlk_na_ost_tubie 2) " Ni.")
      ((= $wlk_na_ost_tubie 3) " Bi.")
      ((= $wlk_na_ost_tubie 4) " Zi.")
      ((= $wlk_na_ost_tubie 5) " Fi.")
      ((= $wlk_na_ost_tubie 6) " Po.")
      ((= $wlk_na_ost_tubie 7) " Sz.")
      ((= $wlk_na_ost_tubie 8) " Zo.")
      ((= $wlk_na_ost_tubie 9) " Br.")
      ((= $wlk_na_ost_tubie 10) " Ro.")
      ((= $wlk_na_ost_tubie 11) " Ca.")
      ((= $wlk_na_ost_tubie 12) " Tu.")
    )
  )
  (setq $tubaNr (+ 1 i))
  (setq $colorTuba
    (cond
      ((= $tubaNr 1) " Cz. ")
      ((= $tubaNr 2) " Ni. ")
      ((= $tubaNr 3) " Bi. ")
      ((= $tubaNr 4) " Zi. ")
      ((= $tubaNr 5) " Fi. ")
      ((= $tubaNr 6) " Po. ")
      ((= $tubaNr 7) " Sz. ")
      ((= $tubaNr 8) " Zo. ")
      ((= $tubaNr 9) " Br. ")
      ((= $tubaNr 10) " Ro. ")
      ((= $tubaNr 11) " Ca. ")
      ((= $tubaNr 12) " Tu. ")
    )
  )
  (setq $specyfikacja_kabla (strcat
                              (rtos i 2 0)
                              " tub + "
                              (rtos $wlk_na_ost_tubie 2 0)
                              " wlk. na tubie "
                              (rtos (+ 1 i) 2 0)
                              $colortuba
                              "("
                              (rtos (- (* (+ 1 i) 12) 11) 2 0)
                              "-" (rtos (* (+ 1 i) 12) 2 0)
                              ")"
                              $colorWkl
                            )
  )
  (print $specyfikacja_kabla)
  (princ)
)

(defun @LU_do_opis ()
  (vl-load-com)
  (setq $il_LU nil)
  (setq $ile_LU (ssget '((0 . "INSERT") (2 . "uslugi_blok"))))
  (setq $i 0)
  (setq $ile_LU_length (sslength $ile_LU))
  (setq $string "")
  (while (< $i $ile_LU_length)
    (setq $ent (ssname $ile_LU $i))
    (setq $name "none")
    (setq $name (cdr (assoc '0 (entget $ent))))
    (while (not (equal $name "SEQEND"))
      (setq $LST (entget $ent))
      (setq $attag (cdr (assoc '2 $LST)))
      (setq $attag (strcase $attag))
      (if (= $attag "USLUGI_NUMER")
        (setq $string (strcat $string "," (CDR (assoc 1 $LST))))
      )
      (setq $ent (entnext $ent))
      (setq $name (cdr (assoc '0 (entget $ent))))
    )
    (setq $i (+ 1 $i))
  )
  (setq $tekst1 (strcat $poziom ", " "(lok. " (rtos $nr_miesz_min 2 0) "-" (rtos $nr_miesz_max 2 0) $string ") (liczba HH: " (rtos $HH_z_i 2 0) "+" (rtos $ile_LU_length 2 0) "LU" ")"))
  (setq $tekst2 (strcat $tekst2 $color_tuba))
  (command "-insert" "osd_2" $pkt_wst "" "" "" $tekst1 $tekst2 "")
	
)


