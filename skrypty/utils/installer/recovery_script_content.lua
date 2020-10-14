recovery_check_run_once = recovery_check_run_once or false

local function check_scripts()
    if not lfs.chdir(getMudletHomeDir() .. "/arkadia/") then
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

if not recovery_check_run_once then
    recovery_check_run_once = true
    tempTimer(3, function()
        check_scripts()
        recovery_check_run_once = false
    end)
end
