;tworzenie mtxt o okreslonej wielkosci
(defun C:@T2 ()
	(vl-load-com)
	(command "insert" "TEXT_2" pause "" "" "")
	(command "explode" "l" )
 	(command "_ddedit" "l" )
)
(defun C:@T5 ()
	(vl-load-com)
	(command "insert" "TEXT_5" pause "" "" "")
	(command "explode" "l" )
 	(command "_ddedit" "l" )
)
(defun C:@T10 ()
	(vl-load-com)
	(command "insert" "TEXT_10" pause "" "" "")
	(command "explode" "l" )
 	(command "_ddedit" "l" )
)