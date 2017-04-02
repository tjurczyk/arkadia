## Arkadia Mapper

Pomoc dostępna pod komendą: '/mapper'
Wersja, której używasz: sprawdź nagłówek komendy `/skrypty`.

### INSTALACJA

**W celu poprawnego działania skryptów, w ustawieniach trzeba włączyć obsługę GMCP! Bez tego skrypty nie będą działać poprawnie. Przed instalacją koniecznie włącz opcję _Enable GMCP_ w _Settings_ Mudleta i zrestartuj go.**

Po instalacji skryptów (patrz [README skryptów](arkadia.kamerdyner.net/master/README.md)) Mapper jest już zainstalowany, 

Potrzebne jest jedynie kilka kroków do poprawnej konfiguracji:

1. Pobranie mapy startowej: `/pobierz_mape`;
2. Konfiguracja key bindów do chodzenia, aby przemieszczały mapper (opisane w następnym podpunkcie).

Po wykonaniu tego polecenia najlepiej zrestartować Mudleta. Od tego
momentu mapa będzie ładowana automatycznie z każdym startem klienta.

Mapa jest umieszczona w katalogu profilu.
Ścieżkę, gdzie jest katalog profilu można sprawdzić w Mudlecie wpisując tę komendę: 

`lua getMudletHomeDir()`

Polecenie `/pobierz_mape` zawsze ściągnie najnowszą mapę z serwera.

Jeśli zrobi się jakieś zmiany to mapę można zapisać poleceniem `/zapisz_mape`. Analogicznie, jest też `/zaladuj_mape` kiedy na przykład ktoś wyślę nam inną mapę i chcemy ją załadować w Mudlecie. Przed wykonaniem komendy załadowania, plik `map_master.dat` należy umieścić najpierw w katalogu profilu.


## Key bindy

Jeśli używa się jakichkolwiek kombinacji klawiatorowych do chodzenia (czy to numeryczna czy to jakieś ALT+[klawisz] i tym podobne) to potrzebna jest drobna konfiguracja, gdyż Mapper korzysta z informacji jaki kierunek został wysłany. Tę procedurę wykonuje się tylko raz przy pierwszej instalacji skryptów.

Klikamy w `Keys` umieszczony na górnym pasku Mudleta, będzie to wyglądało tak:

![Konfiguracja triggera](http://kamerdyner.net/~george/img/keybindy.png)

Klikamy `Add Item` na górnym pasku. **UWAGA**: key binda trzeba utworzyć w głównym katalogu. To znaczy, nie tworzy się go w katalogu `skrypty_master`, bo wtedy przy aktualizacji skryptów key bindy te zostaną usunięte.
Po kliknięciu `Add Item` uzupełniamy następujące pola:

  * _Name_: `zachod` (dowolna nazwa binda)
  * _Command_: zostaw puste
  * _Key Binding_: _jakakolwiek\_kombinacja\_klawiszy_. Czyli może to być klawisz na numeryku, wasza kombinacja, cokolwiek co będzie wysyłało `w` do Arkadii. Przechwytuje się kombinację za pomocą przycisku "Grab New Key")
  * _ponizsze biale pole_: tutaj **MUSI** być to co ja mam, czyli: 

`amap:keybind_pressed("west")`

Po wpisaniu tego wszystkiego, *ważnym jest aby* kliknąć `Save Item` w lewym górnym rogu oraz `Activate` - przy nazwie key binda, musi znajdować się _zielony ptaszek_, oznacza to, że key bind jest aktywny, czyli włączony.

Całość działa tak, że podczas naciśnięcia tego key binda, funkcja `amap:keybind_pressed("west")` będzie wywołana (nazwy angielskie są **KONIECZNE!**) i wyśle ona kierunek `w` do Arkadii. Tak wygląda cały key bind `zachod` u mnie:

![Konfiguracja triggera](http://kamerdyner.net/~george/img/keybind_zachod.png)

Teraz analogicznie trzeba stworzyć key bindy dla wszystkich pozostałych kierunków. Zatem, w key bindzie odpowiedzialnym za `wschod`, białe dolne pole będzie zawierało:

`amap:keybind_pressed("east")`

itp.

Poniżej lista tłumaczeń kierunków.

* północ -> `north`
* południe -> `south`
* zachód -> `west`
* wschód -> `east`
* północny-zachód -> `northwest`
* północny-wschód -> `northeast`
* południowy-zachód -> `southwest`
* południowy-wschód -> `southeast`
* dół -> `down`
* góra -> `up`

Po dodaniu wszystkich key bindów i ustawieniu pól kodu z odpowiednimi `amap:keybind_pressed("[kierunek]")`, Mapper będzie działał poprawnie kiedy będziecie używali tych key bindów.

Można sobie też dodać jakiś klawisz, który będzie wysyłał wyjście specjalne widoczne w róży wiatrów. Wystarczy zrobić sobie key bind na jakikolwiek klawisz oraz w polu kodu dać sobie:

`compass_click("special1")`

![Konfiguracja triggera](http://kamerdyner.net/~george/img/keybind_special.png)

Analogicznie można zrobić key bindy do 2 oraz 3 przejścia specjalnego z róży wiatrów robiąc key bindy z takimi wywołaniami

`compass_click("special2")`

albo

`compass_click("special3")`

---

## TRYBY MAPPERA

Mapper wspiera trzy tryby, ustawia się je za pomocą `/mm [nazwa_trybu]`

- _draw_ - rysowanie. Dużo opcji, wszystkie są opisane w `/mapper_rys`. Rysowanie po kierunkach odbywa się ze standardowym skokiem 2 (`/mapper_opcje`).
- _follow_ - mapper będzie śledził chodzenie manualne i drużynę.
- _off_ - śledzenie i podążanie za drużyną wyłączone.

---

## RYSOWANIE

Mapper dostarcze wiele opcji rysowania: przejścia normalne, specjalne, różne poziomy, notki, bindy, nazwy, opisy itp. Obowiązkowo do zapoznania się: `/mapper_rys`, `/mapper_opcje`.


---

## CHODZIK

Pomoc w `/mapper`. Chodzik można uruchomić na trzy sposoby:

- dwa razy klikając na lokacji, do której chce się iść (nie działa w opcji rysowania);
- użyć `/idz [nazwa skrotu]` - o definiowanych skrótach poniżej;
- użyć `/idz [id lokacji]` - `id_lokacji` można znać np. z wyszukiwarki. Będzie o tym poniżej - można wyszukiwać sobie lokacje poprzez `/przeszukaj_mape` i `/przeszukaj_mape!`).

Chodzik jest przerywany natychmiastowo gdy naciśnie się jakiegoś key binda lub cokolwiek na róży wiatrów.

---

## SKRÓTY

`/mapper_skroty`. Można sobie zdefiniować skrót do poszczególnej lokacji (jej numeru) i ich używać, np.: `/idz wyzima_poczta`

---

## BINDY

Można sobie bindować na lokacjach jakieś akcje, które są dostępne wtedy pod `CTRL+p`. Z `/mapper_db`:

`/lok_bind [bind_tekst]` ustawi binda do aktualnej lokacji.                   

##### UWAGA
Komendy są rozdzielone `#`, opóźnienia są rozdzielone `*`.
Przykładowo: `/lok_bind fuknij#westchnij#usmiech` wykona wszystkie trzy komendy na raz.

`/lok_bind fuknij#westchnij*0.7#usmiech*2` wykona najpierw `fuknij`, następnie po 0.7 sekundy wykona `westchnij`, następnie po 2 sekundach (od czasu wciśnięcia komendy) wykona `usmiech`.
**Opóźnienia są liczone względem naciśnięcia komendy.**
Dlatego jeśli używamy jakiejkolwiek wartości w jednej z komend to wtedy każda następna powinna mieć takie samo lub większe opóźnienie aby wykonała się w odpowiedniej sekwencji.

Domyślnie bindy są pokazywane po wejściu na lokację, można to wyłączyć w ustawieniach albo korzystając z `/pokazuj_bindy`.

---

## BAZA

Cała pomoc dostępna w `/mapper_db`.


### Nazwy i Opisy

Mapper posiada wsparcie do zapisywania nazw i opisów lokacji. Nazwa to najczęściej krótka nazwa jednoznacznie określająca lokację (np `Kuznia w Novigradzie`). Opis lokacji to tak naprawdę dobrowolność. Moją intencją przy tworzeniu opisów nie było do długich opisów lokacji, a do utrzymywania np. spisów co można kupić na danej lokacji. Weźmy na przykład _Targ w Gelibolu_, _stoisko z warzywami_. Tak to wygląda w mapie startowej:

_Tytul lokacji_: `Targ w Gelibolu, Stragan z Warzywami`
_Opis lokacji_:

~~~~
+------------------------------------------------+----+----+----+----+-------+
| Nazwa towaru                                   | mt | zl | sr | md | Ilosc |
+------------------------------------------------+----+----+----+----+-------+
| zielone jablko                                 |  0 |  0 |  2 |  9 |   *** |
| suszona sliwka                                 |  0 |  0 |  7 |  7 |   *** |
| fioletowa sliwka                               |  0 |  0 |  4 |  6 |   *** |
| zoltawa gruszka                                |  0 |  0 |  5 |  7 |   *** |
| pachnaca dojrzala truskawka                    |  0 |  0 |  8 | 11 |   *** |
| slodka czeresnia                               |  0 |  0 |  1 | 10 |   *** |
| kisc zielonkawych winogron                     |  0 |  1 | 13 |  5 |   *** |
+------------------------------------------------+----+----+----+----+-------+
~~~~

Czyli jako `opisu` lokacji użylem 'przejrzyj' z tej lokacji.

To wszystko jest po to, aby móc wyszukiwać lokacje. Są dwie komendy do wyszukiwania: `/przeszukaj_mape [tekst]` oraz `/przeszukaj_mape! [tekst]`

`/przeszukaj_mape!` (wersja z !) różni się jedynie tym, że wypisze wszystkie numery i nazwy lokacji, które zostały znalezione. Wersja bez wykrzyknika wypisze tylko 5 lokacji.
Lokacje są wypisywane w kolejności od najbliższej w odległości od tej na której aktualnie się znajduje Mapper. Czyli na przykład przeszukując:

`/przeszukaj_mape kuznia`

stojąc gdzieś w Novigradzie, uzyska się prawdopodobnie coś takiego:

~~~~
(mapper): Znalazlem 9 lokacji, najblizszych 5:
5495     | Kuznia w Novigradzie                    
5411     | Kuznia w Podgrodziu (Oxenfurt)                          
6037     | Kuznia w Rinde                        
5199     | Kuznia w Wyzimie                         
7272     | Kuznia w Mariborze     
~~~~

Pierwsza kolumna to numer lokacji, druga kolumna to nazwa lokacji. Można teraz użyc `/idz 5495` i wystartuje się z aliasem podążającym do tej lokacji.

Całość oczywiście bazuje na tym, że kuźnie będą nazywane w taki sposób, dlatego warto trzymać sobie jakąś swoją stałą nomenklaturę.

Przeszukiwanie działa zarówno po nazwach jak i po opisach. Czyli na przyklad bazując na pierwszym przykładzie targu, jeśli teraz zrobię coś typu:

`/przeszukaj_mape sliwka`

to dostanę:

~~~~
4489     | Targ w Gelibolu, Stragan z owocami    
~~~~

Aby zobaczyć wszystkie dane lokacji: `/lok 4489`, wtedy zobaczymy coś takiego:

~~~~
(mapper): ID lokacji: 4489
(mapper): Rejon lokacji: Polnocna Redania
(mapper): Koordynaty lokacji: 178, 6, 0
(mapper): Waga lokacji: 1
(mapper): Wyjscia z lokacji: 
{}
(mapper): Wyjscia specjalne z lokacji: 
{
  targ = 4478
}
(mapper): Nazwa lokacji: Targ w Gelibolu, Stragan z owocami
(mapper): Opis lokacji:
+------------------------------------------------+----+----+----+----+-------+
| Nazwa towaru                                   | mt | zl | sr | md | Ilosc |
+------------------------------------------------+----+----+----+----+-------+
| zielone jablko                                 |  0 |  0 |  2 |  9 |   *** |
| suszona sliwka                                 |  0 |  0 |  7 |  7 |   *** |
| fioletowa sliwka                               |  0 |  0 |  4 |  6 |   *** |
| zoltawa gruszka                                |  0 |  0 |  5 |  7 |   *** |
| pachnaca dojrzala truskawka                    |  0 |  0 |  8 | 11 |   *** |
| slodka czeresnia                               |  0 |  0 |  1 | 10 |   *** |
| kisc zielonkawych winogron                     |  0 |  1 | 13 |  5 |   *** |
+------------------------------------------------+----+----+----+----+-------+
~~~~

##### UWAGA
Kiedy dodajemy opis do lokacji który ma więcej niż jedną linię (np. jak ten stragan w Gelibolu), potrzebna jest drobna modyfikacja. Niestety, nie można tego przekleić w takiej formie jak jest drukowane (Mudlet po zobaczeniu końca pierwszej linii weźmie tylko to, wszystkie pozostałe linie wyśle jako komendy do MUDa, a tego nie chcemy). Najprościej można zrobić to tak: skopiować cały ten opis do jakiegoś edytora tekstowego i każdy znak nowej linii zastąpić znakiem `\n`. Wtedy taki **jednolinijkowy** tekst dać w argumencie do komendy do ustawiania opisu. Czyli, stojąc na tej lokacji z warzywami, aby ustawić taki opis jak powyżej trzeba użyć:

~~~~
/lok_opis +------------------------------------------------+----+----+----+----+-------+\n| Nazwa towaru                                   | mt | zl | sr | md | Ilosc |\n+------------------------------------------------+----+----+----+----+-------+\n| zielone jablko                                 |  0 |  0 |  2 |  9 |   *** |\n| suszona sliwka                                 |  0 |  0 |  7 |  7 |   *** |\n| fioletowa sliwka                               |  0 |  0 |  4 |  6 |   *** |\n| zoltawa gruszka                                |  0 |  0 |  5 |  7 |   *** |\n| pachnaca dojrzala truskawka                    |  0 |  0 |  8 | 11 |   *** |\n| slodka czeresnia                               |  0 |  0 |  1 | 10 |   *** |\n| kisc zielonkawych winogron                     |  0 |  1 | 13 |  5 |   *** |\n+------------------------------------------------+----+----+----+----+-------+
~~~~

**Ten długi opis (linia po linii) to jedna linijka tutaj.** Symbole `\n` są w miejscu nowych linii. Teraz zadziała to tak, że gdy będziemy drukowali szczegóły lokacji to wszystkie `\n` zostaną zinterpretowane jako nowe linie, więc wydrukowane zostanie ładnie równy tekst (tak jak powyżej)

Przeszukiwanie działa bez względu na wielkość liter (mając nazwy kuźni jako `Kuznia`, wyszukiwanie zadziała zarówno po `kuznia` jak i `Kuznia`).

### Notki

Notki to proste notatki przypominające o czymś. Domyślnie, jeśli wejdzie się na lokację, na której ma się zdefiniowaną notke to ona się pokaże. Aby to wyłączyć trzeba użyć `/pokazuj_notki`. Ustawienie domyślne można też zmienić korzystąjac z ustawień.

Przeszukiwanie lokacji nie dziala po notkach.

---

## KONTAKT

1. Na IRCNet: Kanał \#arkadia, nick @dzordzyk
2. Na forum: [@Adremen](http://arkadia.rpg.pl/forum/memberlist.php?mode=viewprofile&u=1084)
3. [Temat](http://arkadia.rpg.pl/forum/viewtopic.php?f=15&t=752), w którym można uzyskać pomoc na forum
