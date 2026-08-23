-- Mudlet .mpackage manifest.
-- Read by Mudlet in a sandboxed Lua state on install: plain assignments only.
--
-- IMPORTANT: `mpackage` decides the folder the archive is unpacked into,
-- i.e. getMudletHomeDir() .. "/arkadia/" -- which is exactly the directory
-- init.lua puts on package.path. Do not change it, and keep it lowercase
-- (paths are case sensitive on Linux/macOS).
mpackage = "arkadia"
version = "0.0.0"
-- Required by mudlet-package-repository's validate-mpackage workflow, which
-- greps config.lua for mpackage/title/version/created/author/description.
created = "2026-08-22T00:00:00+02:00"
author = "tjurczyk, Delwing"
title = "Skrypty do Arkadii"
-- Names a file the archive carries at .mudlet/Icon/<icon> - the layout Mudlet's
-- own package exporter writes and the one both Mudlet and the package
-- repository look in. Mudlet's package manager scales it to 96x96; the
-- repository's reindex extracts it to packages/icons/ for the website.
icon = "arkadia.png"
-- Rendered as Markdown on packages.mudlet.org. Nothing inside may close the
-- long bracket early - the site's parser also stops at the first closing pair.
description = [[Kompletny zestaw skryptów do polskiego MUD-a **Arkadia** (arkadia.rpg.pl, port 23 lub 20023) - walka, interfejs, ekwipunek, zioła, baza postaci i statystyki w jednej paczce.

## Wymagania

Skrypty wymagają **GMCP**. Przed instalacją trzeba włączyć opcję _Enable GMCP_ w ustawieniach Mudleta i uruchomić go ponownie - bez tego skrypty nie będą działać poprawnie. Wymagany jest Mudlet 4.12 lub nowszy.

## Zawartość

- **Walka** - okno kondycji z paskami życia wszystkich na lokacji, znacznikami celu ataku i obrony oraz informacją, kto kogo bije; do tego komplet bindów i klikalnych akcji (`/walka`).
- **Interfejs** - dolna belka i okno stanów; w ustawieniach można wskazać, które linie z gry są gagowane, które tagowane, a które zostają bez zmian (`/ui`).
- **Ekwipunek i pojemniki** - liczenie butelek do lampy z przypomnieniem o dopełnieniu, bindy na monety i paczki, do trzech pojemników na bronie (`/ekwipunek`, `/pojemniki`, `/bronie`).
- **Zioła** - rozpoznawanie zawartości woreczków, bindy biorące zioło z właściwego oraz pakowanie komendą `/zapakuj` (`/ziola`).
- **Baza postaci** - zapamiętuje osoby i lokacje, na których się przedstawiły; na poczcie podświetla właścicieli paczek, których adres jest już znany (`/baza`).
- **Statystyki i liczniki** - parowania i otrzymane ciosy, zabici, postępy, cechy i poziom postaci (`/stat`, `/zabici`, `/postepy`, `/cechy`).
- **Podróże** - statki i dyliżanse obsłużone od kupienia biletu po zejście, pod klawiszem `[`.
- **Dźwięki** - każdy event podnoszony przez skrypty można udźwiękowić, umieszczając plik w katalogu `sounds` w profilu.
- **Wtyczki** - własne skrypty ładowane automatycznie z katalogu `plugins`, bez ruszania samej paczki.

## Pierwsze kroki

Przy pierwszym uruchomieniu kreator konfiguracji pojawia się sam; później można go wywołać komendą `/konfiguracja`. Najszybszy start to imię postaci i to samo imię w wołaczu:

`/init Adremen Adremenie`

Pomoc ogólna znajduje się pod `/skrypty`, a każdy dział ma własną - `/walka`, `/ekwipunek`, `/ziola`, `/ui`, `/bindy`, `/baza`.

## Uwaga

Paczka zakłada katalog `arkadia` w Triggers, Aliases, Scripts i Keys. Nie należy niczego w nim umieszczać - przy każdej aktualizacji jest kasowany i tworzony od nowa. Własne triggery i aliasy powinny znaleźć się obok niego, nie w środku.

## Pomoc i kontakt

- Dokumentacja i źródła: https://github.com/tjurczyk/arkadia
- Opis kluczy konfiguracyjnych: https://github.com/tjurczyk/arkadia/blob/master/config.md
- Discord: https://discord.gg/76yaZnw
- Forum: https://arkadia.rpg.pl/forum/viewtopic.php?f=15&t=1023]]
