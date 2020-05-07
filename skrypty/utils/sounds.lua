scripts.sounds = scripts.sounds or {}

scripts.sounds.beep = getMudletHomeDir() .. "/arkadia/sounds/beep.wav"


function scripts_play_beep()
    playSoundFile(scripts.sounds.beep)
end

registerAnonymousEventHandler("playBeep", "scripts_play_beep")

