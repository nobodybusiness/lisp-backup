;wybor warstwy
(defun c:@layer_select()
 (setq TargEnt (car (entsel "\nSelect object on layer to select: ")))
 (setq TargLayer (assoc 8 (entget TargEnt)))
 (sssetfirst nil (ssget "_X" (list TargLayer)))
 (princ)
)