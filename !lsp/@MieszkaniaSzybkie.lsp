;mieszkania schemat przy nie kolejnym numerowaniu
(defun c:@mieszkania ()
  (setq $fromNumber 0)
  (setq $numberOf 0)
  (setq $ifUslugi (getint "<1 - LU><0 - HH>"))
  (setq $fromNumber (getint "from number:"))
  (setq $numberOf (getint "number of:"))
  (setq $i 0)
  (setq $j 0)
  (setq $licz_wierszy 4)
  (setq $wsp (getpoint "wska� pkt wstawienia"))
  (setq $wsp_x (car $wsp))
  (setq $wsp_y (cadr $wsp))
  (if (= 1 $ifUslugi)
    (while (< $i $numberOf)
      (progn
        (setq nameU (strcat "U" (rtos $fromNumber 2 0)))
        (command "-insert" "uslugi_blok" $wsp "" "" "" nameU)
        (print)
        (setq $wsp_x (+ $wsp_x 50))
        (setq $wsp (strcat (rtos $wsp_x 2) "," (rtos $wsp_y 2)))
        (setq $i (+ 1 $i))
        (setq $fromNumber (+ $fromNumber 1))
      )
    )
    (while (< $i $numberOf)
      (progn
        (command "-insert" "mieszkania_blok" $wsp "" "" "" $fromNumber)
        (print)
        (setq $wsp_x (+ $wsp_x 50))
        (setq $wsp (strcat (rtos $wsp_x 2) "," (rtos $wsp_y 2)))
        (setq $i (+ 1 $i))
        (setq $fromNumber (+ $fromNumber 1))
      )
    )
  )
)
