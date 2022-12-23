;dlogosc po budynku
(defun @dl_okw ()
  (vl-load-com)
  (setq $okw nil)
  (setq $okw (ssget '((0 . "LWPOLYLINE"))))
  (setq $okw_name (ssname $okw 0))
  (setq $i 1)
  (setq $okw_length_sum 0)
  (setq $plist (mapcar 'cdr
                       (vl-remove-if-not
                         '(lambda (x) (= (car x) 10))
                         (entget $okw_name)
                       )
               )
  )
  (setq $p_list_length (length $plist))
  (while $plist  ; petla przypisania wszystkich pkt
    (setq $i_string (rtos $i 2 0))
    (setq $name (read (strcat "$p" $i_string)))
    (set $name (car $plist))
    (setq $plist (cdr $plist))
    (setq $i (+ 1 $i))
  )
  (print $p1)
  (setq $n 1)
  (while (< $n $p_list_length)
    (setq $n_string (rtos $n 2 0))
    (setq $pA (vl-symbol-value (read (strcat "$p" $n_string))))
    (setq $n (+ 1 $n))
    (setq $n_string (rtos $n 2 0))
    (setq $pB (vl-symbol-value (read (strcat "$p" $n_string))))
    (setq $okw_length (distance $pA $pB))
    (setq $okw_length_sum (+ $okw_length_sum $okw_length))
  )
  (setq $okw_length_sum (/ (fix $okw_length_sum) 100))

  (setq $zapas (* 10 (fix (+ (* 0.01 $okw_length_sum) 1))))
  (if (and(>= $okw_length_sum 15)(<= $okw_length_sum 25))
    (setq $zapas (+ $zapas 5))
  )
  (if (> $okw_length_sum 25)
    (setq $zapas (+ $zapas 10))
  )
  (setq $liczba_piet (getint "Liczba pi�ter:"))
  (setq $zapas_pion (* $liczba_piet 4))
  (setq $okw_obl (+ $okw_length_sum $zapas $zapas_pion))
  (print $okw_obl)
  (princ)

)
(defun c:dll ()
	(@SUM_D_LINE)
	(@DL_OKW)
	(print (strcat (rtos (+(/ $dline1 100) 1) 2 0) "/" (rtos $okw_obl 2 0)))
	(princ)
)