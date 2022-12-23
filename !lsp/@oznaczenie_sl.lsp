;oznaczenie slupowe
(defun @oznacz_kier_sl ()
  (vl-load-com)
  (setq $p1 (getpoint "Pocz�tek;"))     ;poczatek linni
  (setq $p2 (getpoint "Koniec:"))       ;koniec linni
  (setq $angle (- (@RtD (angle $p1 $p2)) 90))  ; ustawienie obrotu tekstu zgodnie ze standardem
  (command "-insert" "kierunek_blok" $p1 "" "" $angle)
  (setq $angle (+ $angle 180))
  (command "-insert" "kierunek_blok" $p2 "" "" $angle)
)
