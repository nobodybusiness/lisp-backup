

;;;++++++++++++++++++++++++++++funkcje wspomagajace snapy+++++++++++++++++++++++++++++++++++++++++++++
(defun c:sp ()
  (setvar "osmode" 695)
  (princ "\rOsmode = 695")
  (princ)
)  ;ustawia wartosc zmiennej osnap na 695
;;;==================================================================================================
;;;++++++++++++++++++++++++++++skróty do komend autocada+++++++++++++++++++++++++++++++++++++++++++++
(defun c:a () (command "_.area"))
(defun c:aw () (command "laycur"))   ;przenosi wskazane obiekty na aktualna warstwe
(defun c:uu () (command "laymcur"))  ;ustawia aktywn¹ warstwê wskazanego el.
(defun c:al () (command "_.align"))
(defun c:ar () (command "_.array"))
(defun c:bo () (command "_.boundary"))
(defun c:br () (command "_.break" pause "_f" pause "@"))     ;funkcja break przerywa w jednym punkcie
(defun c:brr () (command "_.break" pause "_f" pause pause))  ;funkcja break przerywa w dwóch punktach
(defun c:ci () (command "_.circle"))
(defun c:do () (command "_.donut"))
(defun c:dt () (command "_.dtext"))
(defun c:ed () (command "_.ddedit"))
(defun c:el () (command "_.ellipse"))
(defun c:x () (command "_.extend"))
(defun c:f () (command "_.fillet"))
(defun c:i () (command "_.insert"))
(defun c:d () (command "_.dist"))
(defun c:c (/ ent)  ; copy
  (setq ent (ssget))
  (command "_.copy" ent "" "_m")
)  ;kopiuje z domyslnym multiple
(defun c:l () (command "_.pline"))
(defun c:li () (command "_.list"))
(defun c:lt () (command "_.linetype"))
(defun c:le () (command "_.lengthen" "_dy"))
(defun c:m () (command "_.move"))
(defun c:me () (command "_.measure"))
(defun c:mi () (command "_.mirror"))
(defun c:mp () (command "_.mpedit"))
(defun c:mt () (command "_.mtext"))
(defun c:o () (command "_.offset"))
(defun c:os () (command "_.ddosnap"))
(defun c:pl () (command "_.pline"))
(defun c:pe () (command "_.pedit"))
(defun c:pr () (command "_.preferences"))
(defun c:reg () (command "_.regen"))
(defun c:r () (command "_.rectangle"))
(defun c:re () (command "_.rotate"))
(defun c:dr () (command "_draworder"))  ;do poprawki
(defun c:sc () (command "_.scale"))
(defun c:spl () (command "_.spline"))
(defun c:t () (command "_.trim"))
(defun c:Ex () (command "_.explode"))
(defun c:za () (command "_.zoom" "_p"))
(defun c:zd () (command "_.zoom" "_d"))
(defun c:mm () (command "_.MATCHPROP"))
(defun c:ref () (command "_.refedit"))
(defun c:ss () (command "_.selectsimilar"))
(defun c:J () (command "_.JOIN"))
;;;=======================================================================================================
;;;zmienne autocada i ustawienia globalne
(setvar "plinetype" 1)      ;zmiennaa okresla tyyp polilinii gdy 1 to <lwpolyline>, 0 <polyline>
(command "ucsicon" "c")     ;polecenie powoduje ze oznaczenie uk³adu wspólrzednych jest na sta³e w lewym rogu acada
(command "_insunits" "4")   ; ustawienia skali do cm?
(command "_psltscale" "0")  ; wydruk w odpowiedniej skali linni
(command "selectionmodes" "3")  ; 
(command "OLEFRAME" "0")
(command "OLEQUALITY" "2")
(setq $lsp_adress "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp")
         
;==========================
;mine!!
(defun c:oe ()              ; komenda do robienia obwiedni HH
  (command "_.offset" pause pause pause "" "_.erase" "_p" "")
)
(defun c:z () (@viewport_zoom))
(defun c:` () (command "_bkgcolor" "rgb:250,250,250"))  ; zmiana koloru tla na jasny
(defun c:`` () (command "_bkgcolor" "rgb:24,25,28"))    ; zmiana koloru tla na jasny
(defun c:dh () (command "_dimedit" "re"))      ;;przywraca po³o¿enie pierwotne tekstu wymiarowego
(defun c:1 () (command "-layer" "_s" "0" ""))  ; zmiana na waatswe 0
(defun c:2 () (c:@freeze_map))
(defun c:22 () (c:@unfreeze_map))
(defun c:3 () (C:@VIEWPORTS_off))
(defun c:33 () (C:@VIEWPORTS_ON))
(defun c:4 () (C:@NR_STUDNI_MAGISTRALA_OFF))
(defun c:44 () (C:@NR_STUDNI_MAGISTRALA_ON))
(defun c:wkl () (C:@WKL))
(defun c:aa () (@Audyt_i_purge))
(defun c:@LAYcol () (@LayColor))
(defun c:dzialki () (@PRZEJSCIE_KABLA_PO_DZIALKACH))
(defun C:FLATTEN () (@FLATTEN))
(defun C:NUM_DZ () (@NUMERACJA_DZIALEK))
(defun C:st () (c:@studnie_nazwa))
(defun C:uw () (@uwagi))
(defun C:q () (@oznaczenie_dl_przyl))
(defun C:@test () (@oznaczenie_dl_l_2))
(defun C:qq () (@GETANGLE))
(defun C:sum () (@SUM_D_LINE))
(defun C:su () (@dl_insta))
(defun c:dl () (@DL_OKW))
(defun c:ot () (@OTWORWKA))
(defun C:se () (@OZNACZ_KIER_SL))
(defun C:lo () (@OFF))
(defun C:ww () (@On))
(defun c:oo () (@OFF_ONE))      ;wylacza warstwe  wskazanego el.
(defun c:ll () (@lock))         ;wylacza warstwe  wskazanego el.
(defun c:un () (@unlock))       ;wylacza warstwe  wskazanego el.
(defun c:lla () (@lock_all))    ;wylacza warstwe  wskazanego el.]
(defun c:una () (@UNLOCK_ALL))  ;wylacza warstwe  wskazanego el.
(defun c:an () (@angle))        ;wylacza warstwe  wskazanego el.
(defun c:th () (@unfreeze))     ;odmraza wszystkie warstwy
(defun c:fr () (@freeze))       ;zamraza warstwe  wskazanego el.
(defun c:frr () (command "_layfrz" pause ""))       ;zamraza warstwe  wskazanego el.
(defun c:@DELFRZ () (@DELFRZ))   ;zamraza warstwe  wskazanego el.
(defun c:@lay_view() (command "-layer" "_m" "viewports" "_c" 6 "" "_p" "_n" "" "" )) ; viewports warstwa
(defun C:SCH () (@dl_schemat))
(defun C:numeruj () (@TEXTCHANGEPLUSONE))
(defun c:g()(command "group" "" pause "" pause))
(defun C:TA () (@textalign))
(defun C:SL () (@oznacz_kier_sl))
(defun C:LOB () (@OFF_BASE))
(defun C:BA () (@base))
(defun C:IC () (command "_imageclip" pause "" ""))
(defun C:V () (command "change" pause "" "_p" "_la" "viewports" "" ))
;============================LSP LOAD====================
(defun @load_lsp ()
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@angle.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@Audyt_i_Purge.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@deletelayouts.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@DELFRZ.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@dl_insta.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@dl_okw.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@flatten.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@getangle.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@Laycolor.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@layer_select.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@mieszkania.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@msgboxy.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@nr_wkl.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@numeracja_dzialek.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@NUMERACJA_STUDNI.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@ON,OFF.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@otworowka.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@oznaczenie_sl.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@oznacznie_dl_l.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@oznacznie_dl_l_2.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@przejscie_kabla_po_dzialkach.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@studnie_nazwa.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@SUM_D_LINE.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@tabelka.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@temp.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@uwagi.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@viewport_zoom.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@DL_SCHEMAT.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@BURST.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@STUDNIA_OZNACZENIE.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@viewport_trasa.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@przy³¹cza_wszystkie.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@PIGTAIL.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@textChangePlusOne.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@textAlign.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@KABEL.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@KABEL3x4.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@print.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@PIGTAIL ZMIANA NUMERACJI.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@MIESZKANIA_US£UGI_ZMIANA_NUMERACJI.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@getCoordinates.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@TEXT_CALC.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@MTEXT_BETTER.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@osd_renumeracja.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@HH_SCHEMAT.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@kabel_opis_new.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@CA_OLT.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@OSD-OKW-NUMERACJA.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/przylacza_wszystkie_normalna_dl.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@newDlPoBudynku.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@uklad_mieszkan_kable_osd.lsp")
(load "C:/Users/signaline.pl/Desktop/Piotr P/test/Signaline/!lsp/@OPP_OSD_OKH_OKW.lsp")
(print)
(print "Loaded lsp files")
(princ)
)
(@load_lsp)








