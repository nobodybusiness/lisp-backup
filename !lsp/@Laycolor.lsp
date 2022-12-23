;zmiana koloru warstwy
(defun c:@LayColor (/ ss clr col i lst lay)
  (vl-Load-Com) ; dodaj if bo od 1-255
  (if (setq ss (ssget "_:L"))
    (progn
      (setq lst ","
            ccl (getvar 'CECOLOR)
      )
      (repeat (setq i (sslength ss))
        (setq
          lay (strcat
                (cdr (assoc 8 (entget (ssname ss (setq i (1- i))))))
                ","
              )
        )
        (if (not (vl-string-search (strcat "," lay) lst))
          (setq lst (strcat lst lay))
        )
      )
      (setq lst (vl-string-trim "," lst))
      (initdia)
      (command "_.COLOR")
      (setq col (getvar 'CECOLOR))
      (setvar 'CECOLOR ccl)
      (command "_.LAYER" "_Color")
      (if (wcmatch col "RGB:*")
        (command "_T" (substr col 5))
        (command col)
      )
      (command lst "")
    )
  )
)