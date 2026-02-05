# Eventy dostępne w skryptach

## `scriptsLoaded`
  
Event podeniesiony tuz po zaladowaniu wszystkich plikow skryptow

---

## `beforeLoadModules`

Event podniesiony przed ladowaniem wszystkich skryptow z plikow .lua
Moze byc uzyty do ladowania plikow przez moduly zalaczane przed skrypytami

Argumenty:

* `arg1`: tablica modulow do zaladowania

---

## `profileLoaded`

Event podniesiony po zaladowaniu konfiguracji

---

## `loginSuccessful`

Event podniesiony po poprawnym zalogowaniu.

---

## `uiReady`

Event podniesiony po zaladowaniu calego UI

---

## `mapSave`

Event podniesiony po zapisaniu mapy.

---

## `colorPeopleBuild`

Event podniesiony po zbudowaniu triggerów na kolorwanie postaci.

---

## `teamChanged`

Event podniesiony jezeli zmieni sie sklad druzyny.

---

## `amapNewLocation`

Argumenty:

* `arg1`: ID nowej lokacji
* `arg2`: kierunek, ktory zostal zlapany jako ruch
* `arg3`: internal ID nowej lokacji (skryptowy, zawsze zaczyna sie od `i...`)

  Event ten jest podnoszony gdy mapper wykryje nowy poprawny ruch na mapie.

---

## `setPosition`

Argumenty:

* `arg1`: ID ustawionej lokacji

Event ten jest podnozszony gdy lokacja zostaje ustawiona (recznie lub automatycznie)

---

## `amapGateStoppedWalker`

Event podniesiony w momencie, kiedy chodzik zostal zatrzymany brama.

---

## `amapGateStopped`

Event podniesiony w momencie, kiedy ruch zostal zablokowany przez brame.

---

## `amapWalkerTerminated`

Event podniesiony gdy chodzik zostanie przerwany (niezaleznie od przyczyny: bloker, ruch manualny, '/stop').

---

## `amapWalkerStarted`

Event podniesiony kiedy chodzik zostanie wystartowany.

## `amapWalkerFinished`

Event podniesiony gdy chodzik dotrze do celu.

---

## `amapBlockerFired`

Event podniesiony gdy ktorys z blokerow zostal odpalony

---

## `amapPauserStarted`

Event podniesiony gdy zadzialal pauser (czyli tymczasowo wylaczyl mapper)

---

## `amapPauserStopped`

Event podniesiony gdy pauser zostal wylaczony (czyli wlaczyl mapper z powrotem)

---

## `amapCompassDrawingDone`

Event podniesiony gdy zakonczy sie rysowanie rozy wiatrow
Argumenty:

* `arg1`: tablica z normalnymi wyjsciami (e.g.: `{n = true, s = true}`)
* `arg2`: tablica ze specjalnymi wyjsciami (e.g.: `{["przejdz przez szczeline"] = true}`)

---

## `amapLocationSteppedBack`

Event gracz wykona /cofnij i zostanie cofniety na mapie z sukcesem (czyli byla historia lokacji)
Argumenty:

* `arg1`: lokacja z ktorej mapper sie cofa
* `arg2`: lokacja na ktora mapper sie cofa

---

## `amapWalking`

Event podniesiony gdy gracz wykonuje ruch przez niego zainicjowany

Argumenty:

* `arg1`: kierunek

---

## `travelDestinationReached`

Event podniesiony kiedy srodek transportu dotrze do przystanku.

Argumenty:

* `arg1`: definicja przystanku
* `arg2`: definicja transportu
* `arg3`: obiekt podrozy

---

## `herbsDatabaseBuilt`

Event podniesiony kiedy ukonczone zostanie budowanie bazy ziol.

---

## `herbBagParsed`

Event podniesiony kiedy sparsowany zostal woreczek przy zagladaniu do niego.

Argumenty:

* `arg1`: dictionary z informacjami o tym jakie tam sa ziola w jakiej ilosci oraz suma ziol

---

## `containerParsed`

Event podniesiony kiedy sparsowany zostal obejrzany pojemnik.

Argumenty:

* `arg1`: dictionary z informacjami o tym jakie elementy w jakiej ilosci sa w pojemniku.

---

## `assistantPackageDestination`

Event podniesiony kiedy wybrana paczka ma dostepny cel podrozy
Argumenty:

* `arg1`: docelowa lokacja do ktorej wybrana zostala paczka

---

## `ateamAttackingDifferentTarget`

Event ten jest podniesiony w momencie, kiedy postac atakuje innego przeciwnika niz aktualny cel ataku.

---

## `ateamToAttackTarget`

Event podniesiony w momencie, kiedy istnieje cel ataku, a postac nie bije aktualnie nikogo.

---

## `ateamTeamFollowBind`

Event podniesiony gdy zostalo zbindowane przejscie specjalne za prowadzacym.

---

## `ateamEnemyKilled`

Event podniesiony gdy zostal pokonany przeciwnik na lokacji.
Argumenty:
    * `arg1`: ilosc pozostalych przeciwnikow

---

## `ateamFightingWithNoWeapon`

  Event podniesiony gdy wykryte zostaje, ze postac walczy bez broni.

---

## `weaponKnockedOff`

  Event podniesiony po wytraceniu broni.

---

## `canWieldAfterKnockOff`

  Event podniesiony, gdy mozna dobyc broni po wytraceniu.

---

## `character_state_update`

  Event podniesiony gdy zaktualizowany zostaje co najmniej jeden ze stanow
  "scripts.character.state".

---

## `playBeep`

Po podniesieniu tego eventa jest wykonywany 'beep'. Warunkiem jest posiadanie katalogu sounds/ w katalogu profilu przekopiowanego z paczki skryptow.

---

## `miscAttackBeepModeOne`

Event podniesiony gdy postac zostala zaatakowana przez kogos z wrogow.

---

## `miscAttackBeepModeTwo`

Event podniesiony gdy postac zostala zaatakowana.

---

## `gmcp_parsing_finished`

Event podniesiony po skonczeniu parsowania ateam.objs

---

## `printStatusDone`

Event podniesiony po wypisaniu okna statusu.

---

## `ateam_am_attacked`

Argumenty:
    * `arg1`: true lub false, w zaleznosci czy nasza postac zostala zaatakowana, czy przestala byc atakowana

Event podniesiony w momencie, kiedy nasza postac jest zaatakowana/nie zaatakowana

---

## `ateam_teammate_attacked`

Argumenty:

* `arg1`: true lub false, w zaleznosci czy ktokolwiek z naszej druzyny zostal zostal zaatakowany, czy nikt z druzyny nie jest atakowany.

Event podniesiony w momencie, kiedy ktos z naszego teamu zostaje zaatakowany

---

## `ateam_all_enemies_killed`

Event podniesiony po zabiciu wszystkich wrogow na lokacji

---

## `cooledAfterCombat`

Event podniesiony po ochlonieciu od walki

---

## `temporary_bind_executed`

Argumenty:

* `arg1`: id bindu

  Event podniesiony po wykonaniu bindu tymczasowego

---

## `ateam_next_attack_obj_bind`

Argumenty:

* `arg1`: id arkadiowe obiektu
* `arg2`: id mudletowe obiektu
* `arg3`: ateam.obj obiektu

  Event podniesiony gdy zbindowany zostanie atak z kolejki pod /nn

---

## `hidden_state`

Argumenty:

* `arg1`: status ukrycia

Event podniesiony kiedy zmienia sie status ukrycia

---

## `weapon_state`

Argumenty:

* `arg1`: status dobycia broni - true|false

   Event podniesiony kiedy zmienia sie status dobycia broni

---

## `guard_state`

Argumenty:

* `arg1`: status zaslony (czas pozostaly lub OK)

Event podniesiony kiedy zmienia sie status uzycia zaslony

---

## `order_state`

Argumenty:

* `arg1`: status rozkazu (czas pozostaly lub OK)

Event podniesiony kiedy zmienia sie status wydania rozkazu

---

## `switchReleasingGuards`

Argumenty:

* `arg1`: stan puszczania zaslon (true/false)

Event podniesiony kiedy przelaczone zostanie puszczanie zaslon.

---

## `equipmentEvaluation`

Argumenty:

* `arg1`: tablica ze stanem ekwipinku

Event podniesiony po ocenieniu elementu ekwipunku.

## `setVar`

Argumenty:

* `arg1`: klucz
* `arg2`: wartosc

Event podniesiony po zmianie wartosci klucz konfiguracji.

## `footerInfoCreators`

Argumenty:

* `arg1`: tablica kreatorow

Event podniesiony po stworzeniu tablicy kreatorow elementow stopki.
Mozn go wykorzystac, zeby zarejestrowac swoj wlasny element.

## `rideProgress`

Event podniesiony podczas podrozy dylizansami itp.

Argument:

* `arg1`: obiekt podrozy
* `arg2`: aktualnie wyliczona lokacja (w przyblizeniu)

## `incomingMessage`

Event podniesiony po przeprocesowaniu wiadomosci przychodzacej.

Argument:

* `arg1`: typ wiadomosci
* `arg2`: tekst wiadomosci

## `weaponBroken`

Event podniesiony kiedy bron dzierzona przez gracza peknie.

---

## `weaponKnockedOffNekroTilea`

Event podnoszony gdy wyleci ci na ziemie bron u Nekromanty w Tilei  

---

## `improveLevelGained`

Argumenty:

* `arg1`: jak duży postęp właśnie wpadł (nieznaczne=1, itd.)

Event podnoszony gdy wiemy o ile postępów urośliśmy.

## `stunStart`

Event podniesiony na początku ogłuszenia postaci gracza.

## `stunEnd`

Event podniesiony na koniec ogłuszenia postaci gracza.

## `tryingToBlock`

Argumenty:

* `arg1`: opis/imię blokującego

Event podniesiony podczas próby bloku na postać gracza.

## `hasBlocked`

Argumenty:

* `arg1`: opis/imię blokującego

  Event podniesiony kiedy postać gracza została zablokowana.

## `playerAttacked`

* `arg1`: opis/imię atakującego

Event podniesiony kiedy postać gracza została zaatkowana. Event podnoszony jest zgodnie z ustawieniem `misc.attack_beep.mode`.


## `startParalyzed`

Event podniesiony kiedy postać na lokacji zostaje ogluszona.

* `arg1`: id ogluszonej postaci

## `endParalyzed`

Event podniesiony kiedy postać na lokacji przestaje być ogluszona.

* `arg1`: id ogluszonej postaci