;usuwanie wszystkich layoutow
(defun C:laydel ()
  (vl-load-com)
  (vlax-for layout (vla-get-layouts
      (vla-get-ActiveDocument (vlax-get-acad-object))
   )

    (if	(/= (vla-get-name layout) "Model")
      (vla-delete layout)
    )
  )
)