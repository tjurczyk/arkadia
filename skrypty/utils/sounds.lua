scripts.sounds = scripts.sounds or {}
scripts.sound_player = scripts.sound_player or {}

scripts.sounds.beep = getMudletHomeDir() .. "/arkadia/sounds/beep.wav"

function scripts.sound_player:play(sound)
    if not lfs.is_absolute_path(sound) then
        sound = getMudletHomeDir() .. "/" .. sound
    end
    playSoundFile(sound)
end


function scripts_play_beep()
    scripts.sound_player:play(scripts.sounds.beep)
end

function scripts.sounds:play_beep_sequence()
    raiseEvent("playBeep")
    tempTimer(0.3, function() raiseEvent("playBeep") end)
    tempTimer(0.6, function() raiseEvent("playBeep") end)
    tempTimer(0.9, function() raiseEvent("playBeep") end)
    tempTimer(1.2, function() raiseEvent("playBeep") end)
end

registerAnonymousEventHandler("playBeep", "scripts_play_beep")
