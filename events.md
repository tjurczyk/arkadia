# Eventy dostępne w skryptach:

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

## `colorPeopleBuild`

Event podniesiony po zbudowaniu triggerów na kolorwanie postaci.

---

## `amapNewLocation`

Argumenty:
  *  `arg1`: ID nowej lokacji
  *  `arg2`: kierunek, ktory zostal zlapany jako ruch

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

