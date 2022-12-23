
(defun c:@mm ()
	(command "matchprop" rememberEntity)
	
)
(defun c:@rem_ent ()
	(setq rememberEntity (car (entsel)))
	
)