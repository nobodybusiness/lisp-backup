;;;opis ogólny edycji skrótów w tym pliku
;;; w celu zmiany skrótu nalezy zmienic tekst po ci¹gu [c:] czyli ogólnie skrót o tresci [nowy_skrot] bedzie mia³ zapis (defun c:nowy_skrot
;;;zaleca sie skopiowanie niniejszego pliku przed zmianami
;;; w celu wylaczenia danej funkcji(skrotu do niej) linie z ta funkcja nalezy poprzedzic srednikiem [;] czyli "wyremowac" uwaga dotyczy rownie roznego typu komentarzy
;;; wprowadzone zmiany beda dzia³a³y po ponownym wcytaniu TeKAD'a lub tylko pliku <tkd_abc_skróty> poleceniem <appload>
;;; nalezy pamietac ze skróty w tym pliku po wczytaniu TeKAD'a sa nadrzedne nad skrótami autocad'a (tymi z pliku *.pgp)
;;;====================================================================================================================
(defun c:logo () (#flogo))
;;pokazuje logo TeKAD'a
;;;============================zbrojenie==================================================
;;;=============================================================================================================================
(defun c:zss () (#fpret "tworzenie" nil))
;;funkcja pozwala stworzyc lub przej¹c gemetrie preta zbrojeniowego , funckaj tworzy równiez opis preta  w postaci bloku z atrybutami
(defun c:zs () (#frozklad))		;program rysuje ropzklad zbrojenia
(defun c:zb ()
  (#fpolyline_warstwa "tkd_zbrojenie_schemat" 8)
)
;;polecenie rysuje polilinia zbrojenie na warstwie <tkd_zbrojenie_schemat>
(defun c:a () (#fabc_test))		;funkcja testuje poprawnosc narysowanego zbrojenia z wynikami z ABC P³yty
(defun c:ee () (#fpred))		;EDYCJA ZBROJENIA						
(defun c:zxx ()
  (#fact)
  (#fopis_pojedynczy
    (if	(= uww_fk "0")
      ""
      uww_fk
    )
  )
  (#fback)
)					;opis pretow w rozkladzie pojedynczym	"tkd_zelbet"
(defun c:wa () (#frysuj_sciane))	;program rysuje przekroj sciany
(defun c:sll () (#frysuj_slup))		;program rysuje slupy zelbetowe
(defun c:sa () (#fscalaj 1 nil nil nil)) ;scalanie rozk³adu zbrojenia
(defun c:tes () (#ftester))		;zbior funkcji testujacych obiekty stworzone przez TeKAD'a
(defun c:ki () (#fcopypret))		;kopiuje jeden rozk³ad zbrojenia ze scaleniem	
(defun c:kpp () (#fkopp))		;"kopiuje z filtrem po zbrojeniu				"
(defun c:k () (#fkopiuj_zbrojenie_scal));kopiuje zbrojenie wraz z opisami i scala
(defun c:mii () (#flustro_zbrojenie_scal))
					;zmieniona funkcja mirror scala zbrojenie w rozk³adzie
(defun c:WYC () (#FPWYC))		;WYRZUCA PRET I OPISUJE GO
(defun c:es () (#feska1))		;program rysuje pret typ es(spinka w scianach)
(defun c:wyy () (#fwykaz_new))		;program tworzy wykaz stali zbrojeniowej
(defun c:ad () (#fapdejt))		;funkcja apdejt						
(defun c:lp () (#flistp))		;lista uzytych aktualnie pretów				
(defun c:si () (#Fsiatka))		;program pozwala obliczyc ilosc siatki podstawowej						
(defun c:opis () (#fopsd1))		;opisuje segmenty preta (linia, polilinia) i wyrzuca opis	
(defun c:qz () (#fkalkulator_srednic))	;kalkulator srednic
(defun c:zak () (#fzak))
;;kalkulator dlugosci zakotwienia
(defun c:pll () (#frysuj_prety))
;;rysuje polilnie o zadanej sredncu i otuleniu
(defun c:pp () (#fwstaw_pret_przekroj))	;wstawie kropke oznaczajac pret w przekroju
(defun c:prz () (#fzmien_pret_przekroj));zmienia wype³nione kropki na puste i odwrotnie
(defun c:ren () (#frenumeracja))	;renumeruje prety we wskazanym obszarze
(defun c:opi () (#fopis_zbr_przek))	;opisuje zbrojenie w przekroju lub w widoku
(defun c:sx () (#fuzgadniaj_opisy))	;funkcja uzgadnia srednice i numery pretów na podstawie wskazanego preta lub atrubutu
(defun c:ls () (#flicz_strzem))		;liczy strzemiona na warstwie <tkd_strzem*> gdzie * oznacza kazdy ci¹g znaków
(defun c:ry () (#fkreskuj_zbrojenie))
;;kreskuje rozklady zbrojenia
(defun c:wr (/ ob)
  (setq	ob (SSGET "X"
		  '((-4 . "<OR")
		    (8 . "tkd_prety_temp")
		    (8 . "tkd_obrys_temp")
		    (8 . "tkd_prety_X")
		    (8 . "tkd_prety_Y")
		    (-4 . "OR>")
		   )
	   )
  )
  (if ob
    (progn (command "_.erase" ob "")
	   (princ
	     (strcat "\ndelete " (rtos (sslength ob) 2 0) " items")
	   )
	   (princ)
    )
  )
  (progn (princ "\n Brak elementów!") (princ))
)					;usuwa narysowane kreskowanie rozkladów
(defun c:tww () (#ftest_opis_segmenty))	;testuje czy opisane segmenty pretow sa dobre - czy nie ma przesunietych punktów wymiarow opisujacych segmenty
;;;====================================
(defun c:fz () (#fszukaj_preta_kl))
;;szuka preta o podanym numerze
;;;=====================lispy ogólne=================================================================
(defun c:sk () (#fskal))		;ustawienia skali i jednostek		  		
(defun c:OU () (#fobru))		;OBRÓT UK£ADU WSPÓ£RZÊDNYCH NA PODST. WSK OB.			
(defun c:dd () (#fdli))			;komenda dimlinear						
(defun c:dg () (#fdg))			;komenda dimaligned						
(defun c:dc () (#fdc (list nil (getvar "lastpoint"))))
					;komenda dimcontinue
(defun c:da () (#fdim_angular))		;polecenie dimangular
(defun c:ot () (#fhole))		;tworzenie oznaczenia graficznego otworów w plytach
(defun c:opo () (#fotwor_strop_opis))	;program opisuje otwory rysowane kolkiem lub polinia
(defun c:ott () (#fhole_wall))		;tworzenie oznaczenia graficznego otworów w scianie
(defun c:sch () (#fschody))		;funkcja rysuje przekroj przez bieg schodowy
;;dzialania na warstwach================================================================
(defun c:wo () (#flay_on_thaw))		;w³¹cza i odmraza wszystkie warstwy
(defun c:ww () (#flay_on))		;w³¹cza wszystkie warstwy
(defun c:th () (#flay_thaw))		;odmraza wszystkie warstwy
(defun c:ew () (#flaye))		;usuwa wszystkie el. na wskaz. warstwie			
(defun c:u () (#flayu))		;ustawia aktywn¹ warstwê wskazanego el.		
(defun c:oo () (#flaoff))		;wylacza warstwe  wskazanego el.
					;(defun c:fr  ()  (#flafreeze));zamraza warstwe  wskazanego el.
(defun c:fr () (command "_layfrz"))	;zamraza warstwe  wskazanego el.
(defun c:lo () (#flayiso))		;izoluje warstwe wskazanego elementu			
(defun c:aw () (#flayprz))		;przenosi wskazane obiekty na aktualna warstwe
;;;==funkcje opisowo-tekstowe===============================================================================
(defun c:t15 () (#fptxt "15" "1" 5))	;tworzenie opisu stylem z czcionk¹ simplex h=2mm po wydruku  			
(defun c:t20 () (#fptxt "20" "1" 6))	;tworzenie opisu stylem z czcionk¹ simplex h=2mm po wydruku
(defun c:t22 () (#fptxt "22" "1" 1))	;tworzenie opisu stylem z czcionk¹ simplex h=2.2mm po wydruku
(defun c:t25 () (#fptxt "25" "1" 7))	;tworzenie opisu stylem z czcionk¹ simplex h=2.5mm po wydruku  					
(defun c:t35 () (#fptxt "35" "1" 2))	;tworzenie opisu stylem z czcionk¹ simplex h=3.5mm po wydruku  					
(defun c:t50 () (#fptxt "50" "1" 3))	;tworzenie opisu stylem z czcionk¹ simplex h=5mm po wydruku  			    		 
(defun c:t70 () (#fptxt "70" "1" 4))	;tworzenie opisu stylem z czcionk¹ simplex h=7mm po wydruku
(defun c:tt15 () (#fptxt "15" "2" 5))	;tworzenie opisu stylem z czcionk¹ romand  h=2mm po wydruku  					 
(defun c:tt20 () (#fptxt "20" "2" 6))	;tworzenie opisu stylem z czcionk¹ romand  h=2mm po wydruku
(defun c:tt22 () (#fptxt "22" "2" 1))	;tworzenie opisu stylem z czcionk¹ romand h=2.5mm po wydruku
(defun c:tt25 () (#fptxt "25" "2" 7))	;tworzenie opisu stylem z czcionk¹ romand h=2.5mm po wydruku  			 			
(defun c:tt35 () (#fptxt "35" "2" 2))	;tworzenie opisu stylem z czcionk¹ romand h=3.5mm po wydruku  			 			 
(defun c:tt50 () (#fptxt "50" "2" 3))	;tworzenie opisu stylem z czcionk¹ romand h=5mm po wydruku  						
(defun c:tt70 () (#fptxt "70" "2" 4))	;tworzenie opisu stylem z czcionk¹ romand h=7mm po wydruku
(defun c:txta () (#ftxt_all))		;zaklada wszystkie style tekstow
(defun c:tx () (#ftx_rown))		;obraca tekst rownolegle do wskazanej linii	
(defun c:txx () (#ftx_prost))		;obraca tekst prostopadle do wskazanej linii
(defun c:un () (#funderline))		;podkresla wskazen teksty i wymiary
(defun c:no () (#fnawias_okragly))	;umieszcza wskazany tekst w nawiasie okraglym
(defun c:nk () (#fnawias_kwadratowy))	;umieszcza wskazany tekst w nawiasie okraglym
(defun c:nkl () (#fnawias_klamra))
;;umieszcza wskazany tekst w nawiasie typu klamra
(defun c:sz () (#flicz_teksty))		;liczy ilosc tekstów o danej tresci we wskazanym obszarze
(defun c:lb () (#fzliczacz))
;;;liczy bloki we wskazanym obszarze
(defun c:edd () (#fmulti_text_edit))	;edytuje do 6 wskazanych tekstów, wymiarów lub wybranych blokow z atrybutami
(defun c:su () (#fstxt))		;sumuje liczby we wskazanym obszarze
(defun c:se () (#fprzekroj))		;rysuje graficzne oznaczenie przekroju
(defun c:dgg () (#fprzekroj_zakres))	;funkcja rysuje wymiar pokazujacy zakres danego przekroju zakresy te mozna zmierzyc i zrobic zestaw
(defun c:lpr () (#fprzekroj_licz_kontrol))
					;funkcja zlicza dlugosci wymiarow opisujacych zakres danego przekroju, sprawdza rowniez ilosc narysowanych oznaczen przekrojów poleceniem #fsection
(defun c:diml () (#fprzekroj_licz))	;liczy calkowita d³ugosc danego przekroju na podstawie narysowanych wymiarow poleceniem przekroj_zakres
(defun c:ju () (#fjustuj))		; wyrównuje "do lewej" wskazane teksty
(defun c:jup () (#fjustuj_pion))	;wyrównuje w pionie odleglosci tekstów
(defun c:ko () (#fkoty))		;narzedzie do wstawiania kot i edycji rzednych
(defun c:dic () (#fslownik "1"))	;s³ownik budowlany polsko-angielski, mozna wstawiac tekst do rysunku
;;;===funkcje rozne====================================================================================
(defun c:jl () (#flines_length))	;podaje calkowita d³ugosc wskazanych linii
(defun c:jj () (#fmodl))		;wielokrotne mierzenie d³ugoœci
(defun c:ob () (#fpolyline_warstwa "tkd_obrys" 4))
;;polecenie polyline - polinia na warstwie tkd_obrys => przez analogie mozna stworzyc podobne funkcje
(defun c:nn () (#fpolyline_warstwa "tkd_nadpro¿a" 2))
;;polecenie polyline - polinia na warstwie tkd_nadpro¿a => przez analogie mozna stworzyc podobne funkcje
(defun c:bb () (#fpolyline_warstwa "tkd_belki" 3))
;;polecenie polyline - polinia na warstwie tkd_nadpro¿a => przez analogie mozna stworzyc podobne funkcje
(defun c:ff () (#fpolyline_warstwa "tkd_fundamenty" 22))
;;polecenie polyline - polinia na warstwie tkd_fundamenty
(defun c:zz ()
  (#fpolyline_warstwa "tkd_zakresy_zbrojenia" 45)
)
;;polecenie polyline - polinia na warstwie tkd_nadpro¿a => przez analogie mozna stworzyc podobne funkcje
(defun c:wz () (#fpolyline_warstwa "tkd_obszary_wykazu" 15))
;;funkcja rysuje obwiednie z ktorej program tworzy wykaz dla danego elementu
(defun c:urw () (#furwanie_przekroju "rys"))
;;rysuje graficzne oznaczenie urwania przekroju
(defun c:ur () (#furwanie_przekroju "trim"))
;;rysuje graficzne oznaczenie urwania przekroju

(defun c:rr () (#frewizja))		;rysuje chmurke rewizyjna na warstwie TKD_rewizja
(defun c:pee (/ linie)
  (setq linie (ssget '((0 . "Line"))))
  (command "_.pedit" (ssname linie 0) "_y" "_j" linie "" "")
  (princ)
)
;;;+++++++zamienia wskazane linie na polilinie  
(defun c:sc5 () (#fscale "0.5"))	;funkcja skala z wpisanym wspolczynnikiem skalowania 0.5
(defun c:sc2 () (#fscale "2"))		;funkcja skala z wpisanym wspolczynnikiem skalowania 2
;(defun c:kr (/ obiekty)
  ;(princ "wska¿ obiekty do skopiowania")
  ;(while (not obiekty) (setq obiekty (ssget)))
  ;(#fcopr obiekty)
;)					;ulepszenie polecenia szyk
;;;==funkcje ogólne====================================================================================
(defun c:ss () (#fsld))			;kreskowanie solidem	  					
(defun c:sbb () (#fsendback))		;wysy³a solidy na spód 					
(defun c:kk () (#fkalkulator))		;kalkulator 						
(defun c:dr () (#ftekad_drewno))
;;;okno umozliwiajace wspomagajace rysowanie konstrukcji drewnianych
(defun c:pro () (#fstal_profile))	;wstawia profile stalowe
(defun c:sw ()
  (princ "wprowadzanie")
  (#fstal_opis "tworzenie" nil)
)					;wstawia opis elementów stalowych
;;;==========zoomy====================================================================================
(defun c:zx () (#fzomm_zx))		;zoom oddalajacy o 2x
(defun c:xx () (#fzoom_xx))
;;inna propozyzja zoomów
;;;++++++++++++++++++++++++++++funkcje wspomagajace snapy+++++++++++++++++++++++++++++++++++++++++++++
(defun c:bt () (#fpkt_mid))		;zwraca punkt w srodku miedzy dwoma wskazanymi polecenie nalezy wywolywac nak³adkowo tzn z uzyciem '
(defun c:sp ()
  (setvar "osmode" 695)
  (princ "\rOsmode = 695")
  (princ)
)					;ustawia wartosc zmiennej osnap na 695
;;;==================================================================================================
;;;++++++++++++++++++++++++++++skróty do komend autocada+++++++++++++++++++++++++++++++++++++++++++++
(defun c:aa () (command "_.area"))
(defun c:al () (command "_.align"))
(defun c:ar () (command "_.array"))
(defun c:bo () (command "_.boundary"))
(defun c:br () (command "_.break" pause "_f" pause "@"))
;;funkcja break przerywa w jednym punkcie
(defun c:brr () (command "_.break" pause "_f" pause pause))
;;funkcja break przerywa w dwóch punktach
(defun c:ci () (command "_.circle"))
(defun c:do () (command "_.donut"))
(defun c:dt () (command "_.dtext"))
(defun c:ed () (command "_.ddedit"))
(defun c:el () (command "_.ellipse"))
(defun c:X () (command "_.extend"))
(defun c:f () (command "_.fillet"))
(defun c:i () (command "_.insert"))
(defun c:d () (command "_.dist"))
(defun c:c (/ ent)
  (setq ent (ssget))
  (command "_.copy" ent "" "_m")
)					;kopiuje z domyslnym multiple
(defun c:l () (command "_.line"))
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
(defun c:red () (command "_.redraw"))
(defun c:re () (command "_.regen"))
(defun c:r () (command "_.rectangle"))
(defun c:ro () (command "_.rotate"))
					;(defun c:s  ()  (command "_.stretch")) 
(defun c:sb () (command "draworder"))
(defun c:sc () (command "_.scale"))
(defun c:spl () (command "_.spline"))
(defun c:t () (command "_.trim"))
(defun c:Ex () (command "_.explode"))
(defun c:z () (command "_.zoom"))
(defun c:za () (command "_.zoom" "_p"))
(defun c:zd () (command "_.zoom" "_d"))
(defun c:mm () (command "_.MATCHPROP"))
(defun c:ref () (command "_.refedit"))
					;(defun c:zx ()  (command "_.zoom" ".5x" )(princ))
;;;=======================================================================================================
;;;zmienne autocada
(setvar "plinetype" 1)			;zmiennaa okresla tyyp polilinii gdy 1 to <lwpolyline>, 0 <polyline>
(command "ucsicon" "n")			;polecenie powoduje ze oznaczenie uk³adu wspólrzednych jest na sta³e w lewym rogu acada
;;skróty 06-10-2005
(defun c:bl () (#fbloki))		;wstawia wybrane bloki TeKAD'a
(defun c:dw () (#FDZIEL_ROZKLAD))	;wstawia wybrane bloki TeKAD'a
(defun c:lss (/) (#flicz_zbr_sztuki 1 1 1 1 1))
					;zlicza sztuki pretów lub strzemion 
;;;=14-11-2005====================================================================================================================
(defun c:spp () (#fzbr_pow nil))	;siatka podstawowa zliczanie
;;;=26-11-2005====================================================================================================================
(defun c:eds () (#fedycja_glob))	;zmiana globalna klasy zbrojenia
(defun c:lz () (@load_zbrojenie))	;wczytanie wyników z abc
;;;=11-01-2006=======================
(defun c:pk (/) (#fminsert nil))	;funkcja wstawia blok [tkd_rebar] typu minsert
(defun c:wal (/) (#wwy_all))
;;funkcja zak³ada warstwy wg danych zawartych w pliku [layers.dan] w katalogu dane
(defun c:ka () (#fkantuj))		;program rysuje ³amana w oparciu o wskazane ³uki i ko³a
;;;;=13-01-2006====================
(defun c:s1 () (#fskala 1))
;;ustawia skale na 1:1
(defun c:s2 () (#fskala 2))
;;ustawia skale na 1:2
(defun c:s5 () (#fskala 5))
;;ustawia skale na 1:10
(defun c:s10 () (#fskala 10))
;;ustawia skale na 1:10
(defun c:s20 () (#fskala 20))
;;ustawia skale na 1:20
(defun c:s25 () (#fskala 25))
;;ustawia skale na 1:25
(defun c:s50 () (#fskala 50))
;;ustawia skale na 1:50
(defun c:s75 () (#fskala 75))
;;ustawia skale na 1:75
(defun c:s100 () (#fskala 100))
;;ustawia skale na 1:100
(defun c:s150 () (#fskala 150))
;;ustawia skale na 1:100
(defun c:s200 () (#fskala 200))
;;ustawia skale na 1:200
;;;;01-03-2006--------------------------------------------
(defun c:z5 () (#f0.5%_zakres))		;program rysuje linie w odleg³osci 0.25L mniejszej rozpietosci stropu...
;;30-03-2006;;;=========================================================
(defun c:de () (#fdetal_ozn))		;rysuje circle na warstwie tkd_detale
(defun c:mr () (#fmove_rotate))		;przesuwa i obraca
(defun c:bc () (#fbocad1))		;usprawnienie bocada
(defun c:bcc () (#fbocad2))		;usprawnienie bocada2
;;27-10-2007;;;=========================================================
(defun c:dre () (#fdrewwykaz))		;wykaz drewna
;;;==27-11-2007
(defun c:sd () (#fpolyline_warstwa "tkd_strz_zakres" 33))
;;polecenie polyline - polinia na warstwie tkd_strz_zakres
(defun c:lk ()
  (princ
    "\n Wska¿ obszar do aktualizacji iloœci strzemion w opisach"
  )
  (#faktualizuj_szt_strzem
    (ssget '((-4 . "<AND")
	     (0 . "LWPOLYLINE")
	     (8 . "tkd_strz_zakres")
	     (-4 . "AND>")
	    )
    )
  )
)
;;;==03-12-2007=========================
(defun c:str () (#fline_warstwa "tkd_strzemiona" 200))
;;polecenie polyline - polinia na warstwie tkd_strz_zakres
(defun c:fo () (#fline_warstwa "dxfoczka" 42))
;;polecenie polyline - polinia na warstwie tkd_strz_zakres
(defun c:exx () (#fextend_rebars))	;wyd³ua i apdejtuje zbrojenie w rozk³adzie
(defun c:mip () (#fpret_mirror))	;zmienia orientacje pretów w rozk³adzie
(defun c:qw () (#fkoryguj_segmenty))	;koryguje segmentu wg róznych kryteriów
;;;==04-12-2007=================================================================================================
(defun c:sci () (#fpolyline_warstwa "tkd_sc_konstr" 2))
;;polecenie polyline - polinia na odpowiedniej warstwie===
(defun c:zaz () (#flayiso1 "tkd_zaznacz"))
(defun c:sca () (#flayiso1 "tkd_do_scalenia"))
;;;==08-12-2007===========================================================================================================
(defun c:fs () (#fpolyline_warstwa "tkd_pfund_spód" 9))
;;polecenie polyline - polinia na warstwie tkd_pfund_spód
;;;==15-12-2007===========================================================================================================
(defun c:wi () (#fpolyline_warstwa "tkd_widokowa" 7))
;;polecenie polyline - polinia na warstwie tkd_widok
;;;==17-12-2007===========================================================================================================
(defun c:dii ()
  (#fdim_test
    (ssget '((0 . "DIMENSION") (3 . "tkd_1*") (8 . "tkd_wym*")))
  )
)
;;znajduje wspóliniowe wymiary
;;;23-01-2008---------------------------------
(defun c:ops () (#opis_slupa))		;rysuje automatycznie opis s³upa na podstawie wskazanych osi i pozlilinii lub kó³ka obrysu s³upa
;;;01-02-2008---------------------------------
(defun c:bel () (#fbelka_przekroj))	;rysuje przekrój belki
(defun c:was () (#fmanager_warstw))	;menadzer warstwi kreskowan
(defun c:pow () (#fpomiar))		;narzedzie typu distance+area
;;;=06-03-2008=======================================================
(defun c:nu () (#fnumerowanie))		;numerowanie============================
;;;=14-03-2008=======================================================
(defun c:mipi () (#fmirror_blok 0))	;mirroruje wybrane bloki z atrybutami
(defun c:mipo () (#fmirror_blok 90))	;mirroruje wybrane bloki z atrybutami
(defun c:wyn () (#fabc_wyniki))		;steruje wyswietlaniem wyników ABC======
(defun c:tab () (#ftabelka))
;;tabelka
(defun c:uw () (#fguwagi))
;;generator uwag
(defun c:du () (#flitery_duze))
;;tabelka
(defun c:ma () (#flitery_male))
;;generator uwag
(defun c:tc () (#fzmien_na_C))		;zmienie bigle i haki w narysowanych prêtach [tkd_zelbet]
					;==========================
(defun c:dh () (command "_dimedit" "home"))
;;przywraca po³o¿enie pierwotne tekstu wymiarowego
(defun c:dis () (command "_DIMDISASSOCIATE"))
					;pozwala na wy³¹czenie powi¹zania wymiarowania z obiektem
(defun c:spo () (#fspoiny))
;;wstawia bloki opisu spoin
(defun c:dx () (#fdo_dxf_foczki))	;pomaga tworzyc siatke do dxfoczki
;;;======================================================
(defun c:fu () (#flawy))
;;;; wspomaga rysowanie przekrójów ³aw fundamentowych
;;;==2014 02 22======================================================================
(defun c:dtt () (#fwpisanewymiary))	;sprawdza czy w rysunku s¹ wpisane wymiary
(defun c:wsk () (#fwskaznik_zuzycia))	;przelicza wskaznik zuzycia stali na wstawionych blokach
(defun c:qe () (#fquick_edit))		;szybka edycja preta
;;;=========================================================================================
(defun c:iko () (#fikony_pretow))	;wstawia ikony z ksztaltami zbrojenia [tkd_zelbet]
(defun c:xd () (#fbez_xdata))		;usuwa dane do wykazu z rozkladu - opis i pret pozostaj¹ [tkd_zelbet]
(defun c:zab () (#fzm_bl_szt))		;zamienia bloki opisowe bez sztuk na sztuki i odwrotnie [tkd_podstawowe]
(defun c:sq () (#fstal_opis_dod))	;wstawia tzw opis balonikowy stali profilowej [tkd_stal]
(defun c:edp () (#fstal_prof_edycja))
;;;edycja opisu stali profilowej
(defun c:wykp () (#fstal_prof_wykaz))
;;;wykaz opisu stali profilowej
(defun c:dw () (#FDZIEL_ROZKLAD))	;dzieli rozklad
(defun c:spp () (#fzbr_pow nil))	;siatka podstawowa zliczanie
(defun c:pk (/) (#fminsert nil))	;funkcja wstawia blok [tkd_rebar] typu minsert
(defun c:scal () (#fscalaj 1 nil nil nil)) ;scalanie rozk³adu zbrojenia
					;===================================================================
					;Wywo³anie funkcji moich++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
(load
  "C:\\tekad_abc_ 17\\baza\\Liczenie_potrzebnego_zbrojenia.lsp"
)
(load "C:\\tekad_abc_ 17\\baza\\poprzedni_wybor.lsp")
					;xliny
(defun c:hh ()
  (command "_layer" "_set" "tkd_pomoce"	"" "_.xline" "_h" pause)
)
(defun c:vv ()
  (command "_layer" "_set" "tkd_pomoce"	"" "_.xline" "_v" pause)
)
(defun c:aa ()
  (command "_layer" "_set" "tkd_pomoce"	"" "_.xline" "_a" pause)
)
					;zgubione tb
(defun c:tb () (#fzmien_na_B))		;zmienie pret na typ B  [tkd_zelbet]
					;pomoce
(defun c:ze () (#fhatch "zelbet" "auto" "0"))
(defun c:iz () (#fizoluj_zbrojenie))	;izoluje prety po numerach  [tkd_zelbet]
(defun c:ka () (#fkantuj))		;program rysuje ³amana w oparciu o wskazane ³uki i ko³a
					;skroty do warstw
					;(defun c:1 ()(command "_layer" "_set" "mard_konstrukcja_pod" "" "_.pline" pause))
					;(defun c:2 ()(command "_layer" "_set" "mard_konstrukcja_nad" "" "_.pline" pause))
					;(defun c:5 ()(command "_layer" "_set" "mard_mur_pod" "" "_.pline" pause))
					;(defun c:3 ()(command "_layer" "_set" "mard_belki" "" "_.pline" pause))
					;(defun c:4 ()(command "_layer" "_set" "mard_obrys_plyty" "" "_.pline" pause))
					;(defun c:$addlayer$ ()(command "_layer" "_make" "$$$pomocnicza" 9 "Continuous" 8))
					;(defun c:` ()(command "_layer" "_set" "tkd_pomoce" ""))
					;groupedit
(defun c:ge () (command "_groupedit" pause))
(load "C:\\tekad_abc_ 17\\baza\\C_layj.lsp")
(defun c:orto_test () (#forto))		; mo¿e siê przydaæ
;(load "C:\\tekad_abc_ 17\\baza\\wykaz_zebranie_funkcji.lsp")
