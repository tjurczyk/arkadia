function amap.shortcuts:load_shortcuts()
    amap.shortcuts.db = amap.shortcuts.db or {}
    if io.exists(getMudletHomeDir() .. "/amap_shortcuts_db.lua") then
        table.load(getMudletHomeDir() .. "/amap_shortcuts_db.lua", amap.shortcuts.db)
        amap:print_log("Skroty zaladowane")
    else
        table.save(getMudletHomeDir() .. "/amap_shortcuts_db.lua", amap.shortcuts.db)
        amap:print_log("Nie ma pliku ze skrotami, tworze nowe")
    end
end

function amap.shortcuts:save_shortcuts()
    if io.exists(getMudletHomeDir() .. "/amap_shortcuts_db.lua") then
        table.save(getMudletHomeDir() .. "/amap_shortcuts_db.lua", amap.shortcuts.db)
    end
end

function amap.shortcuts:print_shortcuts()
    if table.size(amap.shortcuts.db) == 0 then
        amap:print_log("Nie masz jeszcze skrotow")
        return
    end

    cecho("<green>Skrot                 Lokacja    Opis\n")
    for k, v in pairs(amap.shortcuts.db) do
        local str_name = string.sub(v["s_name"] .. "                     ", 1, 22)
        local str_room = string.sub(v["s_id"] .. "      ", 1, 6)
        echo(str_name .. str_room .. "     " .. v["s_desc"] .. "\n")
    end
end

function amap.shortcuts:add_shortcut(s_id, s_name, s_desc)
    if amap.shortcuts.db[s_name] then
        amap:print_log("Skrot o takiej nazwie juz istnieje")
        return
    end

    local arr = { ["s_name"] = s_name, ["s_id"] = s_id, ["s_desc"] = s_desc }
    amap.shortcuts.db[s_name] = arr
    amap:print_log("Skrot utworzony")
end

function amap.shortcuts:delete_shortcut(s_name)
    if amap.shortcuts.db[s_name] then
        amap.shortcuts.db[s_name] = nil
        amap:print_log("Skrot usuniety")
    else
        amap:print_log("Taki skrot nie istnieje")
    end
end

function amap.shortcuts:delete_shortcuts()
    if amap.shortcuts.second_delete_call then
        amap.shortcuts.db = {}
        amap:print_log("Skroty wyczyszczone")
    else
        amap:print_log("Jestes pewien? Potwierdz ponownym wykonaniem komendy")
        amap.shortcuts.second_delete_call = true
        tempTimer(10, function() amap.shortcuts.second_delete_call = nil end)
    end
end

function amap.shortcuts:get_room_by_name(s_name)
    if amap.shortcuts.db[s_name] then
        return amap.shortcuts.db[s_name]["s_id"]
    else
        return nil
    end
end

function alias_func_mapper_shortcuts_print_shortcuts()
    amap.shortcuts:print_shortcuts()
end

function alias_func_mapper_shortcuts_add_shortcut()
    amap.shortcuts:add_shortcut(matches[2], matches[3], matches[4])
end

function alias_func_mapper_shortcuts_delete_shortcut()
    amap.shortcuts:delete_shortcut(matches[2])
end

function alias_func_mapper_shortcuts_delete_all_shortcuts()
    amap.shortcuts:delete_shortcuts()
end

