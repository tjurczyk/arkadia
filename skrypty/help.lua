function scripts:print_help()
  cecho("+-------------------------- <green>Arkadia skrypty, ver " ..
    string.sub(scripts.ver .. "   ", 0, 5) .. "<grey> --------------------------+\n")
  cecho("|                                                                                |\n")
  cecho("|         <yellow>https://github.com/tjurczyk/arkadia<grey>                                    |\n")
  cecho(
    "|         <yellow>Chcesz zadotowac? <LawnGreen>Paypal: dzordzyk@gmail.com<grey>                           |\n")
  cecho("|                                                                                |\n")
  cecho("|                         -----------------------------                          |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/aktualizuj_skrypty<grey> - sciagnie aktualna wersje skryptow.                       |\n")
  cecho("| <light_slate_blue>/pobierz_mape<grey> - pobierze aktualna baze dany z serwera.                         |\n")
  cecho("| <light_slate_blue>/kolory<grey> - pokaze kolory dostepne w mudlecie (przydatne w ustawienia-skrypty).  |\n")
  cecho("|                                                                                |\n")
  cecho(
    "| <light_slate_blue>/laduj [nazwa]<grey> - zaladuje config o tej <light_slate_blue>[nazwie]<grey>. W katalogu profilu musi byc   |\n")
  cecho("| plik o nazwie <light_slate_blue>nazwa.txt<grey>.                                                       |\n")
  cecho("|                                                                                |\n")
  cecho("| <yellow>Dostepne SEKCJE:<grey>                                                               |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/cfg<grey> - pomoc dotyczaca konfiguracji.                                           |\n")
  cecho("| <light_slate_blue>/walka<grey> - walka, zaslony, bindy, itp.                                           |\n")
  cecho("| <light_slate_blue>/ekwipunek<grey> - lampy, plecaki itp.                                               |\n")
  cecho("| <light_slate_blue>/ziola<grey> - zarzadzanie ziolami.                                                  |\n")
  cecho("| <light_slate_blue>/ui<grey> - graficzne.                                                               |\n")
  cecho("| <light_slate_blue>/aliasy<grey> - aliasy.                                                              |\n")
  cecho("| <light_slate_blue>/bindy<grey> - bindy.                                                                |\n")
  cecho("| <light_slate_blue>/bronie<grey> - obsluga pojemnikow na bronie.                                        |\n")
  cecho("| <light_slate_blue>/pojemniki<grey> - bindy.                                                            |\n")
  cecho("| <light_slate_blue>/baza<grey> - baza postaci.                                                          |\n")
  cecho("|                                                                                |\n")
  cecho("| <yellow>Dostepne STATYSTYKI:<grey>                                                           |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/stat<grey> - statystyki ciosow/parowania itp.                                       |\n")
  cecho("| <light_slate_blue>/stat2<grey> - alternatywne wyswietlanie statystyk                                   |\n")
  cecho("| <light_slate_blue>/stat_reset<grey> - resetuje statystyki.                                             |\n")
  cecho("| <light_slate_blue>/stat_log [opcja]<grey> - ustawia pokazywanie logow wylapywania triggerow,           |\n")
  cecho("| ktore ida do statystyk. Dostepne opcje: 0 (wylaczone), 1 (skrocone), 2 (pelne).|\n")
  cecho("|                                                                                |\n")
  cecho("| <yellow>Dostepne LICZNIKI:<grey>                                                             |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/licz_poziom<grey> - w miejscu z medytacja obliczy aktualny poziom i ile do nast.    |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/postepy<grey> - licznik postepow w tej sesji.                                       |\n")
  cecho("| <light_slate_blue>/postepy_reset<grey> - resetuje licznik postepow sesji.                              |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/postepy2<grey> - globalny licznik postepow.                                         |\n")
  cecho("| <light_slate_blue>/postepy2+<grey> - dodaje jeden postep do globalnego licznika.                       |\n")
  cecho(
    "| <light_slate_blue>/postepy2+ [ile]<grey> - dodaje <light_slate_blue>[ile]<grey> postepow do globalnego licznika.               |\n")
  cecho("| np <light_slate_blue>/postepy2+ 4<grey> doda 4 postepy. Musi to byc liczba mniejsza badz rowna 15!     |\n")
  cecho(
    "| <light_slate_blue>/postepy2+ [id] [ile]<grey> - dodaje <light_slate_blue>[ile]<grey> postepow z globalnego licznika o <light_slate_blue>[id]<grey>.    |\n")
  cecho(
    "| <light_slate_blue>/postepy2- [id]<grey> - usuwa wpis z globalnego licznika o tym <light_slate_blue>[id]<grey>. id mozna        |\n")
  cecho("| znalezc jako pierwsza kolumna od lewej w <light_slate_blue>/postepy2<grey>.                            |\n")
  cecho(
    "| <light_slate_blue>/postepy2- [id] [ile]<grey> - odejmuje <light_slate_blue>[ile]<grey> postepow z globalnego licznika o <light_slate_blue>[id]<grey>.  |\n")
  cecho("| <light_slate_blue>/postepy2_reset<grey> - resetuje globalny licznik postepow.                          |\n")
  cecho("| <light_slate_blue>/postepy2_off<grey> - wylacza dodawanie do globalnego licznika postepow.             |\n")
  cecho("| <light_slate_blue>/postepy2_on<grey> - wlacza dodawanie do globalnego licznika postepow.               |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/postepy3<grey> - podsumowanie postepow per miesiac/rok.                             |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/zabici<grey> - licznik zabitych.                                                    |\n")
  cecho("| <light_slate_blue>/zabici_reset<grey> - resetuje licznik zabitych.                                     |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/zabici2<grey> - globalny licznik zabitych (od resetu).                              |\n")
  cecho("| <light_slate_blue>/zabici2!<grey> - globalny licznik zabitych z uwzglednieniem zabitych/dzien.         |\n")
  cecho(
    "| <light_slate_blue>/zabici2 [data]<grey> - log zabitych z dnia o <light_slate_blue>[data]<grey>.                                |\n")
  cecho("| Data musi byc w takiej formie: <light_slate_blue>[rok]/[miesiac]/[dzien]<grey>,                        |\n")
  cecho(
    "| np. <light_slate_blue>/zabici2 2017/1/22<grey>, <light_slate_blue>/zabici2 2017/1<grey> lub <light_slate_blue>/zabici2 2017<grey>                      |\n")
  cecho("| <light_slate_blue>/zabici2_reset<grey> - resetuje globalny licznik zabitych.                           |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/expstart<grey> - startuje/resetuje licznik czasowy expa (postepow).                 |\n")
  cecho("|                                                                                |\n")
  cecho("| <yellow>ZAWOD:<grey>                                                                         |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/staz [liczba] <grey> - rozpoczyna liczenie stazu w zawodzie.                        |\n")
  cecho("| Liczba to +10 za za kazdy tydzien, +1 za kazdy +staz, 100% to 240              |\n")
  cecho("| <light_slate_blue>/staz <grey> - sprawdzenie aktualnego stazu w zawodzie                               |\n")
  cecho("|                                                                                |\n")
  cecho("|                                                                                |\n")
  cecho("| <yellow>ROZNE:<grey>                                                                         |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/przedstawieni<grey> - przedstawieni z kliklanymi imionami do zapamietani            |\n")
  cecho(
    "| <light_slate_blue>/zbieranie<grey> - ustawienia zbierania. Aliasy/bindy patrz: <light_slate_blue>/ekwipunek<grey>              |\n")
  cecho("| <light_slate_blue>/eksploruj<grey> - wlacza/wylacza eksploracje (podkreslanie szczelin, dziur itp).    |\n")
  cecho("| <light_slate_blue>/depozyt<grey> - bedac w banku odswieza zawartosc depozytu w bazie tego bank.        |\n")
  cecho("| <light_slate_blue>/depozyty<grey> - Pokazuje zawartosc depozytow.                                      |\n")
  cecho("| <light_slate_blue>/chat<grey> - Pokazuje 20 ostatnich komunikatow typu comm.                           |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/ikona [imie] <grey> - Ustawia Arkadiowa ikone profilu z imieniem postaci.           |\n")
  cecho("| np. <light_slate_blue>/ikona Geralt <grey>                                                             |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/list <grey> - Otwiera kreator pisania listow.                                       |\n")
  cecho("|                                                                                |\n")
  cecho("|                                                                                |\n")
  cecho("| <yellow>PLUGINY:<grey>                                                                       |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/plugins - <grey> Pomoc dotyczaca pluginow.                                          |\n")
  cecho("|                                                                                |\n")
  cecho("+--------------------------------------------------------------------------------+\n")
end

function scripts:alias_print_help()
  cecho("+-------------------------- <green>Arkadia skrypty, ver " ..
    string.sub(scripts.ver .. "   ", 0, 5) .. "<grey> --------------------------+\n")
  cecho("|                                                                                |\n")
  cecho("| <yellow>KOLORY TYMCZASOWE:<grey>                                                             |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/tcolor [regex]<grey> - dodaje tymczasowy tekst, ktory bedzie kolorowany.            |\n")
  cecho("| Kolor, ktory bedzie uzyty to 'orange', mozna go zmienic w pliku konf.          |\n")
  cecho("| Regex to perl regex.                                                           |\n")
  cecho("|                                                                                |\n")
  cecho("| <yellow>BINDY TYMCZASOWE:<grey>                                                              |\n")
  cecho("|                                                                                |\n")
  cecho("| Te bindy sa resetowane przy kazdym restarcie klienta/przelogowaniu postaci.    |\n")
  cecho("| Sa aktualnie cztery bindy, ktore mozna zdefiniowac.                            |\n")
  cecho("| Aby zobaczyc aktualna konfiguracje tych bindow, <light_slate_blue>/bindy<grey>                         |\n")
  cecho("|                                                                                |\n")
  cecho(
    "| <light_slate_blue>/tbind[id] [bind_string]<grey> - ustawia binda <light_slate_blue>[id]<grey> na <light_slate_blue>[bind_string]<grey> na              |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/tbind<grey> - pokazuje aktualne tbindy                                              |\n")
  cecho("| <light_slate_blue>/tbind_reset<grey> - resetuje aktualne bindy                                         |\n")
  cecho("|                                                                                |\n")
  cecho("| <yellow>MULTIBINDY LOKACJI:<grey>                                                            |\n")
  cecho("|                                                                                |\n")
  cecho("| Daja mozliwosc do ustawienia do czterech bindo dla danej lokacji.              |\n")
  cecho("| Bindy sa lokalne dla profilu, nie sa powiazane z plikiem mapy.                 |\n")
  cecho("| Aby zobaczyc aktualna konfiguracje tych bindow, <light_slate_blue>/bindy<grey>                         |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/mbind+ [bind_string]<grey> - ustawia bind o kolejnym numerze dla aktualnej lokacji. |\n")
  cecho("| <light_slate_blue>/mbind [id] [bind_string]<grey> - ustawia bind numerze id dla aktualnej lokacji.     |\n")
  cecho("| <light_slate_blue>/mbind<grey> - wyswietla multbindy dla aktualnej lokacji.                            |\n")
  cecho("| <light_slate_blue>/mbind [id_lokacji]<grey> - wyswietla multbindy dla danej lokacji.                   |\n")
  cecho("| <light_slate_blue>/mbind-<grey> - usuwa wszystkie multbindy z aktualnej lokacji.                       |\n")
  cecho("| <light_slate_blue>/mbind- [id]<grey> - usuwa bind o numerze id z aktualnej lokacji.                    |\n")
  cecho("|                                                                                |\n")
  cecho("| <red>UWAGA (bindy tymczasowe i multbindy)<grey>:                                          |\n")
  cecho("| Komendy sa rozdzielone #, opoznienia sa rozdzielone *                          |\n")
  cecho("| Przykladowo: <light_slate_blue>/tbind- fuknij#westchnij#usmiech<grey>, nacisniecie wykona wszystkie    |\n")
  cecho("| trzy komendy naraz.                                                            |\n")
  cecho(
    "| <light_slate_blue>/tbind- fuknij#westchnij*0.7#usmiech*2<grey>, nacisniecie wykona <light_slate_blue>fuknij<grey>, nastepnie   |\n")
  cecho("| po 0.7 sekundy wykona <light_slate_blue>westchnij<grey>, nastepnie po 2 sekundach (od czasu            |\n")
  cecho("| wcisniecia komendy) wykona <light_slate_blue>usmiech<grey>.                                            |\n")
  cecho("| Opoznienia sa liczone wzgledem nacisniecia binda! Dlatego jesli uzywamy        |\n")
  cecho("| jakiejkolwiek wartosci w jednej z komend to wtedy kazda nastepna powinna miec  |\n")
  cecho("| takie samo lub wieksze opoznienie aby wykonala sie w odpowiedniej sekwencji.   |\n")
  cecho("|                                                                                |\n")
  cecho("|                      -------------------------------                           |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/bind_off<grey> - wylacza wszystkie keybindy.                                        |\n")
  cecho("| <light_slate_blue>/bind_on<grey> - wlacza wszystkie keybindy.                                          |\n")
  cecho("|                                                                                |\n")
  cecho("| Bindy wraz ze startem Mudleta sa automatycznie wlaczane.                       |\n")
  cecho("|                                                                                |\n")
  cecho("| <yellow>Dostepne ALIASY:<grey>                                                               |\n")
  cecho("|                                                                                |\n")
  cecho(
    "| <light_slate_blue>/szepnij [wiadomosc]<reset> szepniecie wiadomosci do calej druzyny.                   |\n")
  cecho("|                                                                                |\n")
  cecho(
    "| <light_slate_blue>/wyc <grey>lub <light_slate_blue>/wycinaj<grey> - wycinanie z cial.                                          |\n")
  cecho("| <light_slate_blue>/wyc [numer]<grey> - wyciecie wszystkie z ciala [numer]. (np '/wyc 2')               |\n")
  cecho("| <yellow>UWAGA: <grey>Jesli chcesz robic cos przed wycieciem i po (zmiana broni, jakiekolwiek |\n")
  cecho("| komendy) sprawdz ustawienia-skrypty, tam to mozna ustawic.                     |\n")
  cecho(
    "| <light_slate_blue>/med <grey>lub <light_slate_blue>/medytuj<grey> - medytowanie i ocena cech.                                  |\n")
  cecho("| <light_slate_blue>/ocenkamienie<grey> - podliczenie lacznej wartosci kamieni.                          |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/oceniaj<grey> - oceni wrogow twoich/druzyny i pokaze spis sprzetu.                  |\n")
  cecho("| <light_slate_blue>/oceniaj!<grey> - oceni wszystkich na lokacji oprocz ciebie/druzyny.                 |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/porownaj_ze_wszystkimi<grey> - porowna cie ze wszystkimi na lokacji i pokaze        |\n")
  cecho("| podsumowanie ze wszystkim z wyroznieniem na sile, zrecznosc i wytrzymalosc.    |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/sprzet<grey> - Oceni bronie/zbroje i pokaze kolektywny spis ze stanami.             |\n")
  cecho("| <light_slate_blue>/ubrania<grey> - Jak powyzej, ale dla ubran.                                         |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/napraw<grey> - Naprawianie sprzetu u kowala.                                        |\n")
  cecho("| <light_slate_blue>/napraw_ubrania<grey> - Naprawianie ubrania u krawca.                                |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/obecni<grey> - Sprawdzenie kogo z druzyny nie ma na lokacji.                        |\n")
  cecho("| <light_slate_blue>/ostatnio<grey> - Sprawdzenie czasu ostatniej aktywnosci czlonkow druzyny.           |\n")
  cecho("|                                                                                |\n")
  cecho("| <light_slate_blue>/hp [opis/imie]<grey> - Sprawdzenie ostatnio widzianej kondycji.                     |\n")
  cecho("|                                                                                |\n")
  cecho("| Sprawdz tez: <light_slate_blue>/walka, /ekwipunek, /ziola i /ui<grey>.                                 |\n")
  cecho("|                                                                                |\n")
  cecho("+--------------------------------------------------------------------------------+\n")
end

function scripts:print_start_message()
  scripts:print_log("Uzywasz Arkadia Skrypty, ver. " .. scripts.ver .. ". Pomoc dostepna w '/skrypty'")
  scripts.latest:is_latest(function(release_info)
    scripts:print_log_nobr("Dostepna jest nowa wersja (" .. release_info.tag_name .. "). Wpisz ")
    scripts:print_url("<CadetBlue>/aktualizuj_skrypty", "scripts.installer:update_scripts_to_latest_release()",
      "/aktualizuj_skrypty", true)
    cecho("<tomato> zeby zaktualizowac")
    cecho("\n<SlateGray>" .. release_info.body .. "\n\n<reset>")
  end)
end

tempTimer(13, [[ scripts:print_start_message() ]])
