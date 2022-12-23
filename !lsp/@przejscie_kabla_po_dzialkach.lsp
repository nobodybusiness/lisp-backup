(defun C:@przejscie_kabla_po_dzialkach ()
  (setvar "CmdEcho" 0)
  (@area_for_pts)        ;odnalezienie pts dla zaznaczenia
  (command "_zoom" "e")  ; zoom na calosc, aby lapalo zaznaczenie wartosci z calego rysunku a nie tylko z "widoku"
  (@select_texts)        ;wyrzucenie danych z tekstow
  (setvar "CmdEcho" 1)
  (princ)                ;uwaga
)

(defun @area_for_pts ()
  (vl-load-com)
  (setq $area (entget (car (entsel))))  ;pobiera od uzytkownika zaznaczenie
  (setq $pts nil)
  (while
    (setq $zm_pt (assoc 10 $area))      ; odczytujemy pierwszy wiercho³ek
    (setq $pts (append $pts (list (cdr $zm_pt))))     ; dodajemy go do listy wynikowej
    (setq $area (cdr (member $zm_pt $area)))          ; "obcinamy" pocz¹tek listy za wyszukany element, by kolejny by³ wyszukany jako pierwszy.
  )
  (setq $tryb "jedn")
  (if (= (getstring "Tryb: all/jedn <jedn>") "all")
    (setq $tryb "all")
  )
)
(defun @select_texts ()
  (setq $seltexts (ssget "WP" $pts '((0 . "TEXT"))))  ; ustalenie obwiedni odczytania wynikow
  (setq $length_seltext (sslength $seltexts))         ;ilosc elementow zaznaczenia
  (setq $n 0)          ; wartosc poczatkowa n elementu
  (setq $datalist "")  ; usuniecie wartosci z datalist
  (while (< $n $length_seltext)
    (setq $el (ssname $seltexts $n))        ; odczyt nazwy n elementu z obiedni
    (command "_zoom" "_object" $el "")      ;            ;zoom na nty elem
    (command "_zoom" "_s" "0.02")           ;oddalenie widoku od elementu
    (command "_chprop" $el "" "_c" "7" "")  ;obecnie edytowany element na bialo
    
    (if (= $tryb "all")
      (progn
        (setq $data (cdr (assoc 1 (entget $el))))       ; odczyt tekstu n elementu
        (setq $n (+ $n 1))
        (setq $datalist (strcat $data "\n" $datalist))  ;dodanie do listy wynikow
        (command "_chprop" $el "" "_c" "5" "")          ;obecnie edytowany element na niebiesko
      )
      (progn
        (initget "Y N Z _YES NO UNDO")
        (setq $option (getkword "\nCzy dodac dzialke do wykazu?(Y/N/Z) <NO>"))  ;potwierdzenie czy przechodzi, jak nie to powrot
        (if (= $option "YES")  ;jezeli dodac do obiektow
          (
            progn
            (setq $data (cdr (assoc 1 (entget $el))))       ; odczyt tekstu n elementu
            (setq $n (+ $n 1))
            (setq $datalist (strcat $data "\n" $datalist))  ;dodanie do listy wynikow
            (command "_chprop" $el "" "_c" "5" "")          ;obecnie edytowany element na niebiesko
          )
          (if (= $option "UNDO")  ; jezeli cofnac o krok
            (progn
              (setq $n (- $n 1))
              (command "_chprop" $el "" "_c" "bylayer" "")  ;przywraca kolor by layer
            )
            (progn  ; else - domyslnie nie dodawac do obiektow
              (setq $n (+ $n 1))
              (command "_chprop" $el "" "_c" "1" "")  ;obecnie edytowany element na czerwono
            )
          )
        )
      )
    )
  )
    (princ "\nDzialki w obwiedni:\n")
    (princ $datalist)  ; wyrzucenie wynikow
    ;
  )

  (defun c:@pokaz_liste_dzialek ()
    (alert $datalist)
  )
