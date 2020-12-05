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

registerAnonymousEventHandler("playBeep", "scripts_play_beep")
