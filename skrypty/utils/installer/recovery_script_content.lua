function lfs.isdir(dir)
    local current = lfs.currentdir()
    local exists = lfs.chdir(dir)
    lfs.chdir(current)
    return exists
end

function check_scripts()
    if not lfs.isdir(getMudletHomeDir() .. "/arkadia/") then
        function recover_scripts()
            local f = loadstring(recovery_code)
            f()
        end
        cecho("\n\n")
        cecho("<sea_green>--------------------------------------------------------------\n\n")
        cechoLink("<tomato>  Wyglada na to, ze skrypty mialy problem z aktualizacja.\n  Jezeli chcesz je przywrocic to kliknij tutaj", [[recover_scripts()]], "Zainstaluj najnowsza wersje skryptow", true)
        cecho("\n\n")
        cecho("<sea_green>--------------------------------------------------------------\n\n")
        cecho("\n\n")
        resetFormat()
    end
end

registerAnonymousEventHandler("sysLoadEvent", function() tempTimer(1, function() check_scripts() end) end, true)
