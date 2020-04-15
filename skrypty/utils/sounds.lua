function scripts_play_beep()
    playSoundFile(getMudletHomeDir() .. [[/sounds/beep.wav]])
end

registerAnonymousEventHandler("playBeep", "scripts_play_beep")

