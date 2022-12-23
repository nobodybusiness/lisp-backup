;szybkie przypisanie wartosci do schematow
(defun c:dls()
  (setq $dl_tras (getint "d� p1 tras: "))
  (setq $dl_inst (getint "d� p1 inst: "))
	(setq $dl_opt (getint "d� p1 opt: "))
	
	(setq $dl_tras_2 (getint "d� p2 tras: "))
  (setq $dl_inst_2 (getint "d� p2 inst: "))
	(setq $dl_opt_2 (getint "d� p2 opt: "))
	
	(setq $dl_tras_3 (+ $dl_tras $dl_tras_2) )
  (setq $dl_inst_3 (+ $dl_inst $dl_inst_2))
	(setq $dl_opt_3 (+ $dl_opt $dl_opt_2))
	
	(setq o1 (strcat "tras: " (rtos $dl_tras_3 2 0)))
	(setq o2 (strcat "inst: " (rtos $dl_inst_3 2 0)))
	(setq o3 (strcat "opt: " (rtos $dl_opt_3 2 0)))
	
	(setq point (getpoint "Wska� pkt"))
	
	(command "_mtext" pause "" o1 o2 o3 "" )
	;(setq elast (entlast))
	;(command "sc" elast )
  (PRINC)
)