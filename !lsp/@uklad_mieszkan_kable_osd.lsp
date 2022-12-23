(defun c:@uklad_mieszkan ()
  (vl-load-com)
	;pkt wstepny
  (setq repeatTubes 1)
  (setq 1spawNaStart (getstring "Czy jeden spaw na start? : <y>"))
	;typ kabla np 2x6
  (setq numberOfCabelTubes (getint "Ile tub :"))
  (setq numberOfTubesWkl (getint "Ile wlokien w tubie :"))
	;liczba wykorzystanych tub
  (setq numberOfUsedTubesStart (getint "Pierwsza uzyta tuba :"))
  (while (/= repeatTubes 0)
    (@tubes)
    (setq point (getpoint "Pkt wstawienia:"))
    (@Mtext)
    (setq numberOfUsedTubesStart (+ numberOfUsedTubesStart numerOfUsedTubes))
    (setq ifReapeat (getstring "Czy nastepne tuby? : <y>"))
    (if (= ifReapeat "n")
      (setq repeatTubes 0)
    )
  )

)
(defun @tubes ()
  (setq numerOfUsedTubes (getint "Ile uzytych tub"))
	;przedzial wlokien / lub do konca
  (setq fromUsedTubes (getstring "Przedzaia� w��kien - k - do ko�ca <formTubes>"))
	;pi�tro
  (setq level (getstring "Ktory poziom :"))
  (if (= level "0")
    (setq level "parter")
    (setq level (strcat "poziom " level))
  )
	;HH i LU
  ;(command "@ile_HH_LU" pause pause pause pause pause pause)
  (setq HH_ile (getstring "HH ile: "))
  (setq LU_ile (getstring "LU ile: "))
  (setq HH (getstring "HH od-do:"))
  (setq LU (getstring "LU :"))
)
(defun @Mtext ()
	;1st line
  (setq krotnoscKabla (rtos (* numberOfCabelTubes numberOfTubesWkl) 2 0))
  (setq pierwszeWloknoTuby (rtos (+ (* (- numberOfUsedTubesStart 1) numberOfTubesWkl) 1) 2 0))
  (setq ostatnieWloknoTuby (rtos (* (- (+ numberOfUsedTubesStart numerOfUsedTubes) 1) numberOfTubesWkl) 2 0))
  (if (= fromUsedTubes "k")
    (setq przedzial (strcat pierwszeWloknoTuby "-" krotnoscKabla))
    (setq przedzial (strcat pierwszeWloknoTuby "-" ostatnieWloknoTuby))
  )
  (setq 1line (strcat "OSD_/OKW_/" krotnoscKabla "J_(" przedzial ")"))
    ;2nd line
  (if (> (atoi LU_ile) 0)
    (setq 2line (strcat level " (lok. " HH "," LU ") " "(" HH_ile "HH + " LU_ile "LU)"))
    (setq 2line (strcat level " (lok. " HH ") " "(" HH_ile "HH)"))
  )
    ;3th line
  (setq 3line (strcat "HPC_1626_CT_" (rtos numberOfCabelTubes 2 0) "X" (rtos numberOfTubesWkl 2 0) "G657"))
		;4th line
  (@colorTube)
	;sets 4t line
  (@printMtext)
)
(defun @printMtext ()
  (command "MTEXT" point point 1line 2line 3line 4line "")
)
(defun @colorTube ()
  (setq valueOfUsedTubes numerOfUsedTubes)
  (setq valueOfCurrentTube numberOfUsedTubesStart)
  (setq 4line "")
  (while (> valueOfUsedTubes 0)
    (setq colorTuby
      (cond
        ((= valueOfCurrentTube 1) " Cz. ")
        ((= valueOfCurrentTube 2) " Ni. ")
        ((= valueOfCurrentTube 3) " Bi. ")
        ((= valueOfCurrentTube 4) " Zi. ")
        ((= valueOfCurrentTube 5) " Fi. ")
        ((= valueOfCurrentTube 6) " Po. ")
        ((= valueOfCurrentTube 7) " Sz. ")
        ((= valueOfCurrentTube 8) " Zo. ")
        ((= valueOfCurrentTube 9) " Br. ")
        ((= valueOfCurrentTube 10) " Ro. ")
        ((= valueOfCurrentTube 11) " Ca. ")
        ((= valueOfCurrentTube 12) " Tu. ")
      )
    )
    (setq pierwszeWloknoTubyColor (rtos (+ (* (- valueOfCurrentTube 1) numberOfTubesWkl) 1) 2 0))
    (setq ostatnieWloknoTubyColor (rtos (* valueOfCurrentTube numberOfTubesWkl) 2 0))
    (if (/= 1spawNaStart "n")
      (setq wlWTubie pierwszeWloknoTubyColor)
      (setq wlWTubie (strcat pierwszeWloknoTubyColor "-" ostatnieWloknoTubyColor))
    )
    (setq temp4line (strcat "Tuba " (rtos valueOfCurrentTube 2 0) ", " colorTuby " w�. " wlWTubie ", "))
    (setq 4line (strcat 4line temp4line))
    (setq valueOfCurrentTube (+ valueOfCurrentTube 1))
    (setq valueOfUsedTubes (- valueOfUsedTubes 1))
  )
)

