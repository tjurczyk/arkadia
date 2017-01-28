## Arkadia Skrypty

Pomoc dostępna pod `/skrypty`
Wersja, której używasz: sprawdź nagłówek komendy `/skrypty`.

### INSTALACJA

**W celu poprawnego działania skryptów, w ustawieniach trzeba włączyć obsługę GMCP! Bez tego skrypty nie będą działać poprawnie.
Przed instalacją koniecznie włącz opcję _Enable GMCP_ w ustawieniach (Settings) Mudleta i zrestartuj go.

Instalacja skryptów to najzwyczajniej zainstalowanie pliku `skrypty_master.xml`.

1. W Mudlecie w górnym pasku wybieramy `Package Manager`
2. Wybieramy na dole `Install`
3. Z miejsca, gdzie rozpakowana została paczka wybieramy plik `skrypty_master.xml`
4. Restartujemy Mudleta.

Aktualizacja skryptów już po instalacji to: `/aktualizuj_skrypty`.

Od teraz, w `Triggers`, `Aliases`, `Scripts` oraz `Keys` (z górnego paska) mamy katalog `skrypty_master`. Tego folderu **nie wolno ruszać**. Z każdą aktualizacją, ten katalog jest usuwany i jest instalowany nowy, dlatego też jeśli chce się mieć jakieś własne triggery, aliasy, skrypty i key bindy to **koniecznie** trzeba to robić poza katalogiem `skrypty_master`. Na przykład na poniższym screenshocie widać, że mam dwa aliasy. Są one równoległe do skryptów, a nie w folderze _skrypty_master_.

![Własne aliasy](http://kamerdyner.net/~george/img/wlasne_aliasy.png)

Mając zainstalowane skrypty, można przystąpić do dodania swoich ustawień; ten punkt jest opcjonalny jeśli chcemy mieć możliwość modyfikowania ustawień typu:

- co znajduje się na dolnej belce;
- kolorowanie członków poszczególnych gildii;
- szerokość i długość okna z kondycjami;

i tym podobne.

#### Sugerowane kolory Arkadiowe (opcjonalnie)

Przygotowany został startowy zestaw kolorów do Arkadii, czyli tekstów, które Arkadia wysyła od razu pokolorowanych. Jest on przyzwoity i stonowany, dzięki czemu gra jest przyjemniesza. Wystarczy poniższe linie przekleić do Mudleta i wysłać do Arkadii:

```
kolor tekst 248
kolor pozostali 144

kolor cel ataku 218
kolor cel obrony 248
kolor druzyna 189
kolor przeciwnik 218
kolor wrogowie 248
kolor mowa 123
kolor krzyk 123
kolor szept 153
kolor opisy walki 239
kolor krotki opis noca 147
kolor krotki opis dniem 229
kolor opis wyjsc z lokacji 49
kolor emocje do mnie 225

kolor niskie zadane obrazenia 243
kolor srednie zadane obrazenia 243
kolor wysokie zadane obrazenia 243

kolor brak otrzymanych obrazen 243
kolor niskie otrzymane obrazenia 243
kolor srednie otrzymane obrazenia 243
kolor wysokie otrzymane obrazenia 139

kolor niski poziom stanu 208
kolor sredni poziom stanu 11
kolor wysoki poziom stanu 156
```

---

## USTAWIENIA

Skrypty mają swoje ustawienia, które można załadować za pomocą `/laduj imie`
Komenda `/laduj imie` ładuje plik o nazwie `imie.txt` z katalogu profilu Mudleta.

#### KATALOG PROFILU
Aby dowiedzieć się gdzie siedzi katalog profilu, należy w linii komend w Mudlecie wykonać komendę:

`lua getMudletHomeDir()`

Zobaczymy coś pokroju:

`/Users/nazwa_uzytkownika/.config/mudlet/profiles/Arkadia`

Z racji różnic Windows, Linux i OS X, profile są w innych miejscach
i trzeba sobie samemu sprawdzić gdzie dany profil się znajduje.

Aby zatem przygotować plik konfiguracyjny do jakiegoś imienia, wystarczy z paczki skopiować plik `imie.txt` do naszego katalogu profilu i zmienić mu nazwę na przykładowo `adremen.txt`.
W katalogu profilu możemy mieć oczywiście wiele takich plików (najsensowniej jeden plik na jedną postać).

Wpisywanie `/laduj imie` za każdym razem kiedy włącza się Mudleta lub loguje może być dość uciążliwe, dlatego proponuję zrobić prosty trigger, który będzie nam ładowal ustawienia naszej postaci na konkretny tekst, czyli na przykład: "Witaj, Adremenie. Podaj swe haslo".

Wchodzimy zatem w `Triggers` i robimy `Add Item`, następnie w polach wpisujemy (przykładowo dla mojej postaci *Adremen*)

- *name*: `Adremen` (tutaj można dać cokolwiek, to po prostu nazwa triggera)
- *0*: `Witaj, Adremenie. Podaj swe haslo`
- W tym dużym białym polu dodajemy:

`scripts_load_config("adremen")`


I taki alias sprawi, ze logując się i podając imię `adremen`, od razu zostanie załadowany plik `adremen.txt`. Zatem konfigurując to dla innych imion po prostu zamiast `adremen` użyc trzeba nazwy configu, który jest w waszym katalogu profilu. W `0` oczywiście daje się tekst, który widzi się po podaniu imienia przy logowaniu.

Tak to wygląda dla postaci `Adremen`.

![Konfiguracja triggera](http://kamerdyner.net/~george/img/trigger_config.png)

##### UWAGA: 
Czasami jest tak, że tekst wyglżda lekko _rozjechany_. To znaczy, można to poznać po tym, że widać, że odstępy między tekstem są większe niż normalnie, wtedy podczas zaznaczania tekstu, tekst 'zsuwa' się ze sobą i odstępy są normalne. Jest to błąd Mudletowy. Wystarczy wtedy chwycić za tekst i zaznaczając go przeciagnac na sam dół aby najechać na dolny pasek - wtedy tekst _dosunie się_ i będzie już równo. Po wykonaniu `/ui_restart`, trzeba zawsze takie coś wykonać.

---

## WALKA

Pomoc znajduje się pod `/walka` wraz z opisem kompletnego zestawu bindów oraz klikalnych akcji. Prawe górne okno to okno kondycji, gdzie drukowani są wszyscy na lokacji, jeden wiersz na jedną osobę. Pierwszy wiersz to Ty, kolejni to (jeśli jesteś w) drużyna, kolejni to wrogowie i na końcu neutralni. Kolorowanie dość intuicyjne: zieloni to Twoi, fioletowi to wrogowie Twoi/drużyny, czerwony to aktualnie bity przez Ciebie, biali to neutralni. Czerwony znacznik `>>` przy osobie wskazuje, że ta osoba to cel ataku, zielony znacznik `>>` to cel obrony.

Opis wiersza wroga:

`[ 1][#######] Postac Z -> [@,A,B]`

Najpierw jest ID postaci używane w bindach (patrz `/walka`), później pasek życia, później imię/short, później identyfikatory postaci z drużyny, które biją tę postać (drużynowi są oznaczani `A`, `B`, `C`..., `@` to JA). 

Wiersz członków drużyny wygląda tak:

`[ C][#######] Postac Y -> [2,3,4]`

Tutaj inne znaczenie ma jedynie ostatni kawałek - oznacza to, że naszego kolegę/koleżankę z drużyny biją wrogowie o ID `2`, `3` i `4`.

W oknie kondycji (prawy górny róg) numerowani (pierwsza kolumna) są domyślnie tylko aktualni przeciwnicy. Czyli, praktycznie wszystkie bindy ataku typu `/z 2` itp. będą działały tylko na wrogach, z którymi aktualnie już walczymy. Można to zmienić, aby numerować wszystkich (ale wtedy należy uwazać, bo bindy + klikalne akcje na oknie działają na wszystkich). Aby zmienić to należy użyć opcji `/numeruj` w kliencie. Aby zmienić domyślne ustawienie wraz ze startem Mudleta, w pliku ustawień trzeba zmienić opcję `ateam.all_numbering`

---

## EKWIPUNEK

Pomoc znajduje się w '/ekwipunek'. W skryptach jest wsparcie lampy - liczenie butelek, przypominanie o dopełnieniu lampy (z bindem). Są też manualne bindy '/zb' i '/zb!'

---

## ZIOLA

Pomoc znajduje się w `/ziola`
Skrypt potrafi wydrukować wypis co jest w woreczku po `zajrzeniu do niego`. Potrafi też zbudować bazę ziół - rozpozna co jest w którym woreczku i będą działały bindy do brania ziół z odpowiednich woreczków (skrypt będzie 
więdział w których jest ile którego zioła).
Jest również komenda do pakowania ziół: 

`/zapakuj [numer_woreczka] [ziolo]`

Czyli przykładowo, mając przy pasie/w ręce 7 woreczków, budujemy sobie bazę. 
Skrypt rozpozna wszystkie zioła w woreczkach (puste będzie widział jako puste). Załóżmy, że mamy zioła w woreczkach `1`, `3`, `4`, `6`, `7` i chcemy zapakować komuś cały woreczek delion. Możemy wykonać:

`/zapakuj 2 deliona`

_drugi_ woreczek jest pusty. 

#### UWAGA
Po każdej zmianie liczebników woreczków (przykładowo po wzieciu któregoś z plecaka/kupieniu jakiegoś/odłożeniu któregoś) skrypt ma w bazie nieprawidłowe przypisania liczebników woreczków (pierwszy, drugi...) do ziół. Dlatego, przy 
każdej takiej zmianie trzeba po prostu uruchomić `/ziola_buduj` - wtedy skrypt pozbiera i zbuduje mapę ziół na nowo.

Skrypt wspiera sytuacje, kiedy mamy przykladowo 10 woreczków, ale tylko 6 z nich przy sobie, czyli przy pasie/w rece (reszta w plecaku), baze zbuduje tylko z tych 6.

Przy ziołach są dwa ważne ustawienia w pliku z ustawieniami. Pierwsza to:

`herbs["many_to_int"] = 25`

skrypt widząc _wiele zoltych jasnych kwiatow_ w woreczku musi przypisać temu _wiele_ jakąś liczbę. Ustawiam tutaj domyślną liczbę 25, ale można ją dowolnie zmienić (czyli trzeba sprawdzić ile postać widzi w liczebniku, a od jakiej 
ilości zaczyna się _wiele_). Druga opcja to:

`herbs["full_bag_amount"] = 44`

sluży to do pakowania woreczków. Definicja ile to oznacza pełny woreczek, czyli ile ziół zapakuje podczas komendy `/zapakuj`.

---

## UI

Pomoc znajduje się w `/ui`.
UI to dolna belka oraz okno stanów (prawy górny róg). Należy przejrzeć `/ui`, jest tam wszystko wyjaśnione.

Poza tym, w pliku z ustawieniami można sobie zdefiniować co ma być gagowane (dodawane [tagi]), co usuwane, a co zostawione tak jak przychodzi z Arkadii.

---

## BINDY

Pomoc znajduje się w `/bindy`. Kilka przydatnych bindów do wycinania, medytacji, masowej oceny kamieni (czyli 
zsumuje wartosc wszystkich), kowala itp.

---

## BRONIE

Pomoc znajduje się w `/bronie`. Można sobie ustawić do trzech pojemników na bronie (lub na tarczę, będzie to pojemnik _other_ albo plecy (opcja gz...)). Ustawienia wszystkich pojemników wraz ze szczegółami jak to zrobić jest w pliku konfiguracyjnym txt.

---

## STATYSTYKI

Są dostępne statystyki parowań, otrzymamych ciosów itp., Statystyki dostępne w `/stat`.

---

## LICZNIKI

Liczniki postępów:

`/postepy` - pokazuje postępy (czas, wrogowie itp),

`/postepy_reset` - resetuje licznik postępów.

`/postepy2` - globalny licznik postępów od ostatniego resetu,

`/postepy2+` - dodaje jeden postep do globalnego licznika,

`/postepy2+ [ile]` - dodaje [ile] postepow do globalnego licznika. Przykładowo: `/postepy2+ 4` doda 4 postepy. **Musi to byc liczba mniejsza badz rowna 15!**,

`/postepy2- [id]` - usuwa wpis z globalnego licznika o tym _id_. _id_ można znaleźć jako pierwsza kolumna od lewej w `/postepy2`,

`/postepy2_reset` - resetuje globalny licznik postepow. 

<br>
Licznik poziomów

`/licz_poziom`

---

## ZBIERANIE Z CIAL

Pomoc dostępna w `/zbieranie`

Domyślnie ustawiona jest opcja, która sprawia, że będzie drukowane powiadomienie kiedy kogoś zabijemy i żeby użyc binda w celu zebrania monet + kamieni. Aby zmienić to należy użyć opcji `/zbieranie [numer_opcji]` w Mudlecie. Aby zmienić domyślne ustawienie wraz ze startem Mudleta, w pliku ustawień trzeba zmienić opcję: 

`scripts.inv.collect.current_mode = 3`

Dolny pasek zawiera też element `Collect`, który można klikać i zmieniać opcje.

---

## STATKI/DYLIZANSE

Działają wszystkie statki. Przy wejściu będzie bind będzie brał pieniądze z pojemnika `money`, kupował bilet, wsiadał na statek oraz wkładał monety do pojemnika `money`; przy dopłynięciu zbindowane będzie zejście.
Dyliżanse w Imperium działają, wozy/powozy w Ishtar nie wszystkie.

Bindowany jest klawisz `[`.

---

## POJEMNIKI

Jest wsparcie do pojemników. W ustawieniach są:

```
-- Domyslna pojemniki do monet (money), kamieni (stones), jedzenia (food),
-- i wszystkiego innego (other)
--
-- Dozwolone wartosci:
-- - 1 (to jest "plecak")
-- - 2 (to jest "torba")
-- - 3 (to jest "worek")
-- - 4 (to jest "sakiewka")
-- - 5 (to jest "mieszek")
-- - 6 (to jest "sakwa")
-- - 7 (to jest "wor")
scripts.inv["money_bag"] = 1
scripts.inv["stones_bag"] = 1
scripts.inv["food_bag"] = 1
scripts.inv["other_bag"] = 1
```

jak na razie dostępne bindy to `wem`/`/wlm` (branie/wkładanie monet) oraz `wep`/`wlp` (branie/wkładanie paczki).

---

## BAZA

W skryptach znajduje się wsparcie bazy postaci. W katalogu profilu jest plik: Database_scripts.db
Ten plik zawiera baze.

Wszystkie komendy i pomoc jest opisana pod `/baza`.
Bazę można pobrać korzystając z komendy `/pobierz_baze`.

Baza jest budowana następująco:

- jest możliwość zapisywania/aktualizowania wszystkich osób przedstawiających się na Arkadii. Domyślnie jest to wyłączone, aby włączyć trzeba sobie ustawić `scripts.people["updating_names"] = true` w ustawieniach;
- zapisywane jest `id` lokacji, na której dana osoba się przedstawiła;
- do NPCów na poczcie jest GPS: po 'obejrzyj tablice' na zielono podświetlą nam się na zielono osoby z paczkami, których lokacje są w bazie. Po wzięciu takiej paczki można ją obejrzeć i pojawi się informacja o `/idzdo`, która uruchomi chodzik do tej osoby. Jest też możliwy kolor pomarańczowy. Znaczy to, ze w bazie jest więcej niż jedna postać pasujaca. Można zrobić `/przeszukaj [imie]` i `/idzdo [id]`, gdzie `[id]` to będzie faktyczne `id` postaci, do której chcemy iść;
- wraz ze startem Mudleta, ładowane są triggery pokazujące imiona wszystkich graczy zgildiowanych (za wyjątkiem GP). NPC + osoby GP pojawią się gdy zostaną zobaczone w grze, wtedy jest ładowany ich trigger z bazy danych.

---

## KONTAKT

1. Na IRCNet: Kanał \#arkadia, nick @dzordzyk
2. Na forum: [@Adremen](http://arkadia.rpg.pl/forum/memberlist.php?mode=viewprofile&u=1084)
3. [Temat](http://arkadia.rpg.pl/forum/viewtopic.php?f=15&t=752), w którym można uzyskać pomoc na forum
