function trigger_func_skrypty_inventory_kowal_konczy_prace()
    if scripts.inv.kowal_working then
        scripts.inv.kowal_waiting = nil
        scripts.utils.bind_functional("naostrz wszystkie bronie;napraw wszystkie zbroje")
        scripts.inv.kowal_working = false
        scripts.inv.kowal_timet_set = false
    end
end

function trigger_func_skrypty_inventory_kowal_nic_do_naprawy()
    if not scripts.inv.kowal_working and not scripts.inv.kowal_timet_set then
        scripts.inv.kowal_timet_set = true
        tempTimer(0.6, function() scripts.inv:kowal_try_bind_end() end)
    end
end

function trigger_func_skrypty_inventory_kowal_zaczyna_prace()
    scripts.inv.kowal_working = true
    scripts.inv.kowal_waiting = true
end

function alias_func_skrypty_inventory_kowal_napraw()
    scripts.inv:get_from_bag({ "monety" }, "money", 1)
    scripts.inv.kowal_timet_set = false
    sendAll("naostrz wszystkie bronie", "napraw wszystkie zbroje")
end

function alias_func_skrypty_inventory_kowal_napraw_ubrania()
    scripts.inv:get_from_bag({ "monety" }, "money", 1)
    sendAll("zdejmij wszystkie zbroje", "napraw wszystkie ubrania", "zaloz wszystkie ubrania", "zaloz wszystkie zbroje")
    scripts.inv:put_into_bag({ "monety" }, "money", 1)
end

