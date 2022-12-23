;chowanie wynikow
(defun c:abcc ()
	(command "_.layer" "_s" "0" "")
	(command "_.layer" "_f" "tkd_abc_*" "")

)
(defun c:abco ()
	(command "_.layer" "_s" "0" "")
	(command "_.layer" "_t" "tkd_abc_*" "")
	(command "_.layer" "_f" "tkd_abc_elements" "")
)