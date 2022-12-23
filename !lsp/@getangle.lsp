;nie uzywac
(defun @getangle ()
  ;!zbedne
  (setq $p1 (getpoint "Wskaz pkt w kierunku strzalki"))
  (setq $p2 (getpoint "Wskaz pkt w kierunku konca"))
  (setq $angle (- (@RtD (angle $p2 $p1)) 90))
  (command "_ro" pause pause pause pause $angle )
  (princ)
  (command "_.move" "_p" "" )
)