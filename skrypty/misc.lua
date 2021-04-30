misc = misc or { improve = {}, counter = {}, stats = {} }

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
    local pre_elements = string.split(command, "[;#]")
    for k, v in pairs(pre_elements) do
        expandAlias(v)
    end
end


function misc:test_commands()
end

function trigger_func_skrypty_misc_gubisz_kompana()
    selectString(matches[2], 1)
    fg("purple")
    bg("grey")
    replace(string.upper(matches[2]))
    resetFormat()
end

function trigger_func_skrypty_misc_klatka_mahakam()
    raiseEvent("playBeep")
end

function trigger_func_skrypty_misc_brak_monet()
    scripts.utils.bind_functional("wem")
end

function trigger_func_skrypty_misc_gonienie()
    misc:enemy_escape_print_arrow(multimatches[2][3], "blue")
end

function trigger_func_skrypty_misc_gonienie_panika()
    misc:enemy_escape_print_arrow(multimatches[2][2])
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
    scripts.utils:enable_keybinds(true)
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
    bg("SlateGray")
    fg("black")
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
    misc:enemy_escape_print_arrow(matches[2], "blue")
end

function trigger_func_skrypty_misc_tropienie_niepewny()
    misc:enemy_escape_print_arrow(matches[2], "yellow")
end

function trigger_func_skrypty_misc_tropienie_pewny_rasa()
    misc:enemy_escape_print_arrow(matches[2], "green")
end

function trigger_func_skrypty_misc_porownanie_wszystkich()
    local mod = {
        ["jestes"] = -1,
        ["jest"] = 1
    }

    local level = {
        ["rownie dobrze zbudowany"] = 0,
        ["niewiele lepiej zbudowany"] = 1,
        ["troche lepiej zbudowany"] = 2,
        ["lepiej zbudowany"] = 3,
        ["znacznie lepiej zbudowany"] = 4,
        ["duzo lepiej zbudowany"] = 5,
        ["rownie silny"] = 0,
        ["niewiele silniejszy"] = 1,
        ["troche silniejszy"] = 2,
        ["silniejszy"] = 3,
        ["znacznie silniejszy"] = 4,
        ["duzo silniejszy"] = 5,
        ["rownie zreczny"] = 0,
        ["niewiele zreczniejszy"] = 1,
        ["troche zreczniejszy"] = 2,
        ["zreczniejszy"] = 3,
        ["znacznie zreczniejszy"] = 4,
        ["duzo zreczniejszy"] = 5,

        -- because I suck at lua regexps, obviously

        ["rownie dobrze zbudowana"] = 0,
        ["niewiele lepiej zbudowana"] = 1,
        ["troche lepiej zbudowana"] = 2,
        ["lepiej zbudowana"] = 3,
        ["znacznie lepiej zbudowana"] = 4,
        ["duzo lepiej zbudowana"] = 5,
        ["rownie silna"] = 0,
        ["niewiele silniejsza"] = 1,
        ["troche silniejsza"] = 2,
        ["silniejsza"] = 3,
        ["znacznie silniejsza"] = 4,
        ["duzo silniejsza"] = 5,
        ["rownie zreczna"] = 0,
        ["niewiele zreczniejsza"] = 1,
        ["troche zreczniejsza"] = 2,
        ["zreczniejsza"] = 3,
        ["znacznie zreczniejsza"] = 4,
        ["duzo zreczniejsza"] = 5,
        ["rownie dobrze zbudowane"] = 0,
        ["niewiele lepiej zbudowane"] = 1,
        ["troche lepiej zbudowane"] = 2,
        ["lepiej zbudowane"] = 3,
        ["znacznie lepiej zbudowane"] = 4,
        ["duzo lepiej zbudowane"] = 5,
        ["rownie silne"] = 0,
        ["niewiele silniejsze"] = 1,
        ["troche silniejsze"] = 2,
        ["silniejsze"] = 3,
        ["znacznie silniejsze"] = 4,
        ["duzo silniejsze"] = 5,
        ["rownie zreczne"] = 0,
        ["niewiele zreczniejsze"] = 1,
        ["troche zreczniejsze"] = 2,
        ["zreczniejsze"] = 3,
        ["znacznie zreczniejsze"] = 4,
        ["duzo zreczniejsze"] = 5
    }

    local target = matches[2]
    local desc = matches[3]
    local res = mod[target] * level[desc]
    table.insert(scripts.comparing_all.current_compare_results, res)
    deleteLine()

    if table.size(scripts.comparing_all.current_compare_results) == scripts.comparing_all.current_compare_count then
        disableTrigger("porownanie-wszystkich")
        misc:comparing_after(scripts.comparing_all.current_compare_results)
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

function alias_func_skrypty_misc_um()
    enableTrigger("scripts-um")
    tempTimer(0.1, function() send("um", false) end)
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
    scripts.comparing_all["current_compare_count"] = table.size(scripts.comparing_all["objects_to_check"]) * 3
    enableTrigger("porownanie-wszystkich")

    for _, v in pairs(scripts.comparing_all["objects_to_check"]) do
        send("porownaj sile z ob_" .. v, false)
        send("porownaj zrecznosc z ob_" .. v, false)
        send("porownaj wytrzymalosc z ob_" .. v, false)
    end
end

