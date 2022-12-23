ql(defun c:@oznaczenie_dl_l_2 ()
  (vl-load-com)
  (if (setq $SS (ssget '((0 . "LWPOLYLINE"))))  ; przyjecie z zaznaczenie tylko plinii
    (progn
      (setq $i 0)
      (setq $line 0)
      (while $line
        (setq $line (ssname $ss $i))
        ;znajduje wszytskie pkt plinni i przypisuje je do listy
        (setq $plist (mapcar 'cdr
                             (vl-remove-if-not
                               '(lambda (x) (= (car x) 10))
                               (entget $line)
                             )
                     )
        )
        (setq $p1 (car $plist))   ;poczatek linni
        (setq $p2 (cadr $plist))  ;koniec linni
        (setq $wsp (mapcar '(lambda (x y) (+ (* 0.5 x) (* 0.5 y)))  ;dodaje polowy z listy punktow
                           $p1
                           $p2
                   )
        )
        (setq $angle (@RtD (angle $p2 $p1)))           ; ustawienie obrotu tekstu zgodnie ze standardem
        (if (or
              (and (>= $angle 90) (<= $angle 180))
              (and (>= $angle 180) (<= $angle 270))
            )
          (setq $angle (- $angle 180))
        )
        (setq $dline1 (+ (fix (* (distance $p1 $p2) 1000)) 1)) lo ;odczytana z autocada
        (setq $dline (+ 3 $dline1))
              (command "-insert" "dl_linni_2" $wsp "1" "" $angle "" "" "" "" "" "" "" "" $dline)  ;wstawia blok dlugosci linni
              (setq $i (+ 1 $i))
        )
      )
    )
  )
;=======Radians to Degrees======
  (defun @RtD (r) (* 180.0 (/ r pi)))
