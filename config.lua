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
description = [[Paczka skryptow do MUDa Arkadia (arkadia.rpg.pl).

Dokumentacja: https://github.com/tjurczyk/arkadia
Po instalacji: `skrypty pomoc`]]
