misc = misc or {
    improve = {
        ignore_form = false
    },
    counter = {},
    stats = {}
}

misc.cutting_pre = {}
misc.cutting_post = {}

misc.exploration = false
disableTrigger("exploration")

function misc:get_valued(amount)
    local valued = {}
    valued["mth"] = math.floor(amount / 24000)
    local rest = amount - valued["mth"] * 24000
    valued["zl"] = math.floor(rest / 240)
    rest = rest - valued["zl"] * 240
    valued["sr"] = math.floor(rest / 12)
    rest = rest - valued["sr"] * 12
    valued["mdz"] = rest

    return valued
end

function misc:get_valued_string(amount)
    valued_dict = misc:get_valued(amount)
    local money_str = ""

    if valued_dict["mth"] > 0 then
        money_str = money_str .. " <CornflowerBlue>" .. valued_dict["mth"] .. " mth"
        if valued_dict["zl"] > 0 or valued_dict["sr"] > 0 or valued_dict["mdz"] > 0 then
            money_str = money_str .. ","
        end
    end

    if valued_dict["zl"] > 0 then
        money_str = money_str .. " <gold>" .. valued_dict["zl"] .. " zl"
        if valued_dict["sr"] > 0 or valued_dict["mdz"] > 0 then
            money_str = money_str .. ","
        end
    end

    if valued_dict["sr"] > 0 then
        money_str = money_str .. " <grey>" .. valued_dict["sr"] .. " sr"
        if valued_dict["mdz"] > 0 then
            money_str = money_str .. ","
        end
    end

    if valued_dict["mdz"] > 0 then
        money_str = money_str .. " <sienna>" .. valued_dict["mdz"] .. " mdz"
    end

    return money_str
end

function misc:run_separeted_command(command)
    if command and command == "" then
        return
    end
    local commands = scripts.utils:separate_bind(command)
    for k, v in pairs(commands) do
        if v["delay"] then
            tempTimer(v["delay"], function() expandAlias(v["bind"]) end)
        else
            expandAlias(v["bind"])
        end
    end
end


function misc:test_commands()
end

function trigger_func_skrypty_misc_gubisz_kompana()
    if selectString(matches[2], 1) > -1 then
        fg("purple")
        bg("grey")
        replace(string.upper(matches[2]))
        resetFormat()
    end
end

function trigger_func_skrypty_misc_klatka_mahakam()
    raiseEvent("playBeep")
end

function trigger_func_skrypty_misc_brak_monet()
    scripts.utils.bind_functional("wem")
end

function trigger_func_skrypty_misc_gonienie()
    if rex.match(multimatches[2][2], "(?i)" .. multimatches[1][2]) then
        misc:enemy_escape_print_arrow(multimatches[2][4], "blue")
    end
end

function trigger_func_skrypty_misc_gonienie_panika()
    if rex.match(multimatches[2][2], "(?i)" .. multimatches[1][2]) then
        misc:enemy_escape_print_arrow(multimatches[2][3])
    end
end

function trigger_func_skrypty_misc_gonienie_elfka()
    misc:enemy_escape_print_arrow(matches[2], "red")
end

function trigger_func_skrypty_misc_nosi_na_sobie()
    local color = scripts.inv.magics_color

    local split_by_comma = string.split(matches[2], ", ")
    for k, v in pairs(split_by_comma) do
        local split_by_and = string.split(v, " i ")
        if #split_by_and > 1 then
            for x, y in pairs(split_by_and) do
                if scripts.inv.magics_data.magics[y] then
                    --selectString(y, 1)
                    --fg(color)
                    --resetFormat()
                end
            end
        else
            if scripts.inv.magics_data.magics[v] then
                --selectString(v, 1)
                --fg(color)
                --resetFormat()
            end
        end
    end
end

function trigger_func_skrypty_misc_do_zobaczenia_resety()
    misc.stats:reset_stats()
    misc.counter:reset()
    scripts.ui:info_action_update("")
    scripts.ui:info_compass_update("")
    tempTimer(1.2, function() misc.improve:improve_reset() end)
    scripts.ui:info_killed_update()
    scripts.utils.enable_keybinds(true)
    scripts.temp_binds.unbind_temp(true)
    amap["queue"] = get_new_list()
    misc_clear_dump()
    scripts.character_name = nil
    amap:follow_mode()
end

function trigger_func_skrypty_misc_oceniasz_starannie()
    prefix("\n======= ")
    echo(" ========\n\n")
    selectCurrentLine()
    bg("DarkSlateGray")
    fg("white")
    resetFormat()
end

function trigger_func_skrypty_misc_tablica_nowe_notki()
    scripts.utils.bind_functional("ob tablice ogloszeniowa")
end

function trigger_func_skrypty_misc_atakuje_cie_beep()
    misc.attack_beep:process_attack(matches[2])
end

function trigger_func_skrypty_misc_player_atakuje_cie_beep(name, upper)
    misc.attack_beep:process_player_attack(name, upper)
end

function trigger_func_skrypty_misc_ostatnie_logowanie_licznik()
    misc.improve:improve_reset()
end

function trigger_func_skrypty_misc_tropienie_pewny()
    misc:enemy_escape_print_arrow(matches[2], "RoyalBlue")
end

function trigger_func_skrypty_misc_tropienie_niepewny()
    misc:enemy_escape_print_arrow(matches[2], "yellow")
end

function trigger_func_skrypty_misc_tropienie_pewny_rasa()
    misc:enemy_escape_print_arrow(matches[2], "green")
end

function trigger_func_skrypty_misc_porownanie_wszystkich()
    local level = {
        ["rownie dobrze zbudowan"] = 0,
        ["duzo gorzej zbudowan"] = -5,
        ["znacznie gorzej zbudowan"] = -4,
        ["gorzej zbudowan"] = -3,
        ["troche gorzej zbudowan"] = -2,
        ["niewiele gorzej zbudowan"] = -1,
        ["niewiele lepiej zbudowan"] = 1,
        ["troche lepiej zbudowan"] = 2,
        ["lepiej zbudowan"] = 3,
        ["znacznie lepiej zbudowan"] = 4,
        ["duzo lepiej zbudowan"] = 5,
        ["rownie siln"] = 0,
        ["duzo slabsz"] = -5,
        ["znacznie slabsz"] = -4,
        ["slabsz"] = -3,
        ["troche slabsz"] = -2,
        ["niewiele slabsz"] = -1,
        ["duzo mniej siln"] = -5,
        ["znacznie mniej siln"] = -4,
        ["mniej siln"] = -3,
        ["troche mniej siln"] = -2,
        ["niewiele mniej siln"] = -1,
        ["niewiele silniejsz"] = 1,
        ["troche silniejsz"] = 2,
        ["silniejsz"] = 3,
        ["znacznie silniejsz"] = 4,
        ["duzo silniejsz"] = 5,
        ["rownie zreczn"] = 0,
        ["duzo mniej zreczn"] = -5,
        ["znacznie mniej zreczn"] = -4,
        ["mniej zreczn"] = -3,
        ["troche mniej zreczn"] = -2,
        ["niewiele mniej zreczn"] = -1,
        ["niewiele zreczniejsz"] = 1,
        ["troche zreczniejsz"] = 2,
        ["zreczniejsz"] = 3,
        ["znacznie zreczniejsz"] = 4,
        ["duzo zreczniejsz"] = 5,
    }

    local stats = matches['desc']
    local strEnd, conStart = string.find(stats, ", ", 1, true)
    local conEnd, dexStart = string.find(stats, " i ", conStart + 1, true)

    local str = string.sub(stats, 1, strEnd - 2)
    local con = string.sub(stats, conStart + 1, conEnd - 2)
    local dex = string.sub(stats, dexStart + 1, stats:len())

    table.insert(scripts.comparing_all.current_compare_results, -level[str])
    table.insert(scripts.comparing_all.current_compare_results, -level[dex])
    table.insert(scripts.comparing_all.current_compare_results, -level[con])
    deleteLine()

    if table.size(scripts.comparing_all.current_compare_results) == scripts.comparing_all.current_compare_count * 3 then
        disableTrigger("porownanie-wszystkich")
        tempTimer(0.1, function() misc:comparing_after(scripts.comparing_all.current_compare_results) end)
    end
end

function alias_func_skrypty_misc_zdenominuj()
    scripts.inv:get_from_bag({ "monety" }, "money", 1)
    sendAll("zdenominuj", false)
    scripts.inv:put_into_bag({ "monety" }, "money", 1)
end

function alias_func_skrypty_misc_staty()
    misc.stats:print_stats()
end

function alias_func_skrypty_misc_staty_verbose()
    misc.stats:set_verbose(tonumber(matches[2]))
end

function alias_func_skrypty_misc_staty_reset()
    misc.stats:reset_stats()
end

function alias_func_skrypty_misc_ocen_kamienie()
    misc:value_stones()
end

function alias_func_skrypty_misc_um(command)
    enableTrigger("scripts-um")
    tempTimer(0.1, function() send(command, false) end)
    tempTimer(0.5, function() disableTrigger("scripts-um") end)
end

function alias_func_skrypty_misc_wiedza()
    enableTrigger("scripts-knowledge")
    tempTimer(0.1, function() send("wiedza", false) end)
    tempTimer(1, function() disableTrigger("scripts-knowledge") end)
end

function alias_func_skrypty_misc_jezyki()
    enableTrigger("scripts-knowledge")
    tempTimer(0.1, function() send("jezyki", false) end)
    tempTimer(1, function() disableTrigger("scripts-knowledge") end)
end

function alias_func_skrypty_misc_exploration()
    if misc.exploration then
        misc.exploration = false
        disableTrigger("exploration")
        scripts:print_log("Ok, eksploracja wylaczona")
    else
        misc.exploration = true
        enableTrigger("exploration")
        scripts:print_log("Ok, eksploracja wlaczona")
    end
end

function alias_func_skrypty_misc_kolory()
    showColors()
end

function alias_func_skrypty_misc_exp_start()
    misc.improve["improve_start_timestamp"] = getEpoch()
    scripts:print_log("ok, licznik czasowy expa zrestartowany", false)
end

function alias_func_skrypty_misc_porownaj_ze_wszystkimi()
    scripts.comparing_all = {}
    scripts.comparing_all["objects_to_check"] = {}

    for k, v in pairs(gmcp.objects.nums) do
        if v ~= ateam.my_id then
            table.insert(scripts.comparing_all["objects_to_check"], v)
        end
    end

    scripts.comparing_all["current_compare_results"] = {}
    scripts.comparing_all["current_compare_count"] = table.size(scripts.comparing_all["objects_to_check"])
    enableTrigger("porownanie-wszystkich")

    for _, v in pairs(scripts.comparing_all["objects_to_check"]) do
        send("ocen ob_" .. v, false)
    end
end

function trigger_sciagnij_kaptur()
    scripts.utils.bind_functional("sciagnij kaptur")
end