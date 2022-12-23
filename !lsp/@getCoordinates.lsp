;nie uzywac wip
(defun C:@getCoordinates ()
  (vl-load-com)
	;.........
	(setq coordninates ( getpoint "Wska� pkt"))
	;.............
	(setq Dx (car coordninates))
	(setq Dy (cadr coordninates))
	;X
	(setq fixDx (fix Dx))
	
	(setq Mx (* 60 (- Dx fixDx)))
	(setq fixMx ( fix Mx))
	
	(setq Sx (* 60 (- Mx fixMx)))
	(setq fixSx (rtos Sx 2 1))
	
	(setq corX ( strcat (rtos fixDx 2 0) "�" (rtos fixMx 2 0) "'" fixSx "''N" ))
	;Y
	(setq fixDy (fix Dy))
	
	(setq My (* 60 (- Dy fixDy)))
	(setq fixMy ( fix My))
	
	(setq Sy (* 60 (- My fixMy)))
	(setq fixSy ( rtos Sy 2 1))
	
	(setq corY ( strcat (rtos fixDy 2 0) "�" (rtos fixMy 2 0) "'" fixSy "''E" ))
	
	(setq corXY ( strcat corX "," corY))
	
	(print)
	(print corXY)
	(princ)
	
	(command "DIMLEADER" coordninates pause "" corXY "")
	(princ)
)