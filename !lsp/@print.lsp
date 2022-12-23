;wydruk automatyczny wszystkich layoputow
(defun c:@print ()
	(vl-load-com)
  (foreach lay (layoutlist) (setvar "CTAB" lay) (command "_PLOT" "N" "" "" "" "" "Y" ""))
	(command "_qsave")
)

