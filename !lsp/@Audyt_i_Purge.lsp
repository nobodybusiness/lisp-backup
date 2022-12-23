;glebokie czysczenie rysunku
; Audyt pliku
(defun @Audyt_i_Purge ()
  ;purgowanie wszystkich elementow
  (command "-purge" "a" "*" "n")
  (command "-purge" "r" "*" "n")
  ;naprawa i sprawdzenie bledow na rys
  (command "audit" "y")
  ;purgowanie wszystkich elementow
  (command "-purge" "a" "*" "n")
  (command "-purge" "r" "*" "n")
	;oddalenie dla sprawdzenie "resztek" rysunkowcyh
  (command "_zoom" "e")
	;(command "_qsave" "" "" "y")
  (princ "\nelementy zostaly usuniete")
  (princ)
)
