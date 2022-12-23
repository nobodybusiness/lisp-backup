(defun c:@pigtail_zmiana_rodzaju ()
  (setq ss (ssget))
  (setq i 0)
  (setq rodzaj (getint "<1>Niewyspawane<2>Wyspawane: "))
  (setq HHorLU (getint "<1>HH<2>LU: "))
  (setq obecnyNumer 0)
  (while (< i (sslength ss))
    (setq $VAL 0)
    (setq $ent (ssname ss i))
    (setq $name "none")
    (setq $name (cdr (assoc '0 (entget $ent))))
    (while (not (equal $name "SEQEND"))  ;NAZWA PROJEKTU
      (setq $LST (entget $ent))
      (setq $attag (cdr (assoc '2 $LST)))
      (setq wspl (cdr (assoc '10 $LST)))
      (setq $attag (strcase $attag))
      (if (OR (= $attag "PRZEL_MIESZKANIA") (= $attag "PRZEL_USLUGI"))
        (progn
          (setq $VAL (atoi (cdr (assoc 1 $LST))))
          (setq obecnyNumer $VAL)
        )
      )
      (setq entToDel $ent)
      (setq $ent (entnext $ent))
      (setq $name (cdr (assoc '0 (entget $ent))))
      (entdel entToDel)
    )

    (insertPrzelBlok rodzaj HHorLU wspl obecnyNumer)
    (setq i (+ i 1))
  )
)
(defun insertPrzelBlok (rodzaj HHorLU wspl obecnyNumer)
  (setq wspl (mapcar '+ wspl '(-6.68 -8.7 0.0)))
  (if (= rodzaj 2)
    ;wyspawane
    (if (= HHorLU 1)
      ;mieszkania
      (progn
        (setq wspl (mapcar '+ wspl '(-2.91 0.0 0.0)))
        (setq coDoWstawienia "przel_mieszk_blok_wyspawane")
      )
      ;uslugi
      (progn
        (setq wspl (mapcar '+ wspl '(-2.91 0.0 0.0)))
        (setq coDoWstawienia "przel_uslugi_blok_wyspawane")
      )
    )
    ;niewyspawane
    (if (= HHorLU 1)
      ;mieszkania
      (progn
        (setq wspl (mapcar '+ wspl '(-2.91 0.0 0.0)))
        (setq coDoWstawienia "przel_mieszk_blok_wpiete")
      )
      ;uslugi
      (progn
        ;(setq wspl (mapcar '+ wspl '(-2.91 0.0 0.0)))
        (setq coDoWstawienia "przel_uslugi_blok_wpiete")
      )
    )
  )
  (command "-insert" coDoWstawienia wspl "" "" "" obecnyNumer)
)
