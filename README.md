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

## ZBIERANIE Z CIAŁ

Pomoc dostępna w `/zbieranie`

Domyślnie ustawiona jest opcja, która sprawia, że będzie drukowane powiadomienie kiedy kogoś zabijemy i żeby użyc binda w celu zebrania monet + kamieni. Aby zmienić to należy użyć opcji `/zbieranie [numer_opcji]` w Mudlecie. Aby zmienić domyślne ustawienie wraz ze startem Mudleta, w pliku ustawień trzeba zmienić opcję: 

`scripts.inv.collect.current_mode = 3`

Dolny pasek zawiera też element `Collect`, który można klikać i zmieniać opcje.


---

## STATKI/DYLIŻANSE

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
