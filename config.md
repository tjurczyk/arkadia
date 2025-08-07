## `scripts.character_name`

Tutaj ustaw Twoje imie (miedzy innymi do globalnego licznika postepow i zabitych)

---

## `scripts.config_watch.enabled`

Flaga okreslajaca czy automatyczne przeladowywanie configu na zmiany w pliku ma byc wlaczone.

Dozwolone wartosci
* `true`  - zmiany beda automatycznie przeladowywane
* `false` - zmiany nie beda automatycznie przeladowywane

---

## `ateam.all_numbering`
Domyslna opcja czy maja byc numerowani neutralni osobnicy na lokacji

Dozwolone wartosci
* `true`  - beda numerowani wszyscy osobnicy
* `false` - beda numerowani tylko aktualni wrogowie

Komenda do zmiany w trakcie gry: `/numeruj`

---

## `ateam.options.team_numbering_mode`

Opcja decydujaca jak oznaczac czlonkow swojej druzyny w pasku stanow.

Dozwolone wartosci
* `mode1`  - czlonkowie druzyny beda numerowanie literami: A, B, C...
* `mode2`  - czlonkowie druzyny beda numerowanie liczbami: 1, 2, 3...

---

## `ateam.options.alphabetical_sort_team`

Sortowanie alfabetyczne druzyny w oknie kondycji.
* `true` - włączone
* `false` - wyłączone

---

## `ateam.options.own_name`

Określa jaka nazwa będzie wyświetlana obok naszej kondycji w oknie kondycji.
Domyślnie `JA`

---

## `ateam.options.broken_defense_bg_color`
## `ateam.options.broken_defense_fg_color`

Kolor oznaczenia na przelamana obrone.  'fg' to czcionka, 'bg' to tlo.

Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---


## `ateam.options.team_mate_stun_bg_color`
## `ateam.options.team_mate_stun_fg_color`

Opcja definiujaca kolory ogluszonych czlonkow druzyny. 'fg' to czcionka, 'bg' to tlo.

Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `ateam.options.enemy_stun_bg_color`
## `ateam.options.enemy_stun_fg_color`

Opcja definiujaca kolory ogluszonych wrogow. 'fg' to czcionka, 'bg' to tlo.

Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `ateam.options.countdown`

Opcja zmieniająca sposób odliczania w zaslonie/rozkazie
* `false` - wyłączone. Czas jest liczony od wydarzenia.
* `true` - włączone. Czas jest odliczany.

---

## `ateam.attack_mode`

Domyslna opcja do /z oraz /zz

Dozwolone wartosci:
* `1` - tylko atak `zabij`
* `2` - tylko atak + wskazanie (`zabij` + `wskaz ... jako cel ataku`)
* `3` - komplet ('zabij', 'wskaz', 'rozkaz wszystkim zaatakowac ...')

---

## `ateam.attack_commands`

Ustawianie ataku do bindow zamiast zwyklego 'zabij'
Przykladowo: ateam.attack_commands = {"chzabij"}
Jesli bedzie to wiecej niz jedna komenda (np: {"gpokrzyk", "chzabij"}),
wtedy ostatni element musi byc elementem, ktory pobiera argument kogo zabic.

---

## `ateam.support_command`
Ustawienie komendy do wspierania, domyslnie jest `wesprzyj`

--- 

## `ateam.release_guards`
Ustawianie puszczania zaslon\
W mudlecie do zmiany sluzy komenda `/puszczaj_zaslony`

Dozwolone wartosci:
* true - beda puszczane
* false - nie beda puszczane

---

## `ateam.sneaky_attack`

Ustawienie zaskakiwania w oknie stanow.\
Dozwolne wartosci: 
* `0` - brak opcji zaskakiwania
* `1` - jesli wybierze sie 1 to wiersz bedzie wygladal mniej wiecej:
```
[ 1][xx][#######] ...
```
po kliknieciu na [xx], postac zaskoczy 'xx'\
Wiersz bedzie sie tylko pokazywal wtedy, kiedy postac moze zaskoczyc (warunek to czas od ukrycia, konfigurowalny ponizej)

* `2` - to czesc wiersza [xx] bedzie zawsze pokazywana.

---

## `ateam.sneaky_attack_cond`

Ustawienie jak dlugo (czas sekund badz "ok") ma minac od ukrycia sie, aby pokazala sie czesc wiersza [xx].
Ta wartosc jest uzywana gdy w 'ateam.sneaky_attack' wybierze sie 1.

Dozwolone wartosci sa od `0` do `14` lub `ok`.

---

## `scripts.character.break_fatigue_level`

Ustawienie do przelamania. Jakie wypoczecie (przynajmniej) musi byc, aby lamac przy /prze (w przeciwnym razie nie zostanie wykonane).
Warunek ten mozna ominac korzystajac z `/prze!` oraz `/prze! [id]`, wtedy przelamanie zostanie wykonane bez wzgledu na zmeczenie

Wartości: 
* `9` (domyslne) - przelamanie wystapi zawsze
* `8` - przelamanie wystapi jesli jest sie "wycienczonym" i nizej
* `7` - przelamanie wystapi jesli jest sie "bardzo wyczerpanym" i nizej
* itp. az do 0 (tylko przy w pelni wypoczetym)

---

## `scripts.character.bind_hp_level`

Bindowanie dwukrotnego `alt +` do uzycia `+k`.
Podana wartosc jest wartoscia, przy ktorej pokazana zostanie informacja o tym bindzie i dwukrotne wcisniecie jego zadziala.

Wartości:
* `-1`  - wylaczone dzialanie tego binda
*  `0`  - bind wyskoczy, gdy bedzie sie ledwo zywym
*  `1`  - (domyslne) bind wyskoczy, gdy bedzie sie ciezko rannym
* itd..

---

## `scripts.character.combat_state.trigger_blocked_actions_bind`

Bindowanie nieudanej akcji ze wzgledu na niedawne zakonczenie walki.
Ochlon troche po walce!

Dozwolone wartosci:
 * `true`
 * `false`

---

## `ateam.special_follow_bind_mode`

Ustawienie jak maja dzialac bindowania przejsc specjalnych

Wartości:

* `0` - nie bedzie w ogole bindowalo przejsc specjalnych na podstawie widzianych tekstow
* `1` - bedzie bindowalo przejscie tylko na podstawie osoby prowadzacej
* `2` - bedzie bindowalo na podstawie kogokolwiek

---

## `ateam.special_follow_bind_beep`

Odtwarzanie beepa dla bindowanych przejsc specjalnych.
Bindowanie przejsc musi byc ustawione 'tylko na podstawie osoby prowadzacej'.

Wartości:

* `false` - wylaczone
* `true` - wlaczone

---

## `misc.attack_beep.mode`

Startowa opcja odglosu ataku na postac.

Dodatkowo, mozliwe opcje:
* `0` - zadne ataki nie sa beepowane
* `1` - beepowane beda ataki tylko ludzi, ktorych mamy na liscie wrogow.
* `2` - beepowane sa ataki od kogokolwiek

---

## `scripts.inv.collect.current_mode`

Domyslna opcja zbierania z ciał.

Dozwolone wartosci:

* `1` - monety
* `2` - kamienie
* `3` - monety i kamienie
* `4` - druzynowe monety
* `5` - druzynowe kamienie
* `6` - druzynowe monety i kamienie
* `7` - nic

Uzyj komendy `/zbieranie` aby zobaczyc wszystkie dozwolone wartosci

Komenda do zmiany w trakcie gry: `/zbieranie [wartosc_ustawienia]`

---

## `scripts.inv.collect.money_type`

Opcja zbierania poszczegolnych monet

Dozwolone wartosci:
* `1` - wszystko
* `2` - srebro i zloto
* `3` - zloto

Komenda do zmiany w trakcie gry: `/zbieranie_monet [wartosc_ustawienia]`

---

## `scripts.inv.containers.disable_grouped_containers`

Wyłączenie grupowania przedmiotów w pojemnikach.
* `true` - wyłączone
* `false` - włączone

---

## `scripts.inv.containers.preferred_magic_types`

Oznacza w grupowanych pojemnikach preferowane typy magików.

```json
  "script.inv.containers.preferred_magic_types" : ["jednoreczny topor", "jednoreczna maczuga", "tarcza"]
```

W razie wątpliwości co do typów, należy przeszukać `type` w tym [pliku](https://github.com/tjurczyk/arkadia-data/blob/master/magics_data.json)

---

## `scripts.inv.containers.preferred_magics`

Oznacza w grupowanych pojemnikach konkretne magiki.

```json
  "scripts.inv.containers.preferred_magics" : ["lsniacy krysztalowy wisior", "misterny obosieczny topor"]
```

---

## `scripts.inv.containers.column_count`

Ilość kolumn w grupowanych pojemnikach.

---

## `herbs.many_to_int`

Domyslna opcja do ZIOL (ile to jest 'wiele' w woreczku)

Dozwolone wartosci: *jakakolwiek liczba*

---

## `herbs.full_bag_amount`

Domyslna opcja do ZIOL (podczas pakowania, ile zapakowac ziol do woreczka)

Dozwolone wartosci: *jakakolwiek liczba*

---

## `herbs.use_herb_triggers`

Czy uzywac triggerow dodawajacych nazwy ziol
```
zolty jasny kwiat -> zolty jasny kwiat (deliona)
```

---

## `herbs.pre_actions`
## `herbs.post_actions`

Opcja do ustalania akcji "przed" i "po"

`pre_` to przed, `post_` to po.

---

## `herbs.pre_use`
## `herbs.post_use`

Opcja do ustalania akcji "przed" i "po" uzyciu ziola

`pre_` to przed, `post_` to po.

---

## `herbs.settings.get_herb_counts`
## `herbs.settings.use_herb_counts`

Opcja do ustalenia jakie maja byc bindowane ilosci ziol branych (get) oraz zazywanych (use) w klikalnych bindach.

### Przykład
```json
"herbs.settings.get_herb_counts" : [1, 3],
"herbs.settings.use_herb_counts" : [1, 3]
```

---

## `herbs.smart_application_skip_kon`
## `herbs.smart_application_skip_man`
## `herbs.smart_application_skip_zme`

Opcja do ustalania ktore ziola maja byc ignorowane w kolejkowym braniu ziol

### Przykład
```json
"herbs.smart_application_skip_zme" : {"deliona": true}
deliona bedzie ignorowana w kolejkowaniu
```

---


## `herbs.window.enabled`
Włącza oddzielne okno pokazujące zioła. Aktualizowany przez `/pokaz_ziola` oraz aliasy na wkladanie i wyciąganie ziół.

---

## `herbs.window.font_size`
Ustawia wielkość czcionki w oknie ziół.

---

## `scripts.misc.knowledge.use_knowledge`

Opcja dla wlaczenia badz wylaczenia ulatwienia czytania ksiazek i bibliotek.

---

## `scripts.misc.knowledge.knowledge_color`

Kolor jaki ma byc uzywanych do ulatwienia czytania ksiaze i bibliotek.

---

## `scripts.inv.money_bag_1`
## `scripts.inv.gems_bag_1`
## `scripts.inv.food_bag_1`
## `scripts.inv.other_bag_1`

Domyslne pojemniki do monet (money), kamieni (gems), jedzenia (food), i wszystkiego innego (other)

Opis konfiguracji: <http://arkadia.kamerdyner.net/pojemniki.html>

### Przykład
```json
"scripts.inv.money_bag_1" :"plecak",
"scripts.inv.gems_bag_1" : "sakiewka",
"scripts.inv.food_bag_1" : "torba",
"scripts.inv.other_bag_1" : "plecak"
```

Analogiczne ustawienia:
### `scripts.inv.money_bag_2`
### `scripts.inv.gems_bag_2`
### `scripts.inv.food_bag_2`
### `scripts.inv.other_bag_2`
### `scripts.inv.money_bag_3`
### `scripts.inv.gems_bag_3`
### `scripts.inv.food_bag_3`
### `scripts.inv.other_bag_3`

---

## `scripts.inv.desc_money_bag_1`
## `scripts.inv.desc_gems_bag_1`
## `scripts.inv.desc_food_bag_1`
## `scripts.inv.desc_other_bag_1`

Opis konfiguracji: <http://arkadia.kamerdyner.net/pojemniki.html>

Analogiczne ustawienia: 
### `scripts.inv.desc_gems_bag_2`
### `scripts.inv.desc_gems_bag_3`
### `scripts.inv.desc_money_bag_2`
### `scripts.inv.desc_money_bag_3`
### `scripts.inv.desc_food_bag_2`
### `scripts.inv.desc_food_bag_3`
### `scripts.inv.desc_other_bag_2`
### `scripts.inv.desc_other_bag_3`

---

## `scripts.inv.dopelniacz_money_bag_1`
## `scripts.inv.dopelniacz_gems_bag_1`
## `scripts.inv.dopelniacz_food_bag_1`
## `scripts.inv.dopelniacz_other_bag_1`

Opis konfiguracji: <http://arkadia.kamerdyner.net/pojemniki.html>

Analogiczne ustawienia: 
### `scripts.inv.dopelniacz_money_bag_2`
### `scripts.inv.dopelniacz_money_bag_3`
### `scripts.inv.dopelniacz_food_bag_2`
### `scripts.inv.dopelniacz_food_bag_3`
### `scripts.inv.dopelniacz_gems_bag_2`
### `scripts.inv.dopelniacz_gems_bag_3`
### `scripts.inv.dopelniacz_other_bag_2`
### `scripts.inv.dopelniacz_other_bag_3`

---

## `scripts.inv.biernik_money_bag_1`
## `scripts.inv.biernik_gems_bag_1`
## `scripts.inv.biernik_food_bag_1`
## `scripts.inv.biernik_other_bag_1`

Opis konfiguracji: <http://arkadia.kamerdyner.net/pojemniki.html>

Analogiczne ustawienia: 
### `scripts.inv.biernik_money_bag_2`
### `scripts.inv.biernik_money_bag_3`
### `scripts.inv.biernik_gems_bag_2`
### `scripts.inv.biernik_gems_bag_3`
### `scripts.inv.biernik_food_bag_2`
### `scripts.inv.biernik_food_bag_3`
### `scripts.inv.biernik_other_bag_2`
### `scripts.inv.biernik_other_bag_3`

---

## `scripts.inv.pre_money_bag_1`
## `scripts.inv.pre_gems_bag_1`
## `scripts.inv.pre_food_bag_1`
## `scripts.inv.pre_other_bag_1`

Opis konfiguracji: <http://arkadia.kamerdyner.net/pojemniki.html>

Analogiczne ustawienia: 
## `scripts.inv.pre_money_bag_2`
## `scripts.inv.pre_money_bag_3`
## `scripts.inv.pre_gems_bag_2`
## `scripts.inv.pre_gems_bag_3`
## `scripts.inv.pre_food_bag_2`
## `scripts.inv.pre_food_bag_3`
## `scripts.inv.pre_other_bag_2`
## `scripts.inv.pre_other_bag_3`

---

## `scripts.inv.post_money_bag_1`
## `scripts.inv.post_gems_bag_1`
## `scripts.inv.post_food_bag_1`
## `scripts.inv.post_other_bag_1`

Opis konfiguracji: <http://arkadia.kamerdyner.net/pojemniki.html>

Analogiczne ustawienia: 
### `scripts.inv.post_money_bag_2`
### `scripts.inv.post_money_bag_3`
### `scripts.inv.post_gems_bag_2`
### `scripts.inv.post_gems_bag_3`
### `scripts.inv.post_food_bag_2`
### `scripts.inv.post_food_bag_3`
### `scripts.inv.post_other_bag_2`
### `scripts.inv.post_other_bag_3`

---

## `scripts.inv.lamp.lamp_seconds_default_start_val`

Maksymalny (startowy) czas odliczania odnosnie lampy. Domyslnie 300 sekund = 5 minut.

---

## `scripts.inv.lamp.lamp_warning_times`

W ktorych sekundach odliczania skrypt wydrukuje informacje w oknie glownym o pozostalym czasie lampy. Domyslnie jest to 120, 60, 30 i 10 sekund.

Aby w ogole nic nie drukowac w oknie glownym, trzeba ustawic pusta tablice: `{}`

---

## `scripts.inv.lamp.lamp_beeps`

W ktorych sekundach odliczania skrypt wykona beep poprzez zainicjowanie eventu "playBeep". Aby nie inicjowac zadnego eventu, nalezy ustawic pusta tablice: `{}`
Mozna ustawienie wiecej niz jedna wartosc. Wartosci nie musza byc jednakowe z tymi z poprzedniej opcji.

---

## `scripts.inv.lamp.lamp_yellow_seconds`
Ponizej ktorej sekundy odliczania skrypt zacznie drukowac w dolnym pasku zoltym kolorem czcionki. Aby nie uzywac zoltej czcionki, ustawic `0`

## `scripts.inv.lamp.lamp_red_seconds`

Ponizej ktorej sekundy odliczania skrypt zacznie drukowac w dolnym pasku czerwonym kolorem czcionki. Aby nie uzywac czerwonej czcionki, ustawic 0

---

## `scripts.inv.lamp.lamp_empty_bottle_bind`

Bind, ktory ma sie bindowac gdy butelka oleju stanie sie pusta.

Aby nie bindowac nic, ustawic pusty string: ""

---

## `scripts.inv.lamp.lamp_no_bottle_bind`

Bind, ktory ma sie bindowac gdy nie mamy butelki oleju w rece.
Aby nie bindowac nic, ustawic pusty string: ""

---

## `misc.lang.aliases`

Konfiguracja bindow do mowienia jezykowego.

Przykladowo jesli chce miec `estalijski` pod `e`, a `bretonski` pod `b`
to bedzie to wygladalo tak:
```json
{
  "s" : "starsza mowa",
  "b" : "bretonski"
}
```

wtedy w grze po zrobieniu `s tekst w starszej mowie` zostanie powiedziane w starszej mowie, a `b tekst po bretonsku` zostanie powiedziane po bretonsku.

Wszystkie jezyki mozna zobaczyc w Mudlecie: `/jezyki`

---

## `misc.lang.aliases_prefix`

Konfiguracja przyslowkow do bindow.

Do kazdego binda (czyli przykladowo 's' oraz 'b' z poprzedniego przykladu) mozna sobie ustawic przyslowki, przykladowo:
```json
{
  "s" : "spokojnie",
  "b" : "nerwowo"
}
```
wtedy przy uzywaniu `s` tekst bedzie wypowiadany spokojnie w starszej mowie, a `b` tekst bedzie wypowiadany nerwowo po bretonsku.

Mozna miec rozne bindy do tych samych jezykow z roznymi przyslowkami.

---

## `misc.lang.gnome_speech`

Ustawienie gnomiej mowy.
Jesli ustawi sie true, bedzie uzywana.

Wartości:
* `true` - uzywaj gnomiej mowy
* `false` - nie uzywaj gnomiej mowy

---

## `scripts.inv.weapons.wield`

Komenda na dobywanie broni uzywana przez skrypty.

---

## `scripts.inv.weapons.cases`
## `scripts.inv.weapons.cases_dopelniacz`

Konfiguracja pojemnikow na bron do `/db[id]`, `/ob[id]` itp, pomoc w `/bronie`

---

## `scripts.inv.weapons.main_weapons_action`
Konfiguracja zachowania /db oraz /ob i do "Bron" na dolnym pasku.

---

## `scripts.inv.weapons.weapon_on_actions`
Konfiguracja jakie maja byc komendy dobywania/zakladania broni/zbroi.

---

## `scripts.inv.weapons.weapon_off_actions`
Konfiguracja jakie maja byc komendy opuszczania/zdejmowania broni/zbroi.

---

## `scripts.people.trigger_guilds`
Ładowanie triggerów bazy postaci dla wybranych gildii (`scripts.people.colored_guilds`, `scripts.people.enemy_guild` zawsze będą ładowanie niezależnie od tego ustawienia).

Komenda `/gildie` wyświetli wspierane gildie.

Postacie spoza tej listy spotkane raz, mają dodawany trigger na daną sesję.

### Przykładowo:
```json
scripts.people.trigger_guilds = [
  "CKN", "ES", "SC", "KS", "KM", "OS",
  "OHM", "SGW", "PE", "WKS", "LE", "KG",
  "KGKS", "MC", "OK", "RA", "GL", "ZT",
  "ZS", "ZH", "GP"
]
```

### Przykład domyślnego ładowania tylko NPC:
```json
scripts.people.trigger_guilds = [ "NPC" ]
```

---

## `scripts.people.showing_names`

Domyslna opcja do BAZY POSTACI czy ma pokazywac imiona/gildie przy nieznajomych (nie dotyczy wrogow, wrogowie sa zawsze pokazywani)

Dozwolone wartosci:
* `false` - nie bedzie pokazywal
* `true` - bedzie pokazywal

---

## `scripts.people.name_color`
## `scripts.people.guild_color`
Wybor kolorow do imion i gildii.

Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `scripts.people.updating_names`

Domyslna opcja do BAZY POSTACI czy ma zapamietywac postacie przy przedstawianiu

Dozwolone wartosci:
* `false` - nie bedzie pokazywal
* `true` - bedzie pokazywal

---

## `scripts.people.enemy_color`

Wybor koloru dla wrogow.

Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `scripts.people.enemy_guilds`
## `scripts.people.enemy_people`

Listy wrogów (postacie i gildie).

### Przkładowo:
```json
"scripts.people.enemy_guild" : ["SC", "MC"]
"scripts.people.enemy_people" : ["Rurek", "maly duzy elf", "Zly dobry elf"]
```

---

## `scripts.people.keep_binds_unchanged`

Czy utrzymywac bindy na stale po zbindowaniu. Czyli, jesli pojawi sie pieciu wrogow i trzech z nich zostanie
zbindowanych pod F1, F4, F5, sa dwie mozliwosci:
* `true` - dokladnie te postacie beda utrzymywane w tych bindach na stale. Mozna je bedzie zresetowac
tylko poprzez '/nabindach-' lub poprzez reset klienta.
* `false` - po wyjsciu z lokacji i po ponownym wejsciu na lokacje, wrogowie zostana przebindowani. Czyli moze sie zmienic ustawienie bindow do postaci, moga to byc zupelnie inne postacie lub te same.

---

## `scripts.people.show_binds_setting`

W jaki sposob pokazywac bindowanie wrogow.

Ustawienie ma 3 mozliwosci:

* `0` - nie pokaze bindowania w ogole. Wciaz mozna sprawdzi poprzed '/nabindach'
* `1` - bedzie pokazywalo bindy tylko wtedy, gdy beda bindowane po raz pierwszy. Jesli poprzednia opcja jest ustawiona na `false`, nie ma to znaczenia, poniewaz bindy sa zawsze przebindowywane. Jesli poprzednia opcja jest na true, wtedy pokaze bindy tylko za pierwszym razem.
* `2` - bedzie pokazywalo bindy zawsze. Nawet jesli ten sam wrog bedzie wchodzil na lokacje, komunikat bedzie sie pojawial zawsze.

---

## `scripts.people.colored_guilds`

Kolorowanie wszystkich czlonkow gildii w bazie (po imionach i shortach). Wystarczy dac klucz = wartosc jako gildia i kolor, przykladowo:
```json
"scripts.people.colored_guilds" : {
  "CKN" : "green",
  "MC" : "gold"
}
```
Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `scripts.people.colored_people`

Kolorowanie poszczegolnych ludzi z bazy. Wystarczy dac klucz = wartosc jako osoba i kolor, przykladowo:
```json
"scripts.people.colored_people" : {
  "Adremen" : "green",
  "piekny dostojny rurek" : "red"
}
```
Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `misc.cutting_pre`
## `misc.cutting_post`

Akcje przed i po wycinaniu. Czasami jest potrzeba, aby schowac jakas bron gdzies, dobyc sztyletu, i po wycinaniu to samo. 'pre' to przed wycinaniem, 'post' to po wycinaniu.

Lista komend do wykonania, np:
```json
"misc.cutting_pre" : ["powsun bron do uprzezy", "powyjmij bron z pochwy", "dobadz sztyletu"],
"misc.cutting_post" : ["powsun bron do pochwy", "powyjmij bron z uprzezy", "dobadz jej"]
```

---

## `scripts.ui.results_window.enabled`
Ustawienie czy ma byc osobny panel dla  wyszukiwania

* `true` - sidebar po prawej stronie z wynikami wyszukiwania
* `false` - wyniki beda pokazywane w glownym oknie

---

## `scripts.ui.results_window.width`

Szerokosc panelu wyszukiwania w pikselach

---

## `scripts.ui.separate_talk_window`

Ustawienie czy ma byc osobne okno rozmow

Wartości:
* `false` - wylaczone (wszystkie rozmowy tylko w glownym oknie)
* `true` - bedzie to osobne okno (takie jak do kondycji)

---

## `scripts.ui.separate_talk_window_font_size`

Wielkosc czcionki w oknie rozmow (jesli uzywane)

---

## `scripts.ui.separate_talk_window_p_width`
Zawijanie wierszy w oknie rozmow (jesli  uzywane)
Procentowa wartosc. `0.8` (domyslnie) to `80%` `0.5` bedzie `50%`, itp.

---

## `scripts.ui.separate_talk_window_no_wrap`
Wyłącza dzielenie linii w oknie rozmowy.

Wartości:
* `true` - wyłączone dzielenie linii
* `false` - włączone dzielenie linii

---

## `scripts.ui.separate_talk_window_prefix`
Prefix do kazdego wiersza w oknie rozmow.
Jesli ustawi sie "> ", przed kazdym wierszem bedzie sie pojawialo "> "

---
## `scripts.ui.separate_talk_window_timestamp`
Każda wiadomość w oknie rozmów będzie zawierała znacznik czasu. 

Pusta wartość - brak znacznika.
Wartości zgodnie z <https://www.lua.org/pil/22.1.html>

Proponowana wartość `%X` - godzina z minutami i sekundami.

```
%a  abbreviated weekday name (e.g., Wed)
%A  full weekday name (e.g., Wednesday)
%b  abbreviated month name (e.g., Sep)
%B  full month name (e.g., September)
%c  date and time (e.g., 09/16/98 23:48:10)
%d  day of the month (16) [01-31]
%H  hour, using a 24-hour clock (23) [00-23]
%I  hour, using a 12-hour clock (11) [01-12]
%M  minute (48) [00-59]
%m  month (09) [01-12]
%p  either "am" or "pm" (pm)
%S  second (10) [00-61]
%w  weekday (3) [0-6 = Sunday-Saturday]
%x  date (e.g., 09/16/98)
%X  time (e.g., 23:48:10)
%Y  full year (1998)
%y  two-digit year (98) [00-99]
%%  the character `%´
```

---

## `scripts.ui.separate_talk_window_msg_types`
Typy komunikatow, ktore maja sie pojawiac w oknie rozmow. Domyslnie sa to rozmowy i emocje. Wszystkie typy wysylane przez arkadie sa tutaj: <http://arkadia.rpg.pl/forum/viewtopic.php?f=15&t=740>

Format ma zostac taki jak ponizej: `"typ_komunikatu" : true`

```json
"scripts.ui.separate_talk_window_msg_types" : {
  "comm" : true,
  "emotes" : true
}
```

---

## `scripts.ui.separate_team_talk_window`

Ustawienie czy ma byc osobne okno rozmow druzyny

Wartości:
* `false` - wylaczone
* `true` - bedzie to osobne okno

---

## `scripts.ui.states_window_height`
## `scripts.ui.states_window_width`

Wysokosc procentowa okna glownego okna kondycji height to wysokosc procentowa, width to szerokosc procentowa
```json
"scripts.ui.states_window_height" : 45,
"scripts.ui.states_window_width" : 50
```

---

## `scripts.ui.states_window_p_width`
Zawijanie wierszy w oknie kondycji. Procentowa wartosc. `0.95` (domyslnie) to 95%, `0.8` bedzie 80%, itp.

---

## `scripts.ui.states_window_no_wrap`
Wyłącza dzielenie linii w oknie kondycji.

Wartości:
* `true` - wyłączone dzielenie linii
* `false` - włączone dzielenie linii

---


## `scripts.ui.cfg.states_window_navbar`

Czy uzywac paska stanow jako naglowka w oknie stanow
* `false` - nieuzywany
* `true` - uzywany

---

## `scripts.ui.separate_enemy_states`
Czy przeciwnicy i neutralni maja byc w oddzielnym oknie kondycji.

Wartości:
* `false` - jedno okno kondycji
* `true` - dwa okna kondycji

---

## `scripts.ui.cfg.states_window_nav_elements`

Lista elementów maja znalezc sie w naglowku okna stanow. Dostepne to: `bron`, `zaslona`, `rozkaz`, `ukryty`

Kolejnosc bedzie taka, jak wymieniona ponizej.

```json
"scripts.ui.cfg.states_window_nav_elements" : [
  "bron",
  "zaslona",
  "rozkaz",
  "ukryty"
]
```

---

## `scripts.ui.cfg.states_window_nav_printable_key_map`

Jakie przedrostki maja byc uzywane do poszczegolnego elementu Jesli do "bron" uzyte jest "BRON", to w naglowku pojawi sie: `BRON: on` lub `BRON: off`

```json
"scripts.ui.cfg.states_window_nav_printable_key_map" : {
  "bron" : "BRON",
  "zaslona" : "ZASLONA",
  "rozkaz" : "ROZKAZ",
  "ukryty" : "UKRYTY"
}
```

---

## `ateam.options.bracket_color`

Kolor nawiasów w oknie stanów

---

## `ateam.options.bracket_hp_color`

Kolor nawiasów przy pasku HP w oknie stanów

---

## `ateam.options.bracket_symbol_left`

Symbol lewego nawiasu w oknie stanów, może być ciąg znaków

---

## `ateam.options.bracket_symbol_right`

Symbol prawego nawiasu w oknie stanów, może być ciąg znaków

---

## `ateam.options.leader_indicator_symbol`

Ustawia symbol uzywany do oznaczenia prowadzacego druzyne w oknie kondycji

---

## `ateam.options.visible_stealth`

Włacza/wyłącza ramki ukrytych postaci

* `true` - imie postaci w bracketach
* `false` - niewidoczne

---

## `ateam.options.visible_attacker_count`

Włacza/wyłącza wyswietlanie liczby atakujacych wrogow

---

## `scripts.ui.fancy.enabled`

Włacza/wyłącz bardziej graficzny pasek stanów

* `true` - więcej kolorów i ikony postaci
* `false` - po staremu [#######]

Wartość bool

---

## `scripts.ui.footer_start`

W ktorym miejscu (% okna) ma sie zaczac dolna belka

---

## `scripts.ui.footer_height`
Wysokosc (w pikselsach) dolnej belki

---

## `scripts.ui.footer_width`
Szerokosc (w %) dolnej belki

---

## `scripts.ui.footer_actions_height`
Wysokosc (w pikselach) paska akcji (gorna czesc stopki)

---

## `scripts.ui.footer_map_width_p`

Jaki % dolnej belki ma zajmowac roza wiatrow

---

## `scripts.ui.footer_info_width_p`

Jaki % dolnej belki ma zajmowac prawa czesc belki (informacyjna z zaslonami itp)

---

## `scripts.ui.footer_map_width_margin`

Margines szerokosci (w pikselach) rozy wiatrow

---

## `scripts.ui.footer_map_height_margin`

Margines wysokosci (w pikselach) rozy wiatrow

---

## `scripts.ui.footer_main_items_per_row`

Ile elementow/jeden wiersz ma byc w srodkowym pasku Moga byc tam maksymalnie 3 wiersze, wiec przy uzywaniu wszystkich paskow, 4 lub 5 to dobra wartosc

---

## `scripts.ui.footer_map_font_size`

Wielkosc czcionki na rozy wiatrow (tych symboli i special exitow)

---

## `scripts.ui.footer_font_size`

Wielkosc czcionki na belce srodkowej i prawej

---

## `scripts.ui.states_font_size`

Wielkosc czcionki w oknie stanow

---

## `scripts.ui.footer_color`

Kolor stopki w formacie heksadecymalnym (`#RRGGBB`). Domyślna wartość `#00002f`.

---

## `scripts.ui.cfg.footer_mode`

Styl belki.

Dozwolone wartosci:
* `mode0` - wylaczony
* `mode1` - pasek z suwakami (bardziej graficznie)
* `mode2` - pasek z wartosciami tekstowymi (bardziej minimalistyczny niz 1)
* `mode3` - pasek z wartosciami tekstowymi (dostarczony przez Daracana)
* `mode4` - pasek z wartosciami tekstowymi (inversionz, dostarczony przez Kazura)
* `mode5` - pasek z wartosciami tekstowymi i belkami (dostarczony przez Zendrina)
* `mode6` - pasek z wartosciami tekstowymi i belkami (polaczenie mode4 i mode5)

`mode4` wymaga wgrania czcionek inversionz. Trzeba pobrac z <https://www.dafont.com/search.php?q=inversionz> i wrzucic do katalogu "fonts" w mudlet-data.

---

## `scripts.ui.cfg.footer_items`

Lista elementów na środkowej belce, kolejność tutaj jest kolejnoscia, jaka bedzie na belce.
Dozwolone elementy: 
* `zmeczenie`
* `mana`
* `pragnienie`
* `upicie`
* `kac`
* `kondycja`
* `postepy`
* `panika`
* `glod`
* `forma`
* `przeciazenie`

Przykład:
```json
"scripts.ui.cfg.footer_items" : ["zmeczenie", "mana", "pragnienie", "glod"]
```

---

## `scripts.ui.footer_info_row_count`

Ilosc wierszy w prawej, informacyjnej czesci belki

---

## `scripts.ui.cfg.info_items`

Lista elementów, jakie maja byc w prawej, informacyjnej czesci belki kolejnosc w tej tabeli jest taka jaka rowniez na belce

Mozliwe opcje to:
* `weapon`         - stan dobycia broni
* `order`          - stan rozkazu
* `cover`          - stan zaslony
* `guard_release`  - czy zasłony są puszczane
* `killed`         - licznik zabitych
* `sneaky`         - tryb przemykania
* `hidden`         - stan ukrycia
* `attack`         - tryb atakowania
* `collect`        - tryb zbierania z cial
* `mail`           - alert poczty
* `alert`          - alerty ogolne
* `lamp`           - wskazania lampy
* `compass`        - komendy pre i postwalk
* `combat`         - stan walki + ochloniecia po walce
* `package`        - aktualnie pobrana paczka pocztowa
* `placeholder`    - puste miejsce, mozna dac odstep pomiedzy konkretnymi elementami, element moze byc deklarowany pare razy
* `daylight`       - pora dnia (dzień/noc)
* `season`         - pora roku
### Przykład
```json
"scripts.ui.cfg.info_items" : ["weapon", "order", "cover", "killed", "sneaky", "hidden", "attack", "collect","mail", "alert", "lamp", "compass", "combat" ]
```

---

## `scripts.ui.multibinds.font_size`

Wielkosc czcionki paska akcji (multibindow)

---

## `scripts.ui.bind_color`

Kolor informacji o zbindowaniu

Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `scripts.inv.magics_color`

Kolor podswietlania magicznych broni/zbroi.

Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `scripts.inv.magic_keys_color`

Kolor podswietlania specjalnych kluczy.

Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `scripts.tcolor_color`

Kolor uzywany przy /tcolor (pomoc w '/bindy')

Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `scripts.gag_settings`

Konfiguracja gagow

Ponizej jest opcja co ma byc robione:
* `0` - nic, wyswietlane beda taki tekst jak przychodzi z arkadii
* `1` - bedzie usuwana dana linia (nie bedzie w ogole informacji, ze przyszla)
* `2` - bedzie gagowana z tagiem, np. `[bron] _oryginalna_linia_`

### Przykład: 

```json
"scripts.gag_settings" : {
  "moje_ciosy" : 2,
  "moje_spece" : 2,
  "innych_ciosy" : 2,
  "innych_ciosy_we_mnie" : 2,
  "innych_spece" : 2,
  "moje_uniki" : 2,
  "innych_uniki" : 2,
  "moje_parowanie" : 2,
  "innych_parowanie" : 2,
  "zaslony_udane" : 2,
  "zaslony_nieudane" : 2,
  "cele" : 2,
  "rozkazy" : 2,
  "ogluchy" : 2,
  "bloki" : 2,
  "bron" : 2,
  "npc" : 2,
  "npc_spece" : 2,
  "moj_gadacz": 0,
  "innych_gadacz": 0
}
```

---

## `scripts.gag_colors.moje_ciosy`
## `scripts.gag_colors.moje_spece`
## `scripts.gag_colors.innych_ciosy`
## `scripts.gag_colors.innych_ciosy_we_mnie`
## `scripts.gag_colors.innych_spece`
## `scripts.gag_colors.moje_uniki`
## `scripts.gag_colors.innych_uniki`
## `scripts.gag_colors.moje_parowanie`
## `scripts.gag_colors.innych_parowanie`
## `scripts.gag_colors.zaslony_udane`
## `scripts.gag_colors.zaslony_nieudane`
## `scripts.gag_colors.bron`
## `scripts.gag_colors.npc`
## `scripts.gag_colors.npc_spece`

Opcja kolorow do tagow (czyli tylko kiedy scripts.gag_settings ustawione ne 2)

Kolory, ktore mozna wybrac sa dostepne w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `scripts.gags.own_spec_prefix`

Prefix dla gagow wlasnych ciosow specjalnych.

---

## `scripts.gags.fin_prefix`

Prefix dla ciosu konczacego.

---

## Keybindy

Ponizej znajduje sie konfiguracja keybindow w skryptach.
Lista `modifier` sluzy do zdefiniowana jaki klawisz ma byc trzymany podczas binda. Najwazniejsze to: `"Shift"`, `"Control"`, `"Alt"`
Mozna nie ustawiac zadnego - wtedy bindem bedzie pojedynczy klawisz
Jesli ustawi sie `"Shift"` i `"Control"`, trzeba bedzie trzymac te dwa klawisze podczas binda.
Zmienna `key` sluzy do zdefiniowania konkretnego klawisza. Moze to byc dowolny klawisz znaku alfanumerycznego.
Lista `keys` sluzy do zdefiniowania list klawiszy.
Dokladna lista znajduje sie tutaj: <https://github.com/Mudlet/Mudlet/blob/development/src/mudlet-lua/lua/KeyCodes.lua#L2>

---

## `scripts.keybind.configuration.fight_support.modifier`
## `scripts.keybind.configuration.fight_support.key`
## `scripts.keybind.configuration.fight_support.active`

Wsparcie

---

## `scripts.keybind.configuration.attack_target.modifier`
## `scripts.keybind.configuration.attack_target.key`
## `scripts.keybind.configuration.attack_target.active`

Atakowanie celu ataku

---

## `scripts.keybind.configuration.critical_hp.modifier`
## `scripts.keybind.configuration.critical_hp.key`
## `scripts.keybind.configuration.critical_hp.active`

Uzycie kondycji w niskim stanie hp

---

## `scripts.keybind.configuration.functional_key.modifier`
## `scripts.keybind.configuration.functional_key.key`
## `scripts.keybind.configuration.functional_key.active`

Funkcjonalny bind (domyslnie ']')

---

## `scripts.keybind.configuration.attack_bind_objs.modifier`
## `scripts.keybind.configuration.attack_bind_objs.keys`
## `scripts.keybind.configuration.attack_bind_objs.active`

Atakowanie osoby z bindow

---

## `scripts.keybind.configuration.break_attack_target.modifier`
## `scripts.keybind.configuration.break_attack_target.key`
## `scripts.keybind.configuration.break_attack_target.active`

Przelamywanie i atakowanie celu ataku

---

## `scripts.keybind.configuration.block_attack_target.modifier`
## `scripts.keybind.configuration.block_attack_target.key`
## `scripts.keybind.configuration.block_attack_target.active`

Blokowanie celu ataku

---

## `scripts.keybind.configuration.collect_from_body.modifier`
## `scripts.keybind.configuration.collect_from_body.key`
## `scripts.keybind.configuration.collect_from_body.active`

Zbieranie z cial

---

## `scripts.keybind.configuration.filling_lamp.modifier`
## `scripts.keybind.configuration.filling_lamp.key`
## `scripts.keybind.configuration.filling_lamp.active`

Dopelnianie lampy

---

## `scripts.keybind.configuration.empty_bottle.modifier`
## `scripts.keybind.configuration.empty_bottle.key`
## `scripts.keybind.configuration.empty_bottle.active`

Odlozenie pustej butelki

---

## `scripts.keybind.configuration.enter_ship.modifier`
## `scripts.keybind.configuration.enter_ship.key`
## `scripts.keybind.configuration.enter_ship.active`

Wsiadanie na statki i dylizanse

---

## `scripts.keybind.configuration.temp1.modifier`
## `scripts.keybind.configuration.temp1.key`
## `scripts.keybind.configuration.temp1.active`

Tymczasowy keybind (1)

---

## `scripts.keybind.configuration.temp2.modifier`
## `scripts.keybind.configuration.temp2.key`
## `scripts.keybind.configuration.temp2.active`

Tymczasowy keybind (2)

---

## `scripts.keybind.configuration.temp3.modifier`
## `scripts.keybind.configuration.temp3.key`
## `scripts.keybind.configuration.temp3.active`

Tymczasowy keybind (3)

---

## `scripts.keybind.configuration.temp4.modifier`
## `scripts.keybind.configuration.temp4.key`
## `scripts.keybind.configuration.temp4.active`

Tymczasowy keybind (4)

---

## `scripts.keybind.configuration.temp5.modifier`
## `scripts.keybind.configuration.temp5.key`
## `scripts.keybind.configuration.temp5.active`

Tymczasowy keybind (5) (domyslnie nieaktywny)

---

## `scripts.keybind.configuration.temp6.modifier`
## `scripts.keybind.configuration.temp6.key`
## `scripts.keybind.configuration.temp6.active`

Tymczasowy keybind (6) (domyslnie nieaktywny)

---

## `scripts.keybind.configuration.temp7.modifier`
## `scripts.keybind.configuration.temp7.key`
## `scripts.keybind.configuration.temp7.active`

Tymczasowy keybind (7) (domyslnie nieaktywny)

---

## `scripts.keybind.configuration.temp8.modifier`
## `scripts.keybind.configuration.temp8.key`
## `scripts.keybind.configuration.temp8.active`

Tymczasowy keybind (8) (domyslnie nieaktywny)

---

## `scripts.keybind.configuration.temp9.modifier`
## `scripts.keybind.configuration.temp9.key`
## `scripts.keybind.configuration.temp9.active`

Tymczasowy keybind (9) (domyslnie nieaktywny)

---

## `scripts.keybind.configuration.temp10.modifier`
## `scripts.keybind.configuration.temp10.key`
## `scripts.keybind.configuration.temp10.active`

Tymczasowy keybind (10) (domyslnie nieaktywny)

---

## `scripts.keybind.configuration.multibind1.modifier`
## `scripts.keybind.configuration.multibind1.key`
## `scripts.keybind.configuration.multibind1.active`

multibind na lokacje (1)

---

## `scripts.keybind.configuration.multibind2.modifier`
## `scripts.keybind.configuration.multibind2.key`
## `scripts.keybind.configuration.multibind2.active`

multibind na lokacje (2)

---

## `scripts.keybind.configuration.multibind3.modifier`
## `scripts.keybind.configuration.multibind3.key`
## `scripts.keybind.configuration.multibind3.active`

multibind na lokacje (3)

---

## `scripts.keybind.configuration.multibind4.modifier`
## `scripts.keybind.configuration.multibind4.key`
## `scripts.keybind.configuration.multibind4.active`

multibind na lokacje (4)

---

## `scripts.keybind.configuration.opening_gate.modifier`
## `scripts.keybind.configuration.opening_gate.key`
## `scripts.keybind.configuration.opening_gate.active`

Otwieranie bram

---

## `scripts.keybind.configuration.drinking.modifier`
## `scripts.keybind.configuration.drinking.key`
## `scripts.keybind.configuration.drinking.active`

Picie ze zrodel wody

---

## `scripts.keybind.configuration.special_exit.modifier`
## `scripts.keybind.configuration.special_exit.key`
## `scripts.keybind.configuration.special_exit.active`

Bindy do przejsc specjalnych

---

## `scripts.keybind.configuration.walk_mode.modifier`
## `scripts.keybind.configuration.walk_mode.key`
## `scripts.keybind.configuration.walk_mode.active`

Tryby chodzenia

---

## `amap.using_room_gps`

Czy ma byc uzywane GPS po lokacjach.

Wartości: 
* `true`  - bedzie uzywane
* `false` - nie bedzie uzywane
 
---

## `amap.db.show_notes`

Domyslna opcja czy maja byc pokazywane notki podczas wejscia na lokacje

Wartości: 
* `true`  - beda pokazywane notki
* `false` - nie beda pokazywane notki (mozna ja wtedy zobaczyc w `/lok`)

Komenda do zmiany w trakcie gry: `/pokazuj_notki`

---

## `amap.db.show_binds`

Domyslna opcja czy maja byc pokazywane bindy podczas wejscia na lokacje

Wartości: 
* `true`  - beda pokazywane bind
* `false` - nie beda pokazywane bindy

Komenda do zmiany w trakcie gry: `/pokazuj_bindy`

---

## `amap.walker_disable`

Domyslna opcja startowa czy chodzik jest wyłączony

Wartości: 
* `true` - wyłączony
* `false` - włączony

Komenda do zmiany w trakcie gry: `/chodzik wlacz` lub `/chodzik wylacz`


---

## `amap.walker_on_map_click`

Domyslna opcja startowa czy chodzik ma uruchamiac sie po kliknieciu w mape

Dozwolone wartosci
* `true` - włączony
* `false` - wyłączony

---

## `amap.walker_delay`

Domyslna opcja startowa opoznienia chodzika

Dozwolone wartosci: `jakakolwiek liczba`

Komenda do zmiany w trakcie gry: `/opoz [wartosc]`

---

## `amap.path_display_color`

Kolor podswietlania sciezki lazika

Dostepne kolory mozna zobaczyc w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `amap.blockers.is_experimental`

Eksperymentalne blockery, z zalozenia dzialaja w szerzszej liczbie przypadkow
unikajac cofniec bedac czlonkiem druzyny
Jezeli po wlaczeniu zauwazysz problemy, wylacz je i zglos na Discord

Dozwolone wartosci
* `true` - wlaczone
* `false` - wylaczone


---

## `amap.ui.active`

Domyslna opcja startowa rozy wiatrow (czy ma byc wlaczona)

Dozwolone wartosci
* `true`  - roza bedzie wlaczona przy starcie Mudleta
* `false` - roza nie bedzie wlaczona przy starcie Mudleta

Komenda do zmiany w trakcie gry: '/roza'

---

## `amap.ui.use_simplified_compass`

Uzywaj dla rozy wiatrow uproszczonych symboli Jezeli roza wyglada z jakiegos powodu zle mozna uzyc   symboli

Dozwolne wartosci
* `true`  - roza bedzie uzywala podstawowych symboli
* `false` - roza bedzie uzywala prawdziwych strzalek

---

## `amap.ui.location_marker.color`
## `amap.ui.location_marker.color2`

Kolory do oznaczania lokacji w `/zaznaczaj` 

Dostepne kolory mozna zobaczyc w `/kolory` lub [tutaj](https://forums.mudlet.org/download/file.php?id=129&sid=be964a7a97580514727bfcb7cfcb5aec&mode=view)

---

## `amap.shorten_exits`

Czy uzywac skroconego listowania kierunkow.
* `false` to wylaczone
* `true` to wlaczone 

---


## `amap.locating.name`
## `amap.locating.loc_id`

Ustawienie startowe na konkretnej lokacji po zalogowaniu w 'name' powinna znalezc sie odmiana imienia, ktore pojawia sie po wpisaniu w Arkadii (czyli "Witaj Adremenie" dla mnie) 'loc_id' to numer lokacji na ktorej ma byc mapa ustawiona.

---

## `scripts.sounds.beep`

Ścieżka do pliku dla dźwięku beep.

Ścieżka może być bezwględna (pełna) np.
* Windows - musi zaczynać się od litery dysku np. `D:/SoundLibrary/souds/beep.wav`
* Linux/Mac - musi zaczynać się od `/` np. `/home/user/sounds/beep.wav`

Dopuszczalna jest ścięzką względna do katalogu profilu np.
* `sounds/beep.wav`

UWAGA! Sciezki powinny zawierac `/`, a nie `\`
UWAGA! Pliki z katalogu skryptów nie powinny być używane, mogą powodować problemy z aktualizacją!

---

---

## `scripts.sounds.pop`

Ścieżka do pliku dla dźwięku pop.

Ścieżka może być bezwględna (pełna) np.
* Windows - musi zaczynać się od litery dysku np. `D:/SoundLibrary/souds/beep.wav`
* Linux/Mac - musi zaczynać się od `/` np. `/home/user/sounds/beep.wav`

Dopuszczalna jest ścięzką względna do katalogu profilu np.
* `sounds/pop.wav`

---

## `scripts.mail_creator.template`

Szablon do użycia przez kreator poczty wywoływany za pomocą `/list`

Dostępne wartości:
* `plain` - bez szablonu
* `plain_border` - zwykla, prostokatna ramka
* `parchment` - pergamin
* `parchment2` - pergamin
* `parchment3` - pergamin

Dla zaawansowanych - dodatkowe szablony można stworzyć na podstawie dodając je do tablicy `scripts.mail_creator.templates` analogicznie jak już te istniejące.

---

## `scripts.mail_creator.justify`

Flaga określa czy justować tekst pisanych listów za pomocą polecenia `/list`.

Dostępne wartości:
* `true` - justowanie włączone
* `false` - justowanie wyłączone

---

## `scripts.people.mail.show_automatically`

Flaga określa czy automatycznie pokazywać scieżkę na mapie do oddania paczki, po obejrzeniu paczki, jeżeli lokalizacja NPC jest znana.

---

## `scripts.ui.notification_center.enabled`

Określa czy notyfikacje na różne wydarzenia (np. pocztę) w prawym górnym rogu maja być włączone.

Dostępne wartości:
* `true` - włączone
* `false` - wyłączone

---

## `scripts.ui.auto_wrap_main_window.enabled`

Długość linii (miejsce jej łamania dokładniej mówiąc) w głównym oknie będzie zależna od jego szerokości.
Ustawienie szczególnie użyteczne dla osób przerzucających okno na rózne wielkościowo monitory. 
Ustawienie nie działa na linie już wcześniej wyświetlone.

Dostępne wartości:
* `true` - włączone
* `false` - wyłączone

---

## `amap.legacy_locate`

Włączony sprawia, że `/zlok` działa na mapach sprzed aktualizacji systemu koordynatów.
Jeżeli `/zlok` nie działa to albo wystarczy włączyć tą opcję albo zaktualizować mapę komendą: 
```/lua amap.area_verifier:convert_map()```

Dostępne wartości:
* `true` - włączone
* `false` - wyłączone

---

## `ateam.next_attack_objs.mark_in_state`

Oznaczanie na pomarańczowo cyferki celu oznaczonego jako następny cel ataku (przy użyciu aliasów `/q [id]`).

Dostępne wartości:
* `true` - włączone
* `false` - wyłączone

---

## `ateam.next_attack_objs.window.enabled`

Pokazuje okno kolejki mobów do bicia (utworzonej za pomocą aliasów `/q [id]`)

Dostępne wartości:
* `true` - włączone
* `false` - wyłączone

---

## `ateam.next_attack_objs.window.font_size`

Ustawia wielkość czcionka dla okna kolejki mobów (jeśli używane).

---

## `scripts.ui.inline_compass_rose.enabled`

Włącza lub wyłącza róże wiatrów pokazywaną pod wyjściami z lokacji.
Wyjścia brane są z GMCP (z komunikatu z Arkadii), a nie z mappera.

Dostępne wartości:
* `true` - włączone
* `false` - wyłączone

---

## `amap.disable_team_sneak`

Wyłącza z ustawień przemykania opcje przemykania z drużyną.

Dostępne wartości:
* `true` - przemykanie z drużyną pominięte
* `false` - przemykanie z druyżną dostępne

---

## `scripts.transports.show_progress`

Włącza/wyłącza pasek pokazujący orientacyjny czas do dotarcia do celu podczas korzystania ze środków transportu.

Dostępne wartości:
* `true` - pasek będzie widoczny
* `false` - pasek będzie niewidoczny

---

## `amap.water_animal`

Włącza/wyłącza pojenie zwierzęcia razem z piciem wody na lokacji.

Dostępne wartości:
* `true` - pojenie włączone
* `false` - pojenie wyłączone

---

## `ateam.cover_command`

Ustawienie komendy do zaslony, domyslnie jest `zaslon`.

---

## `scripts.ui.theme`

Ustawienie wyglądu interefejsu skryptów.

Dostępne wartości:
* `arkadia`
* `plain`

---

## `scripts.ui.combat_window.enabled`

Włącza/wyłącza oddzielne okno walki.

Dostępne wartości:
* `true` - okno włączone
* `false` - okno wyłączone

---

## `scripts.ui.combat_window.font_size`

Wielkość czionki w oknie walki.

---

## `scripts.ui.combat_window.no_wrap`

Wyłącza wrap w oknie walki.

Dostępne wartości:
* `true` - wrap wyłączony
* `false` - wrap włączony

---

## `scripts.ui.combat_window.hide_buttons`

Wyłącza przyciski w oknie walki. Wymaga restartu!

Dostępne wartości:
* `true` - przyciski wyłączone
* `false` - przyciski włączone

---

## `misc.improve.ignore_form`

Globalny licznik postepów (`/postepy2`, `/postepy3`) nie będzie aktualizowany w przypadku odrabianie śmierci lub formy,
chyba, że to ustawienia zostanie ustawione na `true`

Dostępne wartości:
* `true` - postępy będą dodawane nawet podczas odrabiania śmierci i formy
* `false` - postępy nie będa doawane podczas odrabiania śmierci i formy

## `amap.map_update.automatic`

Flaga czy mapa ma być aktualizowana automatycznie.

Dostępne wartości:
* `true` - mapa będzie aktualizowana automatycznie
* `false` - mapa nie będzie aktualizowana automatycznie