scripts.sounds = scripts.sounds or {
    events = {}
}
scripts.sound_player = scripts.sound_player or {}

scripts.sounds.list = {
    beep = "beep.wav",
    pop = "pop.wav"
}

scripts.sounds.dir = getMudletHomeDir() .. "/sounds"
lfs.mkdir(scripts.sounds.dir)

for k, v in pairs(scripts.sounds.list) do
    local path = string.format("%s/%s", scripts.sounds.dir, v)
    scripts.sounds[k] = path
    if not lfs.attributes(path) then
        downloadFile(path, string.format("https://raw.githubusercontent.com/tjurczyk/arkadia-data/master/sounds/%s", v))
    end
end

-- backward compatibility with play beep
for _, eventName in pairs({"playerAttacked", "stunEnd"}) do
    scripts.sounds.events[eventName] = scripts.event_register:register_singleton_event_handler(scripts.sounds.events[eventName], eventName, function() scripts.sounds:play_beep() end)
end

-- backward compatibility with play beep sequences
for _, eventName in pairs({"tryingToBlock", "hasBlocked", "stunStart"}) do
    scripts.sounds.events[eventName] = scripts.event_register:register_singleton_event_handler(scripts.sounds.events[eventName], eventName, function() scripts.sounds:play_beep_sequence() end)
end


function scripts.sounds:init()
    self.handler1 = scripts.event_register:register_singleton_event_handler(self.handler, "setVar", function(_, var, value)
        if var == "scripts.sounds.beep" then
            self:verify_beep(value)
        end
    end)
    self.handler2 = scripts.event_register:register_singleton_event_handler(self.handler, "playBeep", function()
        self:play_beep()
    end)


    for _,sound in pairs(lfs.list_files(self.dir)) do
        local name, extension = sound:gmatch("(.+)%.(.+)$")()
        scripts:print_log("Registering " .. name)
        self.events[name] = scripts.event_register:force_register_event_handler(self.events[name], name, function()
            scripts.sound_player:play(string.format("%s/%s", self.dir, sound))
        end)
    end
end

function scripts.sound_player:play(sound, sequence)
    if sound == "" then
        return
    end
    if not lfs.is_absolute_path(sound) then
        sound = getMudletHomeDir() .. "/" .. sound
    end
    local repetitions = sequence or 1
    for i = 1, repetitions, 1 do
        tempTimer((i - 1) * 0.3, function() playSoundFile(sound) end)
    end
end


function scripts.sounds:play_beep()
    scripts.sound_player:play(scripts.sounds.beep)
end

function scripts.sounds:play_beep_sequence()
    scripts.sound_player:play(scripts.sounds.beep, 5)
end

function scripts.sounds:verify_beep(beep)
    if beep:starts("arkadia/") or beep:starts(getMudletHomeDir() .. "/arkadia") then
        scripts:print_log("Ustawiasz plik beep w katalogu skryptow. Moze to powodowac <b>bledy podczas aktualizacji skryptow<reset>.")
    end
end


scripts.sounds:init()