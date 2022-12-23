					;funkcja poprzedniego zaznaczenia
(defun C:ost ()
  (command
    "_pselect"
    "_p"
    ""
  )
  (princ)
)					;defun
					;--------------------------------
					;funkcja stworzenia zapisu
(defun c:zap ()
  (setq zapis (ssget))
)
					;--------------------------------
					;funkcja pzywrocenia zaznaczenia
(defun c:chk ()
  (command
    "_select"
    zapis
    ""
  )
)
					;--------------------------------------------
					;funkcja przesuwanie zbrojenia x-x
					;(defun c:1 ()
					; (command
					;  "_move" "g" "x-x" "" "d" "0,5000,0"
					; )
					;)
					;funkcja przesuwanie zbrojenia x-x
					;(defun c:2 ()
					; (command
					;  "_move" "g" "x-x" "" "d" "0,-5000,0"
					; )
					;)
					;funkcja przesuwanie zbrojenia x-x
					;(defun c:3 ()
					; (command
					;  "_move" "g" "y-y" "" "d" "0,5000,0"
					; )
					;)
					;funkcja przesuwanie zbrojenia x-x
					;(defun c:4 ()
					; (command
					;  "_move" "g" "y-y" "" "d" "0,-5000,0"
					; )
					;)
					;-------------------------------------------
					;poka¿ siatke i wartoœci abc

(defun c:` ()
  (command "-layer"	     "thaw"	       "tkd_abc_elements"
	   "on"		     "tkd_abc_elements"
	   ""
	  )
  (command "-layer" "on" "tkd_abc_elements" "")
  (command "-layer"	    "thaw"	     "tkd_abc_pole_dx"
	   "on"		    "tkd_abc_pole_dx"
	   ""
	  )
  (command "-layer" "on" "tkd_abc_pole_dx" "")
  (command "-layer"	    "thaw"	     "tkd_abc_pole_dy"
	   "on"		    "tkd_abc_pole_dy"
	   ""
	  )
  (command "-layer" "on" "tkd_abc_pole_dy" "")
  (command "-layer"	    "thaw"	     "tkd_abc_pole_gx"
	   "on"		    "tkd_abc_pole_gx"
	   ""
	  )
  (command "-layer" "on" "tkd_abc_pole_gx" "")
  (command "-layer"	    "thaw"	     "tkd_abc_pole_gy"
	   "on"		    "tkd_abc_pole_gy"
	   ""
	  )
  (command "-layer" "on" "*" "")
  (command "-layer" "unlock" "*" "")
  (command "-layer" "lock" "xref" "")
  (princ)
)
------------------------------------------
					; Audyt - grzesiek
					;(defun c:`` () 
					;(command "-purge" "a" "n" "")
					;(command "-purge" "r" "*" "n" "")
					;(command "audit" "y")
					;(command "-purge" "a" "n" "")
					;(command "-purge" "r" "*" "n" "")	
					;(command "_zoom" "e")
					;(command "_qsave" "" "" "y")
					;(princ "ok")
					;)
(defun c:`` ()
  (command "-purge" "a" "n" "")
  (command "-purge" "r" "*" "n")
  (command "_zoom" "e")
  (command "_qsave")
  (princ "ok")
  ;(command "-layer" "color" "cyan" "tkd_pomoce" "")
)
(defun #test10 ()
  (command "-purge" "a" "n" "")
  (command "-purge" "r" "*" "n")
  (command "_zoom" "e")
  (command "_qsave")
  (princ "ok")
 )
(defun c:wy ()
  (command "_.Tilemode" 1)
  (#test10)
  (command "_.layer" "off" "*" "" "")
  (command "_.layer" "on" "tkd_wykaz_zbrojenia" "" "")
  (setq $tmp_wykaz (ssget))
  (command "erase" $tmp_wykaz "")
  (command "_.layer" "on" "*" "")
  (#fwykaz_new)
)
(defun c:9 ()
	(command "_.Tilemode" 0)
  )
					;xref lock/unlock/freeze/thaw
(defun c:xxl ()
  (command "_.layer" "_s" "0" "")
  (command "_.layer" "_lo" "xref" "")
)
(defun c:xxu ()
  (command "_.layer" "_s" "0" "")
  (command "_.layer" "_u" "xref" "")
)
(defun c:xz ()
  (command "_.layer" "_s" "0" "")
  (command "_.layer" "_f" "xref" "")
)
(defun c:xa ()
  (command "_.layer" "_s" "0" "")
  (command "_.layer" "_t" "xref" "")
)
					;abc pokaz ukryj
(defun c:abcc ()
  (command "_.layer" "_s" "0" "")
  (command "_.layer" "_f" "tkd_abc_*" "")

)
(defun c:abco ()
  (command "_.layer" "_s" "0" "")
  (command "_.layer" "_t" "tkd_abc_*" "")
  (command "_.layer" "_f" "tkd_abc_elements" "")
)
					;wymroz xref

					;odczyt danych txt
(defun c:zmiana_xrefa ()
					;(command "-xref" "p" "K-00 Szalunki - Budynek B" "363-PW-K-00-R00" "")
					;(command "-rename" "b" "K-00 Szalunki - Budynek B" "363-PW-K-00-R00" "")
  (command
    "-xref"			     "t"
    "363-PP-K-19do22 Plany szalunkowe - budynek nr 4"
    "n"				     ""
   )
  (command "-xref" "t" "tabelka" "n" "")
  (command "-xref" "u" "363w_R_bud.4" "")
)
(defun c:LayColor (/ ss clr col i lst lay)
  (vl-Load-Com)
  (if (setq ss (ssget "_:L"))
    (progn
      (setq lst	","
	    ccl	(getvar 'CECOLOR)
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
  (princ)
)
					;skrót pod hideobjects
(defun c:0 () (command "hideobjects" pause ""))
(defun c:7 () (command "UNISOLATEOBJECTS" ""))
(defun c:1 ()
  (command "_.layer" "_f" "tkd_pomoce" ""))
(defun c:2 () (command "_.layer" "_t" "tkd_pomoce" ""))
