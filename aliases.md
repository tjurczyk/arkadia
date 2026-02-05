## `/skrypty`

Wyświetla główne okno pomocy skryptów Arkadii: przypomina o aktualizacji pakietu (`/aktualizuj_skrypty`, `/pobierz_mape`, `/kolory`), podaje odnośniki do sekcji tematycznych (`/cfg`, `/walka`, `/ekwipunek`, `/ziola`, `/ui`, `/aliasy`, `/bindy`, `/bronie`, `/pojemniki`, `/baza`) i streszcza dostępne liczniki oraz statystyki (np. `/stat`, `/postepy`, `/zabici`).

## `/konfiguracja`

Uruchamia pierwszą konfigurację skryptów. Konfigurator przeprowadzi przez podstawowe ustawienia skryptów takie jak stworzenie konfiguracji, keybindów oraz pobranie mapy.

## `/fake test`

Do testowania triggerów. Wyświetli żądaną linię i przeprocesuje ją przez silnik triggerów.
```
/fake Jestes w swietnej kondycji
```

## `/aliasy`

Otwiera dedykowaną pomoc aliasów: opisuje tymczasowe kolory (`/tcolor`), konfigurację tymczasowych bindów (`/tbind`) i multibindów lokacji (`/mbind`), a także przypomina o przełącznikach `/bind_on` i `/bind_off`.

## `/bindy`, `/keybindy`

Drukuje tabelę wszystkich aktywnych keybindów skryptów, pogrupowaną według kategorii (walka, inwentarz, poruszanie, multibindy, różne) wraz z przypisanymi skrótami i opisami.

## `/lua <kod>`

Wykonuje podany kod Lua (najpierw próbuje ocenić go jako wyrażenie i wypisać wynik).

## `/reload [moduł]`

Przeładowuje cały pakiet skryptów lub, po podaniu ścieżki modułu, tylko wskazaną paczkę Lua.

## `/init <profil> <wolacz>`

Inicjalizuje nową konfigurację profilu skryptów dla podanego imienia i wołacza.

## `/cget`

Wypisuje wszystkie wartości zapisane w konfiguracji.

## `/cget <wzorzec>`

Pokazuje tylko zmienne konfiguracyjne, których nazwy pasują do przekazanego wzorca.

## `/cset[!|!!] <klucz>=<wartość>`

Ustawia wartość zmiennej konfiguracyjnej na liczbę lub wartość logiczną (`!` uruchamia makra, `!!` pomija walidację).

## `/cset[!|!!] <klucz>="tekst"`

Zapisuje tekstową wartość zmiennej konfiguracyjnej (dostępne te same przełączniki `!`/`!!`).

## `/cset[!|!!] <klucz>[<indeks>]=<wartość>`

Aktualizuje wskazany element listy/mapy w konfiguracji wartością liczbową lub logiczną.

## `/cset[!|!!] <klucz>[<indeks>]="tekst"`

Nadaje tekstową wartość elementowi listy/mapy w konfiguracji.

## `/cdel[!|!!] <klucz>[<indeks>]`

Usuwa element listy/mapy z konfiguracji według podanego indeksu/klucza.

## `/cdel[!|!!] <klucz> <wartość>`

Kasuje wskazaną wartość liczbową lub logiczną z listy w konfiguracji.

## `/cdel[!|!!] <klucz> "tekst"`

Kasuje wskazaną wartość tekstową z listy w konfiguracji.

## `/cadd <klucz> <typ>`

Dodaje niestandardową zmienną konfiguracyjną określonego typu (`string`, `number`, `boolean`, `map`, `list`).

## `/cfg`

Wyświetla panel pomocy konfiguracji z odsyłaczami do internetowego manuala oraz listy kluczy konfiguracyjnych w repozytorium.

## `/cload <profil>`

Ładuje konfigurację profilu o podanej nazwie.

## `/cmigrate <profil>`

Migruje wskazaną konfigurację do nowego formatu.

## `/csave`

Zapisuje aktualną konfigurację profilu na dysku.

## `/laduj <profil>`

Skrót do `/cload` – ładuje konfigurację profilu o podanej nazwie.

## `/cinit <profil> <wolacz>`

Tworzy plik konfiguracji dla nowego profilu, uzupełniając go podstawowymi wartościami.

## `/kk`

Odświeża dane GMCP o obiektach, dzięki czemu drużynowy interfejs pobiera aktualne identyfikatory.

## `/zas <ID>`

Wydaje komendę zasłaniania wskazanego przeciwnika (identyfikator wrogów z listy drużynowej).

## `/zz <opis>`

Atakuje przeciwnika na podstawie podanego opisu (lub aliasu celu), automatycznie aktualizując cele drużyny.

## `/z`

Atakuje domyślnego „celu ataku”, gdy nie podano innego opisu.

## `/za <ID>`

Kieruje zasłonę na członka drużyny o podanym identyfikatorze.

## `/za`

Nakazuje zasłaniać aktualnie wskazany „cel obrony”.

## `/za <ID> <wróg>`

Tworzy wzmocnioną zasłonę – zasłania druha `ID` przed przeciwnikiem o podanym numerze.

## `/z <ID>`

Atakuje przeciwnika po numerze identyfikacyjnym (np. `ob_123` lub ID z listy GMCP).

## `/x <ID>`

Wykonuje zaskoczenie („zaskocz”) na przeciwniku wskazanym identyfikatorem.

## `/xx <opis>`

„Zaskocz” przeciwnika opisem lub aliasem, bez użycia numeru GMCP.

## `/prze <ID>`

Przełamuje obronę przeciwnika o podanym numerze, o ile kondycja na to pozwala.

## `/prze! <ID>`

Wymusza przełamanie obrony wroga bez sprawdzania poziomu zmęczenia.

## `/prze`

Przełamuje obronę bieżącego celu ataku, jeśli kondycja jest wystarczająca.

## `/prze!`

Wymusza przełamanie obrony bieżącego celu ataku.

## `/walka_restart`

Resetuje moduł drużynowy i ponownie zbiera informacje o członkach oraz przeciwnikach.

## `/walka`

Wyświetla rozbudowaną pomoc modułu walki: listę aliasów drużynowych, wskazówki dotyczące bindów oraz opis klikanych elementów interfejsu.

## `/ra <ID>`

Wydaje drużynie rozkaz ataku na przeciwnika o podanym numerze identyfikacyjnym.

## `/ra`

Nakazuje drużynie powtórzyć ostatni rozkaz ataku bez wskazywania nowego celu.

## `/rz <cel>`

Wydaje rozkaz zasłaniania postaci wskazanej identyfikatorem lub nazwą.

## `/rz`

Powtarza ostatni rozkaz zasłony bez zmian w wyborze celu.

## `/wa <ID>`

Ustawia wspólny „cel ataku” drużyny na przeciwnika o podanym numerze.

## `/wz <cel>`

Ustawia wspólny „cel obrony” drużyny na postać wskazaną identyfikatorem lub nazwą.

## `/numeruj`

Ponownie nadaje numery członkom drużyny, aby ułatwić wydawanie poleceń.

## `/por`

Porównuje twoją siłę, zręczność i wytrzymałość z przeciwnikiem, z którym aktualnie walczysz.

## `/por <ID>`

Porównuje siłę, zręczność i wytrzymałość z przeciwnikiem o podanym numerze (np. z listy wrogów lub GMCP `ob_<nr>`).

## `/por <opis>`

Porównuje statystyki z postacią dopasowaną po przekazanym opisie.

## `/w <cel>`

Wydaje polecenie wycofania wskazanego członka drużyny z walki.

## `/rb`

Aktywuje rozkaz blokowania dostępu do drużyny dla niepowołanych osób.

## `/za2 <ID>`

Kieruje zasłonę drugiej grupy na członka o podanym numerze.

## `/za2`

Powtarza ostatni rozkaz zasłony dla drugiej grupy.

## `/za3 <ID>`

Kieruje zasłonę trzeciej grupy na wskazanego członka drużyny.

## `/za3`

Powtarza ostatni rozkaz zasłony dla trzeciej grupy.

## `/za4 <ID>`

Kieruje zasłonę czwartej grupy na wybranego członka drużyny.

## `/za4`

Powtarza ostatni rozkaz zasłony dla czwartej grupy.

## `/obecni`

Pokazuje listę członków drużyny, którzy aktualnie znajdują się w pomieszczeniu.

## `/pro <lider>`

Przekazuje prowadzenie drużyny postaci o wskazanym identyfikatorze.

## `/zap <ID>`

Wysyła zaproszenie do drużyny do postaci o podanym numerze.

## `/zab`

Blokuje możliwość dołączania kolejnych postaci do drużyny.

## `/zab <ID>`

Blokuje wskazanego numerem członka drużyny.

## `/puszczaj_zaslony`

Włącza automatyczne zwalnianie zasłon na członkach drużyny.

## `/q <ID>`

Dodaje przeciwnika o podanym numerze do kolejki kolejnych ataków.

## `/nn`

Wykonuje wcześniej przygotowaną sekwencję „next next” (NN) ataków.

## `/hp <cel>`

Przypomina ostatnio zgłoszone punkty życia celu lub całej drużyny.

## `/szepnij <tekst>`

Wysyła prywatną wiadomość „szept” do drużyny lub wybranej osoby.

## `/ostatnio`

Pokazuje ostatnio przekazywane komunikaty drużynowe.

## `/zap`

Zapala lampę lub inne źródło światła trzymane w ręku (moduł ekwipunku).

## `/nlo`

Napełnia lampę paliwem, aby wydłużyć jej działanie.

## `/zg`

Gasi lampę, aby ograniczyć zużycie paliwa lub ukryć światło.

## `/ekwipunek`

Prezentuje pomoc modułu ekwipunku – opisuje bindy lampy, konfigurację zbierania łupów i komendy do obsługi magii.

## `/odloz_magie [do <torba>]`

Odkłada zwoje lub magiczne przedmioty do domyślnego lub wskazanego pojemnika.

## `/przejrzyj [<torba>]`

Przegląda zawartość domyślnego lub wskazanego pojemnika na magię.

## `/zbieranie <tryb>`

Ustawia tryb automatycznego zbierania łupów na wybrany profil.

## `/zbieranie`

Wyświetla pomoc dotyczącą konfiguracji zbierania łupów.

## `/zb`

Rozpoczyna automatyczne zbieranie łupów według aktualnych ustawień.

## `/zb!`

Wymusza zbieranie łupów, nawet jeśli mechanizmy bezpieczeństwa by je pominęły.

## `/zbieranie_monet <limit>`

Ustawia próg ilości monet zbieranych podczas plądrowania.

## `/zbieraj_extra <lista>`

Pozwala wskazać dodatkowe przedmioty, które mają być zbierane ponad standardowe ustawienia.

## `/nie_zbieraj_extra <lista>`

Usuwa wskazane przedmioty z listy dodatkowych łupów.

## `/zbierz`

Podnosi monety i łupy z ciał znajdujących się w pomieszczeniu.

## `/wem`

Wyciąga monety z pierwszej torby na pasie.

## `/wem<nr>`

Wyciąga monety z konkretnej torby na pasie oznaczonej numerem.

## `/wlm`

Wkłada monety do pierwszej torby na pasie.

## `/wlm<nr>`

Wkłada monety do torby na pasie o podanym numerze.

## `/wdp <opis>`

Wkłada przedmiot do pierwszego pojemnika w ekwipunku pasującego do opisu.

## `/wdp<nr> <opis>`

Wkłada przedmiot do pojemnika na pasie oznaczonego numerem.

## `/wzp <opis>`

Wyciąga przedmiot pasujący do opisu z pierwszego pojemnika w ekwipunku.

## `/wzp<nr> <opis>`

Wyciąga przedmiot z pojemnika na pasie o konkretnym numerze.

## `/wlp`

Wyciąga pojemnik z pasa do ręki.

## `/wlp<nr>`

Wyciąga pojemnik o określonym numerze.

## `/wep`

Wkłada pojemnik z ręki na pierwszy slot pasa.

## `/wep<nr>`

Wkłada pojemnik z ręki na slot pasa o wskazanym numerze.

## `/pojemniki`

Wyświetla pomoc dotyczącą obsługi pojemników i pasów.

## `/pojemnik`

Pokazuje informacje o aktualnie trzymanym pojemniku.

## `/napraw`, `/naprawa`

Oddaje przedmioty do kowala w celu naprawy.

## `/napraw_ubrania`

Przekazuje do naprawy wszystkie elementy ubioru.

## `/db`

Wyciąga broń z pierwszego slotu pasa.

## `/db<nr>`

Wyciąga broń z pasa o konkretnym numerze.

## `/ob`

Odkłada broń trzymaną w ręku na pierwszy slot pasa.

## `/ob<nr>`

Odkłada broń na slot pasa o podanym numerze.

## `/bronie`

Wyświetla pomoc dotyczącą zarządzania uzbrojeniem.

## `/sprzet`

Ocenia stan broni i zbroi znajdujących się w ekwipunku.

## `/tbind`

Wyświetla listę aktywnych tymczasowych bindów `temp1`–`temp4` oraz przypisane do nich sekwencje poleceń.

## `/tbind<nr> <tekst>`

Przypisuje sekwencję poleceń do tymczasowego binda `temp<nr>` (1–4); obsługuje łączenie kilku komend `#` i opóźnienia `*`.

## `/tbind_reset`

Resetuje wszystkie wpisy `tbind` do wartości domyślnych.

## `/bind_on`

Ponownie włącza wszystkie keybindy zdefiniowane przez skrypty Arkadii.

## `/bind_off`

Tymczasowo wyłącza wszystkie keybindy skryptów Arkadii bez kasowania ich konfiguracji.

## `/depozyt`

Aktualizuje informacje o stanie kont bankowych.

## `/depozyty`

Wypisuje listę znanych banków i zgromadzonych w nich środków.

## `/ziola_buduj`

Buduje listę ziół w oparciu o aktualne informacje z mapy.

## `/wezz <ziolo> <ilość>`

Wyjmuje określoną liczbę wskazanych ziół z woreczka.

## `/wezz <ziolo>`

Wyjmuje pojedynczy egzemplarz wskazanego zioła.

## `/_ziola_pokaz`

Pokazuje zioła w formacie kompatybilnym ze starszym modułem.

## `/ziola_pokaz`

Wyświetla zestawienie ziół według aktualnego modułu.

## `/woreczki_pokaz!`

Prezentuje szczegółowe zestawienie ziół z podziałem na woreczki.

## `/woreczki_pokaz`

Wyświetla skróconą listę ziół w poszczególnych woreczkach.

## `/ziola`

Pokazuje okno z odnośnikiem do internetowego poradnika zarządzania ziołami.

## `/zapakuj <ilość> <ziolo>`

Pakuje wskazaną liczbę ziół do woreczka.

## `/przeszukaj_ziola <wzorzec>`

Wyszukuje zioła pasujące do podanego wzorca.

## `/ziola_przepakuj <worek> <docelowy>`

Przepakowuje zioła między woreczkami według numerów.

## `/woreczki_buduj`

Buduje strukturę danych przechowującą woreczki i ich zawartość.

## `/ziola_daj <cel> <ziolo> <ilość>`

Przekazuje wskazane zioła członkowi drużyny.

## `/ziola_daj <cel> <ziolo>`

Przekazuje pojedynczy egzemplarz zioła drużynowemu adresatowi.

## `/ziola_odloz_woreczek <worek>`

Odkłada cały woreczek z ziołami o podanym numerze.

## `/zshow`

Wyświetla grupowanie ziół według kategorii.

## `/zshow!`

Wyświetla pełną listę ziół we wszystkich kategoriach.

## `/zshow <kategoria>`

Wyświetla tylko zioła z wybranej kategorii (`zme`, `kon`, `man`, `odt`, `wzm`, `poz`).

## `/zapl <kategoria>`

Nakłada zestaw ziół pasujących do wskazanej kategorii w trybie inteligentnym.

## `/zapl! <kategoria>`

Resetuje ustawienia inteligentnego nakładania ziół dla wybranej kategorii.

## `/zapl`

Pokazuje aktualną kolejkę inteligentnego nakładania ziół dla kategorii `kon`, `man` i `zme`.

## `/ktoto <opis>`

Wyszukuje osoby w bazie po fragmencie opisu i wypisuje pasujące wpisy.

## `/osoba <ID>`

Wyświetla szczegółowe informacje o osobie zapisanej w bazie pod wskazanym numerem ID.

## `/przeszukaj <opis>`

Przeszukuje bazę osób po wielu polach, umożliwiając odnalezienie wpisu po części danych.

## `/przypomnij <skrót>`

Znajduje zapisane osoby po skrócie lub aliasie i wypisuje ich dane.

## `/wrogowie`

Pokazuje listę osób oznaczonych jako wrogowie wraz z podstawowymi informacjami.

## `/dodaj_osobe <imie>#<opis>[#<tytuł>]`

Dodaje nową osobę do bazy, przyjmując imię oraz opis (opcjonalnie tytuł) oddzielone znakiem `#`.

## `/usun_osobe <ID>`

Usuwa wpis o wskazanym numerze ID z bazy osób.

## `/dodaj_do_gildii <osoba> <gildia>`

Przypisuje osobę (ID lub imię) do wybranej gildii zapisanej w bazie.

## `/dodaj_do_gildii <osoba>`

Usuwa powiązanie gildyjne dla wskazanej osoby, pozostawiając ją bez gildii.

## `/zgildiowani <gildia>`

Wyświetla listę osób z bazy przypisanych do danej gildii.

## `/gildie`

Wypisuje wszystkie gildie zdefiniowane w bazie wraz z ich skrótami.

## `/baza`

Wyświetla szczegółowy opis modułu bazy osób, podając liczbę zapisanych wpisów, listę przechowywanych pól oraz zestaw dostępnych komend.

## `/widziani`

Pokazuje, kogo ostatnio widziano wraz z czasem ostatniego spotkania.

## `/aktualizuj <ID> <pole> <wartość>`

Aktualizuje imię (`imie`), opis (`short`) lub tytuł (`title`) osoby o podanym ID.

## `/nabindach`

Wyświetla aktualnie skonfigurowane bindy ofensywne dla członków drużyny.

## `/nabindach-`

Resetuje zapisane bindy ofensywne do wartości domyślnych.

## `/przedstawieni`

Otwiera okno z listą ostatnio przedstawionych oraz zapamiętanych postaci, umożliwiając szybkie zapisywanie imion.

## `/med`, `/medytuj`

Uruchamia sekwencję medytacji oraz ocenę podstawowych cech postaci.

## `/zde`

Automatycznie zdenominuje posiadane monety i odłoży je z powrotem do sakiewki.

## `/stat`

Wyświetla statystyki walki (ciosy, parowania itp.) zbierane przez moduł skryptów.

## `/stat2`

Pokazuje alternatywny układ raportu statystyk walki.

## `/stat_log <tryb>`

Ustawia poziom szczegółowości zapisu statystyk (0 – wyłączone, 1 – skrót, 2 – pełny).

## `/stat_reset`

Resetuje zebrane statystyki walki do zera.

## `/ocenkamienie`

Wycenia posiadane kamienie szlachetne według znanych wartości.

## `um`, `umiejetnosci[ <kategoria>]`

Wyświetla listę umiejętności, opcjonalnie ograniczając ją do wskazanej kategorii.

## `jezyki`

Prezentuje poziomy znajomości języków postaci.

## `/eksploruj`

Przełącza tryb eksploracji, który podkreśla nowe lokacje podczas wędrówki.

## `/kolory`

Wyświetla listę dostępnych nazw kolorów Mudleta.

## `/expstart`

Resetuje licznik czasu doświadczenia, rozpoczynając nowe pomiary tempa expienia.

## `/porownaj_ze_wszystkimi`

Porównuje statystyki z wszystkimi przeciwnikami w kolejce modułu walki.

## `/chat`

Otwiera okno czatu skryptów Arkadii.

## `/licz_poziom`

Uruchamia kalkulator poziomu, wyliczający postęp na podstawie aktualnych danych.

## `/cechy`

Wyświetla zestawienie cech wykorzystywane przez kalkulator poziomu.

## `/wyc`, `/wycinaj`

Rozpoczyna automatyczne wycinanie trofeów z martwych ciał według aktualnych ustawień.

## `/wyc <ID>`

Wycina trofea z konkretnego ciała wskazanego numerem.

## `/wyr`, `/wyrywaj`

Uruchamia procedurę wyrywania pazurów, kłów i podobnych elementów z zabitych stworzeń.

## `/wyr <ID>`

Wyrywa trofea z ciała o podanym numerze.

## `/postepy`

Pokazuje licznik postępów zdobytych w bieżącej sesji.

## `/postepy2`

Wyświetla globalny licznik postępów wraz z dodatkowymi szczegółami.

## `/postepy3`

Prezentuje miesięczne i roczne podsumowanie postępów.

## `/postepy_reset`

Resetuje licznik postępów z bieżącej sesji.

## `/postepy2_reset`

Czyści globalny licznik postępów.

## `/postepy2+`

Dodaje jeden postęp do globalnego licznika `postepy2`.

## `/postepy2+ <liczba>`

Dodaje naraz wskazaną (maksymalnie 15) liczbę postępów do globalnego licznika.

## `/postepy2+ <ID> <liczba>`

Zwiększa o podaną wartość wpis w globalnym liczniku oznaczony wskazanym identyfikatorem.

## `/postepy2- <ID>`

Usuwa z globalnego licznika wpis o podanym identyfikatorze.

## `/postepy2- <ID> <liczba>`

Odejmuje określoną liczbę postępów od wpisu o wskazanym identyfikatorze.

## `/postepy2_off`

Wyłącza automatyczne dopisywanie do globalnego licznika postępów.

## `/postepy2_on`

Włącza ponownie automatyczne dopisywanie do globalnego licznika postępów.

## `/zabici`

Pokazuje licznik zabitych przeciwników z bieżącej sesji.

## `/zabici_reset`

Resetuje licznik zabitych dla bieżącej sesji.

## `/zabici2`

Wyświetla globalny licznik zabitych od ostatniego resetu.

## `/zabici2!`

Pokazuje globalny licznik zabitych z podsumowaniem dziennym.

## `/zabici2 <data>`

Wyświetla log zabitych dla wskazanej daty (`rok/miesiąc/dzień`, `rok/miesiąc` lub `rok`).

## `/zabici2_reset`

Resetuje globalny licznik zabitych.

## `/oceniaj`

Ocenia sprzęt i potencjalne zagrożenie dla wykrytych wrogów.

## `/oceniaj!`

Wymusza ocenę wszystkich znajdujących się w zasięgu postaci.

## `wiedza`

Wyświetla statystyki wiedzy (książki, biblioteki) zapisane przez skrypty.

## `/wiedza`

Pokazuje pomoc dotyczącą modułu wiedzy i dostępnych poleceń.

## `/ksiazki`

Wypisuje listę znanych ksiąg wraz z postępami czytania.

## `/ksiazki!`

Pokazuje wszystkie książki, w tym ukryte lub rzadkie pozycje.

## `/biblioteki`

Wyświetla spis odwiedzonych bibliotek.

## `/biblioteki!`

Wypisuje pełną listę bibliotek wraz z dodatkowymi informacjami.

## `/abeep <poziom>`

Ustawia poziom powiadomień dźwiękowych ostrzegających o ataku (0–2).

## `/beep`

Testuje sygnał dźwiękowy ostrzegający o ataku.

## `/aktualizuj_skrypty`

Aktualizuje pakiet skryptów do najnowszego wydania ze zdalnego repozytorium.

## `/zainstaluj <repo> [<gałąź>]`

Instaluje lub aktualizuje skrypty z podanego repozytorium i opcjonalnie gałęzi.

## `/pobierz_mape`

Pobiera aktualną wersję mapy dla mappera.

## `/pobierz_mape <login> <klucz>`

Pobiera mapę przy użyciu podanego loginu i klucza dostępowego.

## `/zaladuj_mape`

Wczytuje mapę z pliku do mappera.

## `/zapisz_mape`

Zapisuje bieżący stan mapy na dysku.

## `/pobierz_baze`

Pobiera aktualną bazę osób wykorzystywaną przez moduł `people`.

## `/ui_restart`

Restartuje interfejs użytkownika skryptów (okna, belki itp.).

## `/ui`

Otwiera pomoc interfejsu graficznego, opisując komendy `/ui_restart` i `/kondycje` oraz wskazówki dotyczące odświeżania okien.

## `/kondycje`

Otwiera okno kondycji (stan zdrowia) interfejsu.

## `/ikona <tekst>`

Generuje i ustawia ikonę profilu Mudleta z podanym podpisem.

## `/mode6 [<wariant>]`

Wyświetla pomoc i przykładowe konfiguracje dla szóstego trybu stopki UI; podanie numeru prezentuje konkretny układ.

## `/zainstaluj_plugin <url>`

Instaluje plugin Mudleta z podanego adresu ZIP.

## `/odinstaluj_plugin <nazwa>`

Usuwa zainstalowany plugin o wskazanej nazwie.

## `/plugins`

Pokazuje listę zainstalowanych pluginów oraz pomoc dotyczącą modułu pluginów.

## `/list`

Otwiera kreator listów w trybie interaktywnym.

## `/list <adresat> <temat>`

Uruchamia kreator listu z wypełnionym adresem i tematem do szybkiego wysłania.

## `/mbind <slot> <polecenia>`

Przypisuje sekwencję poleceń do wskazanego slotu multibinda w bieżącej lokacji.

## `/mbind+ <polecenia>`

Dodaje kolejną akcję multibinda do pierwszego wolnego slotu w bieżącej lokacji.

## `/mbind <lokacja>`

Wyświetla multibindy zapisane dla lokacji o podanym numerze.

## `/mbind-`

Usuwa wszystkie multibindy przypisane do bieżącej lokacji.

## `/mbind- <slot>`

Kasuje multibind z konkretnego slotu w bieżącej lokacji.

## `/mbind`

Pokazuje multibindy przypisane do aktualnej lokacji.

## `/pokaz_opcje`

Wypisuje aktualne ustawienia mappera.

## `/ustaw_opcje <klucz> <wartość>`

Zmienia wskazaną opcję konfiguracyjną mappera.

## `/spe_lok <wyjście> <opis>`

Dodaje specjalne wyjście prowadzące z bieżącej lokacji do opisanej lokacji.

## `/spe <wyjście> <opis>`

Tworzy specjalne wyjście z aktualnej lokacji do miejsca opisanego tekstem.

## `/ex <kierunek> <cel>`

Dodaje standardowe wyjście z bieżącej lokacji w wybranym kierunku.

## `/exf <źródło> <kierunek> <cel>`

Tworzy wyjście między dwoma lokacjami, wskazując ich identyfikatory i kierunek.

## `/kolor <kolor>`

Koloruje bieżącą lokację na mapie wybranym kolorem.

## `/zmien_obszar <obszar>`

Przenosi lokację do innego obszaru mappera.

## `/dodaj_lok <warstwa> <pozycja>`

Dodaje nową lokację na wskazanej warstwie mapy i pozycji.

## `/dodaj_lok <pozycja>`

Dodaje lokację korzystając z domyślnej warstwy, wskazując jedynie pozycję.

## `/usun_stuby [<limit>]`

Usuwa niepołączone stuby mapy, opcjonalnie ograniczając operację do określonej liczby pokoi.

## `/wodopoj`

Oznacza bieżącą lokację jako miejsce, w którym można uzupełnić wodę.

## `/waga <wartość>`

Nadaje bieżącej lokacji wagę używaną przez wyznaczanie ścieżek.

## `/waga <lokacja> <wartość>`

Ustawia wagę wskazanej lokacji na mapie.

## `/kbind <kierunek> <polecenia>`

Przypisuje własną komendę do klawisza kierunku na mapie.

## `/kbind_reset`

Przywraca domyślne komendy dla klawiszy kierunkowych mappera.

## `/brama [<nazwa>]`

Oznacza lokację jako bramę (opcjonalnie z nazwą) do szybkiego odnajdywania.

## `/mm <obszar>`

Rysuje mapę wskazanego obszaru w osobnym oknie.

## `/zlok`

Namierza postać na mapie i przesuwa widok na bieżącą lokację.

## `/lok`

Wyświetla informacje o aktualnej lokacji mappera.

## `/lok <ID>`

Pokazuje szczegóły lokacji o wskazanym identyfikatorze.

## `/ustaw <ID>`

Ustawia bieżącą pozycję mappera na konkretną lokację.

## `/idz <skrót>`

Rozpoczyna automatyczne dojście do ścieżki zapisanej pod skrótem.

## `/idz <skrót> <opóźnienie>`

Uruchamia drogę do skrótu po odczekaniu wskazanego czasu (sekundy).

## `/idz <ID>`

Wyznacza ścieżkę do lokacji o podanym ID.

## `/idz <ID> <opóźnienie>`

Planowo rozpoczyna marsz do lokacji po upływie określonego czasu.

## `/dalej`

Kontynuuje wykonywanie wcześniej przygotowanej ścieżki.

## `/dalej <opóźnienie>`

Wznawia marsz po odczekaniu zadanej liczby sekund.

## `/pokaz_sciezke <ID>`

Podświetla trasę do wskazanej lokacji na mapie.

## `/pokaz_skroty`

Wypisuje listę zdefiniowanych skrótów tras w mapperze.

## `/dodaj_skrot <ID> <nazwa> <komendy>`

Dodaje nowy skrót prowadzący do lokacji wraz z sekwencją komend.

## `/usun_skrot <nazwa>`

Usuwa pojedynczy skrót po jego nazwie.

## `/usun_skroty`

Kasuje wszystkie zapisane skróty.

## `/dodaj_obszar <nazwa>`

Tworzy nowy obszar w bazie mapy.

## `/pokaz_obszary`

Wypisuje listę znanych obszarów.

## `/stop`

Zatrzymuje automatycznego chodzika.

## `/opoz <czas>`

Ustawia opóźnienie między krokami automatycznego chodzika.

## `/chodzik`

Wyświetla status automatycznego chodzika.

## `/szybciej`

Skraca czas między krokami chodzika.

## `/wolniej`

Wydłuża czas między krokami chodzika.

## `/chodzik wlacz`

Włącza automatycznego chodzika w aktualnej lokacji.

## `/chodzik wylacz`

Wyłącza automatycznego chodzika.

## `/pre_walk <komendy>`

Ustawia komendy wykonywane przed każdym krokiem automatycznego chodzenia.

## `/pre_walk! <komendy>`

Trwale zapisuje komendy wykonywane przed krokiem, zachowując je między sesjami.

## `/post_walk <komendy>`

Ustala komendy wykonywane po każdym kroku chodzika.

## `/post_walk! <komendy>`

Trwale zapisuje komendy wykonywane po kroku.

## `/pwalk-`

Czyści tymczasowe komendy `pre/post walk` ustawione na bieżącą sesję.

## `/pwalk!-`

Usuwa zapisane na stałe komendy `pre/post walk`.

## `/pwalk!!-`

Kasuje całą konfigurację komend związanych z automatycznym chodzeniem.

## `w`, `west`, `zachod`

Wykonuje ruch na zachód, korzystając z mappera.

## `w!`

Wymusza ruch na zachód, ignorując blokady.

## `w!!`

Powtarza wymuszony ruch na zachód z dodatkowym potwierdzeniem.

## `przemknij w`, `przemknij sie w`, `przemknij z druzyna w`

Próbuje przemknąć na zachód (samodzielnie lub z drużyną) według danych mappera.

## `e`, `east`, `wschod`

Wykonuje ruch na wschód przez mapper.

## `e!`

Wymusza ruch na wschód, pomijając blokady.

## `e!!`

Potwierdza drugi poziom wymuszonego ruchu na wschód.

## `przemknij e`

Przemknij na wschód samodzielnie lub z drużyną.

## `n`, `north`, `polnoc`

Przemieszcza postać na północ korzystając z mappera.

## `n!`

Wymusza ruch na północ.

## `n!!`

Wymusza ruch na północ z dodatkowym potwierdzeniem.

## `przemknij n`

Przemknij na północ (solo lub z drużyną) według mapy.

## `s`, `south`, `poludnie`

Wykonuje ruch na południe przez mapper.

## `s!`

Wymusza ruch na południe.

## `s!!`

Powtarza wymuszony ruch na południe z dodatkowym potwierdzeniem.

## `przemknij s`

Przemknij na południe, samodzielnie lub z drużyną.

## `sw`, `poludniowy-zachod`

Przemieszcza na południowy zachód.

## `sw!`

Wymusza ruch na południowy zachód.

## `sw!!`

Powtarza wymuszony ruch na południowy zachód.

## `przemknij sw`

Próbuje przemknąć na południowy zachód (również z drużyną).

## `se`, `poludniowy-wschod`

Kieruje postać na południowy wschód.

## `se!`

Wymusza ruch na południowy wschód.

## `se!!`

Potwierdza wymuszony ruch na południowy wschód.

## `przemknij se`

Przemknij na południowy wschód, opcjonalnie z drużyną.

## `nw`, `polnocny-zachod`

Kieruje postać na północny zachód.

## `nw!`

Wymusza ruch na północny zachód.

## `nw!!`

Powtarza wymuszony ruch na północny zachód.

## `przemknij nw`

Próbuje przemknąć na północny zachód.

## `ne`, `polnocny-wschod`

Przemieszcza postać na północny wschód.

## `ne!`

Wymusza ruch na północny wschód.

## `ne!!`

Potwierdza wymuszony ruch na północny wschód.

## `przemknij ne`

Przemknij na północny wschód (także z drużyną).

## `u`, `up`, `gora`

Wspina postać na wyższy poziom.

## `u!`

Wymusza wejście na wyższy poziom.

## `u!!`

Powtarza wymuszony ruch ku górze.

## `przemknij u`

Przemknij na wyższy poziom (sam lub z drużyną).

## `d`, `down`, `dol`

Schodzi na niższy poziom.

## `d!`

Wymusza zejście na niższy poziom.

## `d!!`

Powtarza wymuszony ruch w dół.

## `przemknij d`

Przemknij na niższy poziom (również z drużyną).

## `/lok_nazwa <nazwa>`

Ustawia nazwę bieżącej lokacji na mapie.

## `/lok_nazwa_id <ID> <nazwa>`

Nadaje nazwę wskazanej lokacji.

## `/lok_opis <opis>`

Zapisuje opis bieżącej lokacji.

## `/lok_opis_id <ID> <opis>`

Ustawia opis lokacji o podanym ID.

## `/lok_notka <notatka>`

Dodaje notatkę do bieżącej lokacji.

## `/lok_notka_id <ID> <notatka>`

Wpisuje notatkę przy lokacji o konkretnym ID.

## `/lok_notka- [<ID>]`

Usuwa notatkę z bieżącej lokacji lub wskazanego pokoju.

## `/pmap <wzorzec>`, `/przeszukaj_mape <wzorzec>`

Wyszukuje lokacje pasujące do wzorca w bazie mapy.

## `/pmap! <wzorzec>`, `/przeszukaj_mape! <wzorzec>`

Wyszukuje lokacje w całej bazie, ignorując filtrowanie obszaru.

## `/pokazuj_notki`

Przełącza wyświetlanie notatek lokacji na mapie.

## `/mapper_db`

Wyświetla pomoc dotyczącą bazy danych mappera.

## `/lok_bind <komendy>`

Przypisuje sekwencję komend wykonywanych przy wejściu do bieżącej lokacji.

## `/lok_bind_id <ID> <komendy>`

Ustawia komendy dla lokacji o wskazanym numerze.

## `/lok_bind- [<ID>]`

Usuwa komendy przypisane do bieżącej lub wskazanej lokacji.

## `/pokazuj_bindy`

Przełącza wyświetlanie przypisanych bindów lokacji.

## `/lok_team_fo <komendy>`

Ustawia komendy podążania drużyny z bieżącej lokacji, używając składni `tekst#komenda`.

## `/lok_team_fo_id <ID> <komendy>`

Przypisuje komendy podążania do wskazanej lokacji.

## `/lok_team_fo- [<ID>]`

Usuwa zapisane komendy podążania dla bieżącej lub wskazanej lokacji.

## `/dodaj_gps <opis>`

Dodaje punkt GPS opisujący bieżącą lokację.

## `/dodaj_gps_obszar <obszar>`

Dodaje punkt GPS powiązany z wybranym obszarem.

## `/dodaj_gps_lokacje <lista> <opis>`

Tworzy punkt GPS obejmujący wiele lokacji (lista ID rozdzielona przecinkami).

## `/usun_gps <ID>`

Usuwa zapisany punkt GPS.

## `/gps`

Wyświetla listę punktów GPS.

## `/gps <ID>`

Pokazuje szczegóły punktu GPS o wskazanym numerze.

## `/mapper`

Wyświetla ogólną pomoc dotyczącą mappera.

## `/mapper_opcje`

Prezentuje pomoc dotyczącą konfiguracji mappera.

## `/mapper_rys`

Pokazuje pomoc dotyczącą rysowania mapy.

## `/mapper_skroty`

Wyświetla pomoc dla skrótów mappera.

## `/pokaz_kolory`

Prezentuje legendę kolorów używanych przez mappera.

## `/idzdo <ID>`

Rozpoczyna marsz do lokacji o podanym numerze.

## `/idzdo <ID> <opóźnienie>`

Planowo rozpoczyna marsz do lokacji po zadanym czasie.

## `/pij`

Wykonuje komendę picia wody, korzystając z konfiguracji mappera.

## `/cofnij`

Wycofuje ostatni krok automatycznego chodzenia.

## `/sciezka <komendy>`

Definiuje ręczną ścieżkę do wykonania przez mappera.

## `/nastepny_kierunek`

Pokazuje kolejny kierunek w przygotowanej ścieżce.

## `/zaznaczaj`

Przełącza podświetlanie odwiedzanych lokacji na mapie.

## `/idz`

Wykonuje następny krok przygotowanej ścieżki.

## `/prowadz <imię>`

Rozpoczyna prowadzenie wskazanej osoby po mapie.

## `/prowadz-`

Kończy prowadzenie aktualnej osoby.
