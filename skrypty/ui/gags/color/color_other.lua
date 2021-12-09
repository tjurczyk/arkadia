function get_kill_count(linijka)
    cecho("dupas"..linijka)
    local bestigory = {"poteznego","rogatego","gigantycznego","ogromnego","gargantuicznego","przerazajacego","muskularnego","umiesnionego"}
    local Oneadj_two_word_mobs = {"kamiennego trolla","lodowego trolla"}
    local l_keys = string.split(linijka, " ")
    if table.size(l_keys) == 3 and l_keys[3] == "zwierzoczleka" and (table.contains(bestigory, l_keys[1]:lower()) or table.contains(Bestigor.Adjectives, l_keys[2]:lower())) then
        local retrieved = db:fetch_sql(misc.counter2.db_log.counter2_log, "select count(*) as day from counter2_log where text like '%zwierzoczleka%' and (text like '%poteznego%' or  text like '%rogatego%' or  text like '%gigantycznego%' or  text like '%ogromnego%' or text like '%gargantuicznego%' or text like '%przerazajacego%' or text like '%muskularnego%' or text like '%umiesnionego%')")
        for k, v in pairs(retrieved) do
            if v["day"] then return v["day"] end
            break
        end
    elseif table.contains(misc.counter.utils.Oneadj_two_word_mobs, l_keys[2] .. " " .. l_keys[3])  then
            l_key = l_keys[2] .. " " .. l_keys[3]
            local retrieved = db:fetch_sql(misc.counter2.db_log.counter2_log, "select count(*) as day from counter2_log where text like '%'"..l_key)
            for k, v in pairs(retrieved) do
                if v["amount"] then return v["amount"] end
                break
            end
    else
        local npc = misc.counter.utils:get_entry_key(linijka)
        local sql_query = "SELECT sum(amount)as amount FROM counter2_daysum WHERE character=\"" .. scripts.character_name .. "\" AND type=\"".. npc .."\""
        local retrieved = db:fetch_sql(misc.counter2.db_daysum.counter2_daysum, sql_query)
        local Total = ""
        for k, v in pairs(retrieved) do
            if v["amount"] then return v["amount"] end
            break
        end
    end
    return -1
end

function trigger_func_skrypty_ui_gags_color_color_other_zabiles_color()
    local counter = 1
    if misc.counter.killed_amount["JA"] then
        counter = misc.counter.killed_amount["JA"]
    end
    local counter_str = "<tomato> (" .. tostring(counter) .. " / " .. tostring(misc.counter.all_kills) .. ")"
    local counter_str = counter_str.." <green>["..(get_kill_count(matches[4])+1).."]"
    selectCurrentLine()
    creplaceLine("\n\n<tomato>[  " .. matches[3]:upper() .. "  ] <grey>" .. matches[2] .. counter_str .. "\n\n")
    scripts.inv.collect:killed_action()
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_zabil_color()
    selectCurrentLine()
    local counter_str = nil

    if ateam.team_names[matches[3]] then
        local counter = 1
        if misc.counter.killed_amount[matches[3]] then
            counter = misc.counter.killed_amount[matches[3]]
        end
        counter_str = " (" .. tostring(counter) .. " / " .. tostring(misc.counter.all_kills) .. ")"
    end

    if counter_str then
        creplaceLine("\n\n<tomato>[   " .. matches[4]:upper() .. "   ] <grey>" .. matches[2] .. counter_str .. "\n\n")
    else
        creplaceLine("\n\n<tomato>[   " .. matches[4]:upper() .. "   ] <grey>" .. matches[2] .. "\n\n")
    end
    scripts.inv.collect:team_killed_action(matches[3])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_mozesz_dobywac()
    raiseEvent("playBeep")
    raiseEvent("canWieldAfterKnockOff")
    creplaceLine("<green>\n\n[    BRON    ]<cornsilk> Mozesz dobyc broni klawiszem '" .. scripts.keybind:keybind_tostring("functional_key") .."'\n\n")
    resetFormat()
    scripts.utils.bind_functional(scripts.inv.weapons.wield)
    scripts.ui:info_action_update("DOBADZ")
    scripts.ui.info_action_bind = scripts.inv.weapons.wield
end

function trigger_func_skrypty_ui_gags_color_color_other_wytracenie_tobie()
    raiseEvent("playBeep")
    raiseEvent("weaponKnockedOff")
    raiseEvent("weapon_state", false)
    creplaceLine("\n\n<tomato>[    BRON    ] " .. matches[2] .. "\n\n")
    resetFormat()
    scripts.ui:info_action_update("WYTRACENIE")
end

function trigger_func_skrypty_ui_gags_color_color_other_przelamanie()
    local team_break = ateam.team_names[matches[3]] or ateam.team_names[string.lower(matches[3])]
    local color = team_break and "green" or "red"
    creplaceLine("\n\n<".. color ..">[ KTOS LAMIE ] " .. matches[2] .. "\n\n")
    ateam:may_setup_broken_defense(matches[4])
    resetFormat()

    if team_break then
        cecho("<" .. scripts.ui:get_bind_color_backward_compatible() .. ">  [" .. scripts.keybind:keybind_tostring("attack_target") .. "<" .. scripts.ui:get_bind_color_backward_compatible() .. ">] zabij cel ataku\n")
    end
end

function trigger_func_skrypty_ui_gags_color_color_other_przelamanie_ty()
    creplaceLine("<green>\n\n[ TY LAMIESZ ] " .. matches[2] .. "\n\n")
    ateam:may_setup_broken_defense(matches[3])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_nie_przelamanie_ty()
    creplaceLine("<tomato>\n\n[ NIE LAMIESZ ] " .. matches[2] .. "\n\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_nie_przelamanie()
    creplaceLine("<tomato>\n\n[ NIE LAMIE  ] " .. matches[2] .. "\n\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_nekro_tilea()
    raiseEvent("playBeep")
    creplaceLine("<green>\n\n[    BRON    ]<cornsilk> Wez bron i dobadz jej\n\n")
    resetFormat()
    scripts.utils.bind_functional(scripts.inv.weapons.wield)
    scripts.ui:info_action_update("WEZ BRON/DOBADZ")
    scripts.ui.info_action_bind = scripts.inv.weapons.wield
end

function trigger_func_team_leadership()
    fg("DarkGoldenrod")
    prefix("\n[   DRUZYNA   ]  ")
    echo("\n\n")
    resetFormat()
end
