(defun c:scalanie()
       (#scalanie)
  )

(defun #scalanie()
	(vl-load-com)
;pokaz warstwy do scalenia
  	(command "-layer" "off" "*" "")
  	(command "-layer" "on" "tkd_do_scalenia" "")
  	(command "-layer" "on" "tkd_zbr" "")
  	(command "-layer" "on" "tkd_opisy_zbr" "")
;select circles
  	(setq $zaznaczenie (ssget))
  	
;pokaz warstwy
	 (command "-layer" "on" "*" "")
  )