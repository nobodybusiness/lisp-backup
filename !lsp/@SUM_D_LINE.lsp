(defun @SUM_D_LINE ()
  (setq $dline_zm 0)
  (setq $dline1 0)
  (if (setq $SS (ssget '((0 . "LWPOLYLINE"))))  ; przyjecie z zaznaczenie tylko plinii
    (progn
      (setq $ss_length (sslength $ss))
      (setq $ss_i 0)
      (while (< $ss_i $ss_length)
        (setq $line (ssname $ss $ss_i))
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
        (while (< $n $p_list_length)
          (setq $n_string (rtos $n 2 0))
          (setq $pA (vl-symbol-value (read (strcat "$p" $n_string))))
          (setq $n (+ 1 $n))
          (setq $n_string (rtos $n 2 0))
          (setq $pB (vl-symbol-value (read (strcat "$p" $n_string))))
          (setq $dline_zm (+ (fix (distance $pA $pB)) 1))
          (setq $dline1 (+ $dline1 $dline_zm))
        )
        (setq $ss_i (+ 1 $ss_i))
      )
    )
  )
  (print (+(/ $dline1 100) 1) )
  (princ)
)