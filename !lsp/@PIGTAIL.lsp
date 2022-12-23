(defun c:@pigtail ()
	(setq $fromNumber 0)
	(setq $toNumber 0)
  (setq $ifUslugi (getint "<2 - AU><1 - LU><0 - HH>"))
  (setq $fromNumber (getint "from number:"))
  (if (/= $ifUslugi 2)
    (progn
      (setq $toNumber (getint "to number:"))
    )
  )
  (if (= $ifUslugi 2)
    (progn
      ;==============================
      (setq $naIleProcent (getint "<200><70><100>"))
      (if $naIleProcent
        ()  ;nth
        (setq $naIleProcent 100)
      )
      (vl-load-com)
      (setq $ile_mieszk nil)
      (setq $ile_mieszk (ssget '((0 . "INSERT") (2 . "mieszkania_blok"))))
      (if $ile_mieszk
        (setq $ile_mieszk_length (sslength $ile_mieszk))
        (setq $ile_mieszk_length 0)
      )
;=====================================
      (setq $ile_lu nil)
      (setq $ile_lu (ssget '((0 . "INSERT") (2 . "uslugi_blok"))))
      (if $ile_lu
        (setq $ile_lu_length (sslength $ile_lu))
        (setq $ile_lu_length 0)
      )
;=====================================
      (if (= $ile_LU_length 0)
        (progn
          (setq $toNumber (-(+ $fromNumber (* $ile_mieszk_length (/ $naIleProcent 100))) 1))
          (setq $ifUslugi 0)
        )
      )
      (if (= $ile_mieszk_length 0)
        (progn
          (setq $toNumber (- (+ $fromNumber(* $ile_LU_length (/ $naIleProcent 100))) 1))
          (setq $ifUslugi 1)
        )
      )
      ;==============================
    )
  )
  (setq $i 0)
  (setq $j 0)
  (setq $licz_wierszy 4)
  (setq $wsp (getpoint "wska� pkt wstawienia"))
  (setq $wsp_x (car $wsp))
  (setq $wsp_y (cadr $wsp))
  (if (= 1 $ifUslugi)
    (while (<= $fromNumber $toNumber)
      (progn
        (command "-insert" "przel_uslugi_blok" $wsp "" "" "" $fromNumber)
        (print)
        (if (= $j 0)
          (progn
            (setq $wsp_y (+ $wsp_y 25))
            (setq $wsp (strcat (rtos $wsp_x 2) "," (rtos $wsp_y 2)))
            (setq $j 1)
          )
          (progn
            (setq $wsp_y (- $wsp_y 25))
            (setq $wsp_x (+ $wsp_x 25))
            (setq $wsp (strcat (rtos $wsp_x 2) "," (rtos $wsp_y 2)))
            (setq $j 0)
          )
        )
        (setq $i (+ 1 $i))
        (setq $fromNumber (+ $fromNumber 1))
      )
    )
    (while (<= $fromNumber $toNumber)
      (progn
        (command "-insert" "przel_mieszk_blok" $wsp "" "" "" $fromNumber)
        (print)
        (if (= $j 0)
          (progn
            (setq $wsp_y (+ $wsp_y 25))
            (setq $wsp (strcat (rtos $wsp_x 2) "," (rtos $wsp_y 2)))
            (setq $j 1)
          )
          (progn
            (setq $wsp_y (- $wsp_y 25))
            (setq $wsp_x (+ $wsp_x 25))
            (setq $wsp (strcat (rtos $wsp_x 2) "," (rtos $wsp_y 2)))
            (setq $j 0)
          )
        )
        (setq $i (+ 1 $i))
        (setq $fromNumber (+ $fromNumber 1))
      )
    )
  )
)
