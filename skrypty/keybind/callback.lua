function callback_fight_support()
    send(ateam.support_command)

    if ateam.to_support then
        send(ateam.support_command .. " " .. "ob_" .. ateam.to_support)
        ateam.to_support = nil
    end
end

function callback_attack_target()
    send(ateam:get_attack_string() .. "cel ataku")
end

function callback_critical_hp()
    if not scripts.character.bind_hp_activated then
        return
    end

    if scripts.character.critical_hp_clicked then
        scripts.character.critical_hp_clicked = false
        send("+kondycja", true)
    else
        scripts.character.critical_hp_clicked = true
        tempTimer(3, function() scripts.character.critical_hp_clicked = false end)
    end
end

function callback_functional_bind()
    scripts.utils.execute_functional()
end

function callback_bind_attack_obj()
    scripts:print_log("Uzywasz starej wersji keybindow na wrogow, czytaj forum: ")
end

function callback_bind_attack_objs(arg)
    if not arg then
        return
    end

    local id_to_attack = scripts.people.bind_attack_objs[arg]
    if id_to_attack then
        ateam:zab_func(id_to_attack)
    end
end

function callback_break_defense()
    sendAll("przestan kryc sie za zaslona", "przelam obrone celu ataku", true)
    expandAlias("/zz cel ataku", true)
end

function callback_block_attack_obj()
    sendAll("zablokuj cel ataku", true)
end

function callback_collect_from_body()
    scripts.inv.collect:key_pressed(false)
end

function callback_filling_lamp()
    send("napelnij lampe olejem", true)
end

function callback_empty_bottle()
    scripts.inv.lamp:take_bottle()
end

function callback_enter_ship()
    scripts.utils.execute_ship()
end

function callback_temp1()
    scripts.temp_binds.execute_temp_bind(1)
end

function callback_temp2()
    scripts.temp_binds.execute_temp_bind(2)
end

function callback_temp3()
    scripts.temp_binds.execute_temp_bind(3)
end

function callback_temp4()
    scripts.temp_binds.execute_temp_bind(4)
end

function callback_temp5()
    scripts.temp_binds.execute_temp_bind(5)
end

function callback_temp6()
    scripts.temp_binds.execute_temp_bind(6)
end

function callback_temp7()
    scripts.temp_binds.execute_temp_bind(7)
end

function callback_temp8()
    scripts.temp_binds.execute_temp_bind(8)
end

function callback_temp9()
    scripts.temp_binds.execute_temp_bind(9)
end

function callback_temp10()
    scripts.temp_binds.execute_temp_bind(10)
end

function callback_opening_gate()
    amap:gate_keybind_pressed()
end

function callback_drinking()
    amap:drinking_bind()
end

function callback_special_exit()
    amap.db:execute_bind()
end

function callback_walk_mode()
    scripts_ui_info_sneaky_click()
end


