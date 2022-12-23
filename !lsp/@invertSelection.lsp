;odrocenie zaznaczenie (usun wszystko poza zaznaczonym obszarem)
(defun c:@invertSelection ()
  (vl-load-com)
  (setq $area (entget (car (entsel))))  ;pobiera od uzytkownika zaznaczenie
  (setq $pts nil)
  (while
    (setq $zm_pt (assoc 10 $area))      ; odczytujemy pierwszy wiercho�ek
    (setq $pts (append $pts (list (cdr $zm_pt))))  ; dodajemy go do listy wynikowej
    (setq $area (cdr (member $zm_pt $area)))       ; "obcinamy" pocz�tek listy za wyszukany element, by kolejny by� wyszukany jako pierwszy.
  )
  (setq ssBox (ssget "CP" $pts))  ; ustalenie obwiedni odczytania wynikow

  (setq ssAll (ssget "_A" ))

  (command "_copybase" "0,0,0" ssBox "")
  (command "_erase" ssAll "")
  (command "_pasteblock" "0,0,0" )
  (command "_explode" (entlast))
)
