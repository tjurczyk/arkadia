if not lfs.chdir(getMudletHomeDir() .. "/arkadia/") then
    function recover_scripts()
        local f = loadstring(recovery_code)
        f()
    end
    cecho("<sea_green>--------------------------------------------------------------\n\n")
    cechoLink("<tomato>  Wyglada na to, ze skrypty mialy problem z aktualizacja.\n  Jezeli chcesz je przywrocic to kliknij tutaj", [[recover_scripts()]], "Zainstaluj najnowsza wersje skryptow", true)
    cecho("\n\n")
    cecho("<sea_green>--------------------------------------------------------------\n\n")
    resetFormat()
end
