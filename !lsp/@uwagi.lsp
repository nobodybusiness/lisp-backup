;dodawanie warstwy dzisiaj
(defun @uwagi ()
  (vl-load-com)
  (@today)
  (setq $nazwa (strcat $dzis "_uwagi"))
  (command "-layer" "_m" $nazwa "_c" "red" "" "_p" "_n" "" "")
)
(defun @TODAY (/ d yr mo day)
;define the function and declare all variabled local

  (setq d (rtos (getvar "CDATE") 2 6)
    ;get the date and time and convert to text

        yr (substr d 3 2)
        ;extract the year

        mo (substr d 5 2)
        ;extract the month

        day (substr d 7 2)
        ;extract the day

  )  ;setq

  (setq $dzis (strcat day  mo  yr))
     ;string 'em together
)    ;defu
