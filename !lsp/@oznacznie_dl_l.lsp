(defun @oznaczenie_dl_przyl ()
  (if (setq $SS (ssget '((0 . "LWPOLYLINE"))))  ; przyjecie z zaznaczenie tylko plinii
    (progn
      (setq $line (ssname $ss 0))
      ;znajduje wszytskie pkt plinni i przypisuje je do listy
      (setq $plist (mapcar 'cdr
                           (vl-remove-if-not
                             '(lambda (x) (= (car x) 10))
                             (entget $line)
                           )
                   )
      )
      (setq $i 1)
      (setq $p_list_length (length $plist))
      (while $plist  ; petla przypisania wszystkich pkt
        (setq $i_string (rtos $i 2 0))
        (setq $name (read (strcat "$p" $i_string)))
        (set $name (car $plist))
        (setq $plist (cdr $plist))
        (setq $i (+ 1 $i))
      )
      (setq $n 1)
      (setq $dline_zm 0)
      (setq $dline1 0)
      (while (< $n $p_list_length)
        (setq $n_string (rtos $n 2 0))
        (setq $pA (vl-symbol-value (read (strcat "$p" $n_string))))
        (setq $n (+ 1 $n))
        (setq $n_string (rtos $n 2 0))
        (setq $pB (vl-symbol-value (read (strcat "$p" $n_string))))
        (setq $dline_zm (+ (fix (distance $pA $pB)) 1))
        (setq $dline1 (+ $dline1 $dline_zm))
      )
    )
  )
  (setq $angle (@RtD (angle $pB $pA)))  ; ustawienie obrotu tekstu zgodnie ze standardem
  (if (or
        (and (> $angle 90) (< $angle 180))
        (and (> $angle 180) (< $angle 270))
      )
    (setq $angle (- $angle 180))
  )
  (setq $dline2 (getint "D³ugoœc przy³¹cza (autom. +3):"))  ; podana z qgis
  (if (or (>= (- $dline2 $dline1) 25) (>= (- $dline1 $dline2) 25))
    (alert (strcat "Ró¿nica d³ugoœci ponad 25m\nQgis: " (rtos $dline2 2 0) "\nMapa: " (rtos $dline1 2 0)))
  )
  (if (> (- $dline2 $dline1) 10)
    (setq $dline (+ (fix (/ (+ $dline1 $dline2) 2)) 3))
    (progn
      (if (> $dline1 $dline2)        ; warunek sparwdzajacy wieksza dlugosc
        (setq $dline (+ 3 $dline1))  ;domyslne dodanie 3
        (setq $dline (+ 3 $dline2))
      )
    )
  )


    ;Sugeruj d³ugoœc z cada?
  (setq $otwr (getint "Liczba otworów:"))
  (if (= $otwr 0)
    (setq $otwr "")
  )
  (setq $wsp (mapcar '(lambda (x y) (+ (* 0.5 x) (* 0.5 y)))  ;dodaje polowy z listy punktow
                     $pA
                     $pB
             )
  )
  (command "-insert" "dl_linni" $wsp "" "" $angle "" "" "" "" "" "" "" $otwr $dline)  ;wstawia blok dlugosci linni
)
;=======Radians to Degrees======
(defun @RtD (r) (* 180.0 (/ r pi)))

