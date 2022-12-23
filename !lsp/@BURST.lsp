;rozbicie z przypisaniem wartosci 
(defun c:@BURST   ( / ssbl cnt en eL )

 ; select all Blocks and set a loop counter
 (setq ssbl (ssget  (list (cons 0 "INSERT")(cons 66 1)))
       cnt 0
       )
 
 ;loop through all selected blocks...
 (repeat (sslength ssbl)

  ; get Block entity list
  (setq en (ssname ssbl cnt)
          en (entnext en) ; get first attribute
          el (entget  en)
        )
 
  ; loop through all attributes of this Block Reference...
  (while (not (equal (cdr (assoc 0 el)) "SEQEND"))
   
   (entmake (list '(0 . "TEXT")
          '(100 . "AcDbEntity")
          '(100 . "AcDbText")
           (cons 1  (cdr (assoc 1  el)) ) ; txt-string
           (cons 7  (cdr (assoc 7  el)) ) ; style
           (cons 10 (cdr (assoc 10 el)))
                   ;(cons 11 pt2) optional meaningful ONLY if 72 or 73 NON ZERO !
           (cons 40 (cdr (assoc 40 el)) ) ; txt-height
           (cons 72 (cdr (assoc 73 el)))  ; h-just
           (cons 73 (cdr (assoc 74 el)))  ; v-just
                  )
      ); entmake

   ; find next attribute entity list for this Block Reference...
      (setq en (entnext en)
            el (entget  en)
         )
     ); loop attributes...
 
  ; go to next block reference...      
  (setq cnt (1+ cnt))
  );repeat blocks...
 
 ); defun
