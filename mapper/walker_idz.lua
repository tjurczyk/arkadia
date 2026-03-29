--[[
    walker_idz.lua - Alternatywny chodzik oparty na komendzie 'idz' z MUD-a.

    Zamiast wysylac kierunki co X sekund (tryb timer), ten modul deleguje
    poruszanie sie do wbudowanej w mud komendy 'idz marszem/truchtem/biegiem/...',
    ktora automatycznie prowadzi postac przez dlugie korytarze (lokacje z 2 wyjsciami).

    Skrypt uzyje komendy mudowej wylacznie wtedy, gdy przed nami znajduje sie
    ciag co najmniej 5 lokacji o dokladnie 2 wyjsciach na zaplanowanej trasie.
    W przypadku krotkich korytarzy, skrzyzowan (>2 wyjscia), slepych uliczek,
    lub gdy mudowa komenda 'idz' sie zatrzyma, skrypt wysyla kierunki recznie
    z losowym opoznieniem ("drunken speedwalk").

    Przelaczanie trybów: /cset amap.walker_mode="mudidz" lub /cset amap.walker_mode="timer"
]]

amap.walker_idz = amap.walker_idz or {}

-- Mapowanie opoznienia (sekundy) na predkosc mudowa dla trybu idz
amap.walker_idz.delay_to_speed = {
    { max = 1.5, speed = "szybkim biegiem" },
    { max = 2.5, speed = "biegiem" },
    { max = 3.5, speed = "truchtem" },
    { max = 4.5, speed = "marszem" },
    { max = math.huge, speed = "niespiesznie" },
}

-- Domyslna predkosc w trybie mudidz (marszem = 4s)
amap.walker_idz.default_delay = 4

-- Stan wewnetrzny
amap.walker_idz.active = false
amap.walker_idz.mud_speed = nil        -- string: "marszem", "truchtem", itp.
amap.walker_idz.base_delay = nil       -- efektywne opoznienie w sekundach
amap.walker_idz.dest_room = nil        -- docelowa lokacja
amap.walker_idz.idz_running = false    -- czy mudowa komenda 'idz' aktualnie dziala
amap.walker_idz.waiting_for_stop = false

-- Zasoby (triggery, handlery, timery)
amap.walker_idz.trigger_stop = nil
amap.walker_idz.trigger_start = nil
amap.walker_idz.handler_location = nil
amap.walker_idz.timer_step = nil
amap.walker_idz.timer_safety = nil
amap.walker_idz.timer_stoj = nil

local SAFETY_TIMEOUT = 30

--[[
    Mapuje podane opoznienie (sekundy) na string predkosci mudowej.
    Zwraca: speed_string, oryginalny_delay
]]
function amap.walker_idz:get_mud_speed(delay)
    if not delay then
        return "marszem", 4
    end

    for _, entry in ipairs(self.delay_to_speed) do
        if delay <= entry.max then
            return entry.speed, delay
        end
    end

    return "niespiesznie", delay
end

--[[
    Zwraca losowe opoznienie wokol bazowej wartosci (±50%, minimum 0.5s).
    Symuluje ludzkie podejmowanie decyzji ("drunken speedwalk").
]]
function amap.walker_idz:random_delay(base)
    local min_d = math.max(0.5, base * 0.5)
    local max_d = base * 1.5
    return min_d + math.random() * (max_d - min_d)
end

--[[
    Zwraca losowe opoznienie na wyslanie 'stoj' po dotarciu na miejsce.
    Zakres: 0.3-1.2s, ale max 0.8s dla 'szybkim biegiem'.
]]
function amap.walker_idz:random_stoj_delay()
    local max_d = 1.2
    if self.mud_speed == "szybkim biegiem" then
        max_d = 0.8
    end
    return 0.3 + math.random() * (max_d - 0.3)
end

--[[
    Zwraca liczbe wyjsc z podanej lokacji.
]]
function amap.walker_idz:get_room_exit_count(room_id)
    if not room_id then return 0 end
    local count = table.size(getRoomExits(room_id) or {})
    local special = getSpecialExitsSwap(room_id)
    if special then
        count = count + table.size(special)
    end
    return count
end

--[[
    Zwraca liczbe wyjsc z aktualnej lokacji.
]]
function amap.walker_idz:get_exit_count()
    if not amap.curr or not amap.curr.id then
        return 0
    end
    return self:get_room_exit_count(amap.curr.id)
end

--[[
    Zwraca długość korytarza przed nami (ciąg lokacji z =2 wyjściami).
    Wlicza do tego aktualną lokację. Max = 1 + #speedWalkPath
]]
function amap.walker_idz:get_corridor_length()
    if self:get_exit_count() ~= 2 then return 0 end
    local len = 1
    if type(speedWalkPath) == "table" then
        for i = 1, #speedWalkPath do
            if self:get_room_exit_count(speedWalkPath[i]) == 2 then
                len = len + 1
            else
                break
            end
        end
    end
    return len
end

--[[
    Odswierza sciezke do celu. Zwraca pierwszy kierunek (short, np. "n")
    lub nil jezeli nie ma sciezki.
]]
function amap.walker_idz:refresh_path()
    if not amap.curr or not amap.curr.id or not self.dest_room then
        return nil
    end

    if amap.curr.id == self.dest_room then
        return nil
    end

    local path = getPath(amap.curr.id, self.dest_room)
    if path then
        if #speedWalkDir > 0 then
            return speedWalkDir[1]
        end
        -- getPath zwrocil true ale pusta sciezke = jestesmy na miejscu
        return nil, true
    end

    return nil
end

--[[
    Wysyla kierunek na mud (z uwzglednieniem specjalnych wyjsc).
    Uzywa short direction (np. "n", "sw").
]]
function amap.walker_idz:send_direction(short_dir)
    local long_dir = amap.short_to_long[short_dir]

    if long_dir then
        amap.dir_from_key = long_dir
        amap:pre_on_key_event()
    else
        -- Special exit
        send(short_dir)
    end
end

--[[
    Wysyla komende 'idz {predkosc}' do muda.
]]
function amap.walker_idz:send_idz()
    self.idz_running = true
    self.waiting_for_stop = false
    send("idz " .. self.mud_speed)
end

--[[
    Punkt wejscia — uruchamia chodzik w trybie mudidz.
    Wywolywany z doSpeedWalk() gdy amap.walker_mode == "mudidz".
]]
function amap.walker_idz:start()
    -- Sprawdz tryb przemykania
    if amap.walk_mode ~= 1 then
        amap:print_log("Chodzik 'mudidz' nie dziala w trybie przemykania. Przelacz na normalne chodzenie.")
        return
    end

    -- Sprawdz czy juz dziala
    if self.active then
        amap:print_log("Chodzik aktualnie pracuje, najpierw zastopuj uzywajac '/stop'")
        return
    end

    -- Oblicz predkosc mudowa bazujac na delay'u z /idz (amap.walker_delay)
    -- w przeciwnym razie uzyj domyslnego z konfiguracji lub 4s
    local input_delay = amap.walker_delay or amap.set_walker_delay or self.default_delay
    local speed, eff_delay = self:get_mud_speed(input_delay)
    self.mud_speed = speed
    self.base_delay = eff_delay

    -- Ustaw cel
    self.dest_room = speedWalkPath[#speedWalkPath]
    self.active = true
    self.idz_running = false
    self.waiting_for_stop = false

    -- Ustaw stan chodzika (wspolny z timer walker)
    amap.walker = true
    amap.walker_dest = self.dest_room
    amap.walker_set = false

    amap:print_log(string.format("Rozpoczynam chodzik (mudidz): %s (pojedyncze kroki co ok. %gs)", speed, eff_delay))
    raiseEvent("amapWalkerStarted")

    -- Zarejestruj triggery i handlery
    self:register_triggers()
    self:reset_safety_timer()

    -- Podejmij pierwsza decyzje (natychmiast, bez opoznienia)
    self:decide_next_action(true)
end

--[[
    Podejmuje decyzje co zrobic na aktualnej lokacji:
    - Jesli jestesmy na miejscu -> dotarlismy
    - Jesli 2 wyjscia -> wysylamy 'idz {predkosc}'
    - Jesli >2 lub <2 wyjsc -> wysylamy kierunek recznie
]]
function amap.walker_idz:decide_next_action(immediate)
    if not self.active then return end

    -- Sprawdz czy dotarlismy
    if amap.curr and amap.curr.id == self.dest_room then
        self:arrived()
        return
    end

    -- Odswiez sciezke
    local next_dir, at_dest = self:refresh_path()
    if not next_dir then
        if at_dest then
            -- getPath zwrocil pusta sciezke = jestesmy na miejscu
            self:arrived()
        else
            amap:print_log("Brak sciezki do celu, przerywam chodzik")
            self:force_stop()
        end
        return
    end

    local exit_count = self:get_exit_count()
    local corridor_len = 0
    if exit_count == 2 then
        corridor_len = self:get_corridor_length()
    end

    self:kill_step_timer()

    if exit_count == 2 and not self.idz_running and corridor_len >= 5 then
        -- Korytarz (>= 5 lokacji 2-wyjściowych przed nami) bez aktywnego idz
        if immediate then
            -- Pierwszy krok: wyslij kierunek natychmiast, bo bedac w miejscu MUD moze nie wiedziec gdzie isc z 'idz'
            self:send_direction(next_dir)
        else
            -- Bylismy w ruchu i dotarlismy na korytarz recznym krokiem, odpalamy 'idz'
            local delay = self:random_delay(self.base_delay)
            self.timer_step = tempTimer(delay, function()
                if self.active then
                    self:send_idz()
                end
            end)
        end
    elseif exit_count == 2 and self.idz_running then
        -- idz dziala na korytarzu — mud prowadzi, nic nie robimy
    else
        -- Krotki korytarz (<5), skrzyzowanie (>2 wyjsc) lub slepa uliczka (1 wyjscie) — wyslij kierunek recznie

        if immediate then
            -- Pierwszy krok: wyslij kierunek natychmiast
            self:send_direction(next_dir)
        else
            local delay = self:random_delay(self.base_delay)
            self.timer_step = tempTimer(delay, function()
                if not self.active then return end
                local dir, at_dest = self:refresh_path()
                if not dir then
                    if at_dest then
                        self:arrived()
                    else
                        amap:print_log("Brak sciezki do celu, przerywam chodzik")
                        self:force_stop()
                    end
                    return
                end
                self:send_direction(dir)
            end)
        end
    end
end

--[[
    Obsluga zmiany lokacji (event amapNewLocation).
]]
function amap.walker_idz:on_room_change()
    if not self.active then return end

    self:reset_safety_timer()

    -- Sprawdz czy dotarlismy
    if amap.curr and amap.curr.id == self.dest_room then
        self:arrived()
        return
    end

    if self.idz_running then
        local exit_count = self:get_exit_count()
        if exit_count == 2 then
            -- Mudowa komenda 'idz' nadal dziala na korytarzu — nic nie robimy
            return
        end
        -- Dotarlismy do skrzyzowania, mud powinien zaraz zatrzymac 'idz'
        self.waiting_for_stop = true
        return
    end

    -- Brak aktywnego idz — podejmujemy decyzje
    self:decide_next_action(false)
end

--[[
    Obsluga zatrzymania mudowej komendy 'idz'
    (trigger: "Wykonywanie komendy 'idz' zostaje przerwane.")
]]
function amap.walker_idz:on_idz_stopped()
    if not self.active then return end

    self.idz_running = false
    self.waiting_for_stop = false
    self:reset_safety_timer()

    -- Sprawdz czy w ogole mielismy isc dalej
    if amap.curr and amap.curr.id == self.dest_room then
        self:arrived()
        return
    end

    -- 'idz' wlasnie sie wywalilo w tej lokacji, puszczamy kierunek recznie
    local next_dir, at_dest = self:refresh_path()
    if not next_dir then
        if at_dest then
            self:arrived()
        else
            amap:print_log("Brak sciezki do celu, przerywam chodzik")
            self:force_stop()
        end
        return
    end

    self:kill_step_timer()
    local delay = self:random_delay(self.base_delay)
    self.timer_step = tempTimer(delay, function()
        if not self.active then return end
        local dir, at_dest = self:refresh_path()
        if not dir then
            if at_dest then
                self:arrived()
            else
                amap:print_log("Brak sciezki do celu, przerywam chodzik")
                self:force_stop()
            end
            return
        end
        self:send_direction(dir)
    end)
end

--[[
    Dotarlismy do celu — wysylamy 'stoj' i konczymy.
]]
function amap.walker_idz:arrived()
    self:kill_step_timer()

    if self.idz_running then
        local delay = self:random_stoj_delay()
        self.timer_stoj = tempTimer(delay, function()
            send("stoj")
            self:cleanup()
            amap:stop_walker()
        end)
    else
        self:cleanup()
        amap:stop_walker()
    end
end

--[[
    Wymuszone zatrzymanie — wysyla 'stoj' i przerywa.
]]
function amap.walker_idz:force_stop()
    self:kill_step_timer()

    if self.idz_running then
        send("stoj")
    end

    self:cleanup()
    amap:terminate_walker()
end

--[[
    Rejestruje tymczasowe triggery i handlery.
]]
function amap.walker_idz:register_triggers()
    -- Trigger na zatrzymanie mudowej komendy 'idz'
    self.trigger_stop = tempRegexTrigger(
        "^Wykonywanie komendy 'idz' zostaje przerwane\\.$",
        function() amap.walker_idz:on_idz_stopped() end
    )

    -- Trigger na potwierdzenie startu 'idz'
    self.trigger_start = tempRegexTrigger(
        "^Ruszasz .+ w droge\\.$",
        function()
            amap.walker_idz.idz_running = true
            amap.walker_idz.waiting_for_stop = false
        end
    )

    -- Handler na zmiane lokacji
    self.handler_location = registerAnonymousEventHandler(
        "amapNewLocation",
        function() amap.walker_idz:on_room_change() end
    )
end

--[[
    Resetuje timer bezpieczenstwa (30s bez aktywnosci = przerwij).
]]
function amap.walker_idz:reset_safety_timer()
    if self.timer_safety then
        killTimer(self.timer_safety)
    end

    self.timer_safety = tempTimer(SAFETY_TIMEOUT, function()
        if amap.walker_idz.active then
            amap:print_log("Chodzik (mudidz): timeout bezpieczenstwa (" .. SAFETY_TIMEOUT .. "s), przerywam")
            amap.walker_idz:force_stop()
        end
    end)
end

--[[
    Usuwa timer kroku (jezeli istnieje).
]]
function amap.walker_idz:kill_step_timer()
    if self.timer_step then
        killTimer(self.timer_step)
        self.timer_step = nil
    end
end

--[[
    Czysci wszystkie zasoby (triggery, handlery, timery).
]]
function amap.walker_idz:cleanup()
    self.active = false
    self.idz_running = false
    self.waiting_for_stop = false
    self.step_pending = false
    self.dest_room = nil
    self.mud_speed = nil
    self.base_delay = nil

    if self.trigger_stop then
        killTrigger(self.trigger_stop)
        self.trigger_stop = nil
    end

    if self.trigger_start then
        killTrigger(self.trigger_start)
        self.trigger_start = nil
    end

    if self.handler_location then
        killAnonymousEventHandler(self.handler_location)
        self.handler_location = nil
    end

    self:kill_step_timer()

    if self.timer_safety then
        killTimer(self.timer_safety)
        self.timer_safety = nil
    end

    if self.timer_stoj then
        killTimer(self.timer_stoj)
        self.timer_stoj = nil
    end
end
