;funkcja do liczenia wystarczanjacego zbrojenia do plyty
(defun C:az ()
 (progn
   ;ustalenie srednic zbrojenia
  (setq srednice (list 8 10 12 16 20 25))
  (setq liczba_srednic (length srednice))
  ;podanie wartosci z abc przez uzytkownika
  (setq
    wartosc_abc (getreal "Wprowadz wartosc z ABC: ")
  )
  (setq indeks_srednic 0)
  ;petla srednic
  (repeat liczba_srednic
   (progn
     (setq srednica (nth indeks_srednic srednice))
     (setq rozstaw 30)
     (setq wartosc_rozstawu 0)
     ;petla rozstawu
     (while (and (< wartosc_rozstawu wartosc_abc) (> rozstaw 5))
       (progn
	 (setq wartosc_rozstawu_co_1
		(* (* 314.1592654  (/ srednica 2)) (/ srednica 2))
	 );setq
	 (setq wartosc_rozstawu (/ wartosc_rozstawu_co_1 rozstaw))
	 (setq rozstaw (1- rozstaw))
	);progn
     );while - petlarozstawu
     (princ srednica)
     (princ "\\")
     (if (= rozstaw 5)
        (princ "brak")
        (princ (1+ rozstaw));else
     );if
     (princ "    ")
     (setq indeks_srednic (1+ indeks_srednic))
   );progn
  );repeat -petla srednic
  (princ)
 );progn
);defun