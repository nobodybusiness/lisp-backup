;wsatwienie schematu kabla 3x4
(defun C:@KABEL3x4 ()
  (vl-load-com)
	;1.1 SPR BIEZACA WARSTWE
  (setq curent_layer (getvar "CLAYER"))

	;1.2 USTAW WARSTWE KABLI (pierwszy czerwony)
  (setq new_layer "�wiat bud.")
  (command "-layer" "s" new_layer "")
  (command "cecolor" 1)

	;2.1 PL
  (command "polyline" pause pause pause pause "")

	;2.2 ODSUNI�CIE i zmiana koloru
;kolory 12J
  (setq i 0)
  (setq color_list '(
                      5
                      7
                      84
                      1
                      5
                      7
                      84
                      1
                      5
                      7
                      84
                    )
  )
  (while (< i 11)
    (progn
      (setq color (nth i color_list))
      (setq last_line (entlast))
      (command "offset" 15.6 last_line "99999999999.999,-9999999999999999.0,0.0" "")
      (setq last_line (entget (entlast)))
      (setq last_line (subst (cons 62 color) (assoc 62 last_line) last_line))  ; podmiana definicji promienia
      (entmod last_line)  ; zastosowanie zmiany
      (setq i (+ i 1))
    )
  )
	;3. wstawianie opisu
	(setq $wsp (getpoint))
	(command "-insert" "kabel3x4" $wsp "" "" "") 
	(command "explode" "l" "" )
	;4. USTAW WARSTE NA POPRZEDNIA
  (command "-layer" "s" curent_layer "")
  (command "cecolor" 256)
  (print)
)
