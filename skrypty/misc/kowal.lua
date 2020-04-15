function scripts.inv:kowal_try_bind_end()
    if not scripts.inv.kowal_working then
        scripts.utils.bind_functional("wlm;dobadz wszystkich broni;zaloz wszystkie zbroje")
    end
    scripts.inv.kowal_timet_set = false
end


