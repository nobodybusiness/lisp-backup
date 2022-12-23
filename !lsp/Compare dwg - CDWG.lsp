
;porownywanie plikow dwg -> zmiany, usunięcia 
(vl-load-com)


(defun c:cdwg (/       app     cdoc    fichier dbx     name    sp1

               sp2     e       obj     lstmodif        lstajout

               lstsuppr        lst     obj     sup     h

              )


  (setq app  (vlax-get-acad-object)

        cdoc (vla-get-activedocument app)

        name (vla-get-fullname cdoc)

        s    (getvar "date")

        t1   (* 86400.0 (- s (fix s)))

  )


  (while (not fichier)

    (setq fichier

           (getfiled

             "Select OLD Plan"

             (strcat (vl-filename-directory (vla-get-fullname cdoc))

                     "/"

             )

             "dwg"

             4

           )

    )

  )


  (vla-open (if (< (atoi (substr (getvar "ACADVER") 1 2)) 16)

              (setq dbx (vlax-create-object "ObjectDBX.AxDbDocument"))

              (setq dbx (vlax-create-object

                          (strcat "ObjectDBX.AxDbDocument."

                                  (substr (getvar "ACADVER") 1 2)

                          )

                        )

              )

            )

            fichier

  )


  (vla-saveas

    cdoc

    (strcat (substr name 1 (- (strlen name) 4))

            " Changes"

    )

  )


  (setq sp1 (vla-get-modelspace cdoc)

        sp2 (vla-get-modelspace dbx)

  )


  (vlax-for lay (setq layers (vla-get-layers cdoc))

    (vlax-put lay 'color 253)

    (vla-put-lock lay :vlax-false)

  )


  (vlax-for lay (vla-get-layers dbx)

    (vla-put-lock lay :vlax-false)

  )


  (vlax-for ent sp1

    (setq lst1 (cons ent lst1))

  )


  (defun equal-objects (obj1 obj2)

    (vl-every

      (function

        (lambda (p)

          (and

            (or

              (not (vlax-property-available-p obj1 p))

              (equal (vlax-get obj1 p)

                     (vlax-get obj2 p)

                     1e-9

              )

            )

            (or

              (not

                (and (= (vla-get-ObjectName obj1) "AcDbBlockReference")

                     (= (vla-get-HasAttributes obj1))

                )

              )

              (and

                (vl-every 'equal-objects

                          (vlax-invoke obj1 'getAttributes)

                          (vlax-invoke obj2 'getAttributes)

                )

                (= (vla-get-count

                     (vla-item (vla-get-blocks cdoc) (vla-get-name obj2))

                   )

                   (vla-get-count

                     (vla-item (vla-get-blocks dbx) (vla-get-name obj1))

                   )

                )

              )

            )

          )

        )

      )

      '(ObjectName     Center         Radius         Coordinates

        StartPoint     EndPoint       StartAngle     EndAngle

        MajorAxis      RadiusRatio    TextString     InsertionPoint

        Width          Height         Rotation       XScaleFactor

        YScaleFacor    ZScaleFactor     Layer

       )

    )

  )


  (vlax-put (vla-add layers "0.Ajouts") 'color 172)

  (vlax-put (vla-add layers "0.Modications") 'color 10)

  (vlax-put (vla-add layers "0.Suppressions") 'color 92)


  (vlax-for ent sp2

    (if (handent (setq h (vla-get-handle ent)))

      (if (entget (handent h))

        (progn

          (setq e (vla-handletoobject cdoc h))

          (cond ((and (not (equal-objects ent e))

                      (vlax-property-available-p e 'layer)

                 )

                 (vla-put-layer e "0.Modications")

                )

          )

          (setq lst1 (vl-remove e lst1))          

        )

        (vla-put-layer

          (car (vlax-invoke dbx 'CopyObjects (list ent) sp1))

          "0.Suppressions"

        )

      )

      (vla-put-layer

        (car (vlax-invoke dbx 'CopyObjects (list ent) sp1))

        "0.Suppressions"

      )

    )

  )


  (if lst1

    (foreach n lst1

      (cond ((vlax-property-available-p e 'layer)

             (vla-put-layer n "0.Ajouts")

            )

      )

    )

  )


  (vlax-for b (vla-get-blocks cdoc)

    (vlax-for i b

      (vla-put-color i 256)

    )

  )


  (vlax-release-object dbx)

  (vla-purgeall cdoc)

  (vla-save cdoc)

  (setq s  (getvar "date")

        t2 (* 86400.0 (- s (fix s)))

        tt (- t2 t1)

  )


  (if (> tt 60)

    (progn

      (setq sec (rem tt 60)

            mn  (strcat (rtos (/ (- tt sec) 60) 2 0) " mn ")

            sec (strcat (rtos sec 2 0) " s")

      )

    )

    (progn

      (setq sec (strcat (rtos tt 2 0) " s")

            mn  "0 mn "

      )

    )

  )


  (alert

    (strcat

      "Igal Averbuh Compare Legend\n\nAdditions are GREEN \nModifications in RED\nDeletions in BLUE \n\nTime of comparing : "

      mn

      sec

    )

  )

)

(c:cdwg)