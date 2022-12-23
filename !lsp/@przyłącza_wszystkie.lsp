(defun c:@przylacza_wszytskie ()
  (setq $SS (ssget '((0 . "LWPOLYLINE"))))  ; przyjecie z zaznaczenie tylko plinii
  (setq $zm_linni 0)
  (while
    (setq $line (ssname $ss $zm_linni))
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


    (setq $angle (@RtD (angle $pB $pA)))  ; ustawienie obrotu tekstu zgodnie ze standardem
    (if (or
          (and (> $angle 90) (< $angle 180))
          (and (> $angle 180) (< $angle 270))
        )
      (setq $angle (- $angle 180))
    )
    (setq $dline (+ 3 $dline1))           ;domyslne dodanie 3
    ;Sugeruj d³ugoœc z cada?
    (setq $wsp (mapcar '(lambda (x y) (+ (* 0.5 x) (* 0.5 y)))  ;dodaje polowy z listy punktow
                       $pA
                       $pB
               )
    )
    (command "-insert" "dl_linni" $wsp "" "" $angle "" "" "" "" "" "" "" "" $dline)  ;wstawia blok dlugosci linni
    (setq $zm_linni (+ $zm_linni 1))
  )
)
;=======SET NUMBER OF OTWR========
(defun c:@otw ()
  (setq ss (ssget '((0 . "INSERT") (2 . "dl_linni"))))  ; only specific block
  (setq i 0)
  (setq ile_otw (getint "Ile otworów?\n"))
  (while (< i (sslength ss))
    (setq $VAL 0)
    (setq $ent (ssname ss i))
    (setq $name "none")
    (setq $name (cdr (assoc '0 (entget $ent))))
    (while (not (equal $name "SEQEND"))
      (setq $LST (entget $ent))
      (setq $attag (cdr (assoc '2 $LST)))
      (setq $attag (strcase $attag))
      (if (= $attag "ILOTW")
        (progn
          (setq $VAL (atoi (cdr (assoc 1 $LST))))
          (setq $VAL_new ile_otw)
          (setq $VAL (subst (cons 1 (rtos $VAL_new 2 0)) (assoc 1 $LST) $LST))
          (entmod $VAL)
          (entupd $ent)
        )
      )
      (setq $ent (entnext $ent))
      (setq $name (cdr (assoc '0 (entget $ent))))
    )
    (setq i (+ i 1))
    (@otworwka ss)
  )
)


;=======Radians to Degrees======
(defun @RtD (r) (* 180.0 (/ r pi)))
