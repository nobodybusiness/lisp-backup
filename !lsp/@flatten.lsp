; FLATTEN.LSP version 2.2, 25 June 1997
;
; FLATTEN sets the Z-coordinates of LINEs, POLYLINEs, LWPOLYLINEs, CIRCLEs, 
; ARCs, TEXT, DIMENSIONs, Block INSERTs, POINTs, HATCHes, and SOLIDs to 0.
;------------------------------------------------------------------------
; copyright 1990, 1993, 1994, 1997 by Mark Middlebrook
;   Daedalus Consulting
;   435 Clifton Street
;   Oakland, CA 94618
;   e-mail: 73030.1604@compuserve.com
;
; You are free to distribute FLATTEN.LSP to others so long as you do not
; charge for it.
;------------------------------------------------------------------------
;*Why Use FLATTEN?:
;
; FLATTENing is useful in at least two situations:
;  1) You receive a DXF file created by another CAD package and discover
;     that all the Z coordinates contain small round-off errors. These
;     round-off errors can prevent you from object snapping to intersections
;     and make your life difficult in other ways as well.
;  2) In a supposedly 2D drawing, you accidentally create one entity with a
;     Z elevation and end up with a drawing containing entities partly in and
;     partly outside the Z=0 X-Y plane. As with the round-off problem, this
;     situation can make object snaps and other procedures difficult.
;------------------------------------------------------------------------
;*How to Use FLATTEN:
;
; FLATTEN v.2.2 works with AutoCAD R12 through R14.
;
; To run FLATTEN, load it using AutoCAD's APPLOAD command, or type:
;   (load "FLATTEN")
; at the AutoCAD Command prompt. Once you've loaded FLATTEN.LSP, type:
;   FLATTEN
; to run it. FLATTEN will tell you what it's about to do and ask you
; to confirm that you really want to flatten entities in the current
; drawing. If you choose to proceed, FLATTEN prompts you to select entities
; to be flattened (press ENTER to flatten all entities in the drawing).
; After you've selected entities and pressed ENTER, FLATTEN goes to work.
; It reports the number of entities it flattens and the number left
; unflattenened (because they were entities not recognized by FLATTEN; see 
; the list of supported entities above).
;
; If you don't like the results, just type U to undo FLATTEN's work.
;
; Note that FLATTEN flattens entities onto the Z=0 X-Y plane in AutoCAD's
; World Coordinate System (WCS).
;------------------------------------------------------------------------

(defun c:@FLATTEN (/ olderr oldcmd ss1 ss1len i numchg numnot numno0 ssno0
                    ename elist etype yorn)
;*error handler
   (setq olderr *error*)
   (defun *error* (msg)
      (if (= msg "quit / exit abort")
         (princ)
         (princ (strcat "error: " msg))
      )
      (setq *error* olderr)
      (command "._UCS" "_Restore" "$FLATTEN-TEMP$"
               "._UCS" "_Delete" "$FLATTEN-TEMP$")
      (command "._UNDO" "_End")
      (setvar "CMDECHO" oldcmd)
      (princ)
   )

;*setup
   (setq oldcmd (getvar "CMDECHO"))
   (setvar "CMDECHO" 0)
   (command "._UNDO" "_Group")
   (command "._UCS" "_Save" "$FLATTEN-TEMP$" "._UCS" "World") ;set World UCS

;*get input
   (prompt (strcat 
      "\nFLATTEN sets the Z coordinates of lines, polylines, circles, arcs,"
      "\ntext, dimensions, block inserts, points, hatches, and solids to zero."
   ))

   (initget "Yes No")
   (setq yorn (getkword "\nDo you want to continue <Y>: "))
   (cond ((/= yorn "No")
         (graphscr)  
         (prompt "\nChoose entities to FLATTEN ")
         (prompt "[press return to select all entities in the drawing]")
         (setq ss1 (ssget))
         (if (null ss1)             ;if enter...
             (setq ss1 (ssget "X"))    ;select all entities in database
         )


;*initialize variables
         (setq ss1len (sslength ss1)   ;length of selection set
               i 0                     ;loop counter
               numchg 0                ;number changed counter
               numnot 0                ;number not changed counter
               numno0 0                ;number not changed and Z /= 0 counter
               ssno0 (ssadd)           ;selection set of unchanged entities
         );setq

;*do the work
         (prompt "\nWorking.")
         (while (< i ss1len)                    ;while more members in the SS
            (if (= 0 (rem i 10)) (prompt "."))
            (setq ename (ssname ss1 i)             ;entity name
                  elist (entget ename)             ;entity data list
                  etype (cdr (assoc 0 elist))      ;entity type
            )

;*Keep track of entities not flattened
            (if (not (member etype 
                             '("LINE" "POLYLINE" "TEXT" "INSERT" 
                               "CIRCLE" "ARC" "POINT" "SOLID" 
                               "DIMENSION" "LWPOLYLINE" "HATCH" "MTEXT")))
               (progn                           ;leave others alone
                  (setq numnot (1+ numnot))     
                  (if (/= 0.0 (car (reverse (assoc 10 elist))))
                     (progn                  ;add it to special list if Z /= 0
                        (setq numno0 (1+ numno0))
                        (ssadd ename ssno0)
                     )
                  )
               )
            )

;*change group 10 Z coordinate to 0 for listed entity types
            (if (member etype '("LINE" "POLYLINE" "TEXT" "INSERT" "CIRCLE"
                                 "ARC" "POINT" "SOLID" "DIMENSION" "HATCH" 
                                 "MTEXT"))
               (setq elist (zeroz 10 elist)     ;change entities in list above
                     numchg (1+ numchg)
               )
            )

;*change group 11 Z coordinate to 0 for LINEs, TEXT, and SOLIDs
            (if (member etype '("LINE" "TEXT" "SOLID" "DIMENSION"))
               (setq elist (zeroz 11 elist))
            )

;*change groups 12 and 13 Z coordinate to 0 for SOLIDs
            (if (member etype '("SOLID"))
               (progn
                  (setq elist (zeroz 12 elist))
                  (setq elist (zeroz 13 elist))
               )
            )

;*change groups 13, 14, 15, and 16 Z coordinate to 0 for DIMENSIONs
            (if (member etype '("DIMENSION"))
               (progn
                  (setq elist (zeroz 13 elist))
                  (setq elist (zeroz 14 elist))
                  (setq elist (zeroz 15 elist))
                  (setq elist (zeroz 16 elist))
               )
            )

;*special handling for R14 LWPOLYLINEs
            (if (member etype '("LWPOLYLINE"))
               (progn
                  (setq elist (subst (cons 38 0.0) (assoc 38 elist) elist)
                        numchg (1+ numchg)
                  )
                  (entmod elist)
               )
            )

            (setq i (1+ i))               ;next entity
         );while
         (prompt " Done.")

;*print results
         (prompt (strcat "\n" (itoa numchg) " entity(s) flattened"))
         (prompt (strcat "\n" (itoa numnot) " entity(s) not flattened"))

         (if (/= 0 numno0)          ;if there any entities in ssno0, show them
            (progn
               (prompt (strcat "  [" (itoa numno0) 
                     " with non-zero base points]"))
               (getstring "\nPress enter to see non-zero unchanged entities... ")
               (command "._SELECT" ssno0)
               (getstring "\nPress enter to unhighlight them... ")
               (command "")
            )
         )
   ))

   (command "._UCS" "_Restore" "$FLATTEN-TEMP$"
            "._UCS" "_Delete" "$FLATTEN-TEMP$")
   (command "._UNDO" "_End")
   (setvar "CMDECHO" oldcmd)
   (setq *error* olderr)
   (princ)
)


;*function to change Z coordinate to 0

(defun zeroz (key zelist / oplist nplist)
   (setq oplist (assoc key zelist)
         nplist (reverse (append '(0.0) (cdr (reverse oplist))))
         zelist (subst nplist oplist zelist)
   )
   (entmod zelist)
)

(prompt "\nFLATTEN v.2.2 loaded.  Type FLATTEN to run it.")
(princ)

;;;eof