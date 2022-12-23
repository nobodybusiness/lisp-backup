;dlugosci po buynku
(defun c:@dll ()
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
	
	(setq $zapas_tras(+ 1 (fix (* 0.1 $okw_length_sum))))
	(setq $okw_tras (+ $okw_length_sum $zapas_tras))
	
	(setq $zapas 10)
	
	(setq $liczba_poz (getint "Liczba pi�ter:"))
	(setq $zapas_pion (* $liczba_poz 4))

  (setq $okw_inst (+ $okw_tras $zapas $zapas_pion))
	(print $okw_tras)
  (print $okw_inst)
  (princ)
	(@zmianaWStrzalce $okw_tras $okw_inst)
)
(defun @zmianaWStrzalce(okw_tras okw_inst)
	(vl-load-com)
  (setq ss (ssget))
  (setq $ent_ename (ssname ss 0))
  (setq $ent_data (entget $ent_ename))
  (setq $text (cdr (assoc '304 $ent_data)))
  (setq x1 (strcat "d�. tras. " (rtos okw_tras 2 0) "m"))
  (setq x2 (strcat "d�. inst. " (rtos okw_inst 2 0) "m"))
  (setq $newText (vl-string-subst x1 "d�. tras. _" $text))
  (setq $newText2 (vl-string-subst x2 "d�. inst. _" $newText))
	(setq $VAL (subst (cons 304 $newText2) (assoc 304 $ent_data) $ent_data))
  (entmod $VAL)
  (entupd $ent_ename)
)
