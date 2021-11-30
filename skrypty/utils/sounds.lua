scripts.sounds = scripts.sounds or {}
scripts.sound_player = scripts.sound_player or {}

scripts.sounds.beep = getMudletHomeDir() .. "/sounds/beep.wav"

function scripts.sounds:init()
    self.handler1 = scripts.event_register:register_singleton_event_handler(self.handler, "setVar", function(_, var, value)
        if var == "scripts.sounds.beep" then
            self:verify_beep(value)
        end
    end)
    self.handler2 = scripts.event_register:register_singleton_event_handler(self.handler, "playBeep", function()
        self:play_beep()
    end)
end

local beep = lfs.attributes(scripts.sounds.beep)
if not beep then
    lfs.mkdir(getMudletHomeDir() .. "/sounds")
    local sourceFile = io.open(getMudletHomeDir() .. "/arkadia/sounds/beep.wav", "r+b")
    local destFile = io.open(scripts.sounds.beep, "w+b")
    destFile:write(sourceFile:read("*a"))
    sourceFile:close()
    destFile:close()
end

function scripts.sound_player:play(sound)
    if not lfs.is_absolute_path(sound) then
        sound = getMudletHomeDir() .. "/" .. sound
    end
    playSoundFile(sound)
end


function scripts.sounds:play_beep()
    scripts.sound_player:play(scripts.sounds.beep)
end

function scripts.sounds:play_beep_sequence()
    raiseEvent("playBeep")
    tempTimer(0.3, function() raiseEvent("playBeep") end)
    tempTimer(0.6, function() raiseEvent("playBeep") end)
    tempTimer(0.9, function() raiseEvent("playBeep") end)
    tempTimer(1.2, function() raiseEvent("playBeep") end)
end

function scripts.sounds:verify_beep(beep)
    if beep:starts("arkadia/") or beep:starts(getMudletHomeDir() .. "/arkadia") then
        scripts:print_log("Ustawiasz plik beep w katalogu skryptow. Moze to powodowac <b>bledy podczas aktualizacji skryptow<reset>.")
    end
end


scripts.sounds:init()