ateam = ateam or {
    all_numbering = false,
    can_msg = true,
    objs = {},
    prev_enemy = nil,
    people_on_location = {},
    team = {},
    team_names = {},
    team_alphabetical_ids = {},
    my_id = nil,
    next_team_id = "A",
    to_support = nil,
    cover_command = nil,
    is_enemy_on_location = nil,
    attack_mode = 3,
    clicked_second_defense = false,
    clicked_second_attack = false,
    special_follow_bind_mode = 1,
    release_guards = false,
    attack_commands = { "zabij" },
    support_command = "wesprzyj",
    sneaky_attack = 0,
    sneaky_attack_cond = "ok",
    paralyzed_names = {},
    broken_defense_names = {},
    paralyzed_name_to_safety_timer = {},
    broken_defense_name_to_safety_timer = {},
    options = {
        team_numbering_mode = "mode1",
        team_mate_stun_bg_color = "goldenrod",
        team_mate_stun_fg_color = "black",
        enemy_stun_bg_color = "orchid",
        enemy_stun_fg_color = "black",
        broken_defense_bg_color = "LightPink",
        broken_defense_fg_color = "black",
        alphabetical_sort_team = true
    }
}

states = { [6] = "<green>#######", [5] = "<green>-######", [4] = "<yellow>--#####", [3] = "<yellow>---####", [2] = "<red>----###", [1] = "<red>-----##", [0] = "<red>------#" }
states_no_color = { [6] = "#######", [5] = "-######", [4] = "--#####", [3] = "---####", [2] = "----###", [1] = "-----##", [0] = "------#" }

ateam["footer_info_attack_mode_to_text"] = { "A", "AW", "AWR" }

function trigger_func_skrypty_team_start_ateam()
    tempTimer(4, [[ ateam:start_ateam() ]])
    tempTimer(5, function() scripts.ui:setup_talk_window() end)
end


ateam.loginHandler = scripts.event_register:register_singleton_event_handler(ateam.loginHandler, "loginSuccessful", function()
    ateam:restart_ateam();
    scripts.ui:setup_talk_window()
end)

function trigger_func_skrypty_team_left_team()
    tempTimer(0.4, function() ateam:restart_ateam(true) end)
end

function trigger_func_skrypty_team_invite_bind()
    ateam:bind_joining(matches[2])
end

function trigger_func_skrypty_team_killer_stop_watch()
    misc.improve["improve_start_timestamp"] = getEpoch()
end

function alias_func_skrypty_team_kk()
    ateam:kk()
end

function alias_func_skrypty_team_zaslon_przed()
    ateam:zas_func(string.upper(matches[2]))
end

function alias_func_skrypty_team_zabij()
    ateam:zab2_func(matches[2])
end

function alias_func_skrypty_team_zabij_noarg()
    send("zabij cel ataku", true)
end

function alias_func_skrypty_team_zaslon_team()
    ateam:za_func(string.upper(matches[2]))
end

function alias_func_skrypty_team_zaslon_team_def()
    ateam:za_func_def()
end

function alias_func_skrypty_team_zaslon_team_wzm()
    ateam:za_func_support(matches[2], matches[3])
end

function alias_func_skrypty_team_zabij_id()
    ateam:zab_func(matches[2])
end

function alias_func_skrypty_team_zaskocz_id()
    ateam:sneaky_zab_func(matches[2])
end

function alias_func_skrypty_team_zaskocz()
    ateam:sneaky_zab2_func(matches[2])
end

function alias_func_skrypty_team_przelam_id()
    ateam:prze_func(matches[2], true)
end

function alias_func_skrypty_team_przelam_id_force()
    ateam:prze_func(matches[2], false)
end

function alias_func_skrypty_team_przelam()
    if scripts.character.state.fatigue > -1 and scripts.character.state.fatigue <= scripts.character.break_fatigue_level then
        sendAll("przestan kryc sie za zaslona", "przelam obrone celu ataku", false)
    end
end

function alias_func_skrypty_team_przelam_force()
    sendAll("przestan kryc sie za zaslona", "przelam obrone celu ataku", false)
end

function alias_func_skrypty_team_restart()
    ateam:restart_ateam()
end

function alias_func_skrypty_team_help()
    ateam:print_help()
end

function alias_func_skrypty_team_rozkaz_ataku_id()
    ateam:ra_func(matches[2])
end

function alias_func_skrypty_team_rozkaz_ataku()
    if gmcp.objects.nums and ateam.current_attack_target and ateam.current_attack_target_relative and table.contains(gmcp.objects.nums, ateam.current_attack_target) then
        ateam:ra_func(ateam.current_attack_target_relative)
    end
end

function alias_func_skrypty_team_rozkaz_zaslony_id()
    ateam:rz_func(string.upper(matches[2]))
end

function alias_func_skrypty_team_rozkaz_zaslony()
    if gmcp.objects.nums and ateam.current_defense_target and ateam.current_defense_target_relative and table.contains(gmcp.objects.nums, ateam.current_defense_target) then
        ateam:rz_func(ateam.current_defense_target_relative)
    end
end

function alias_func_skrypty_team_wskaz_cel_ataku()
    ateam:wa_func(matches[2])
end

function alias_func_skrypty_team_wskaz_cel_obrony()
    ateam:wz_func(string.upper(matches[2]))
end

function alias_func_skrypty_team_all_numbering()
    ateam:switch_all_numbering()
end

function alias_func_skrypty_team_por()
    ateam:por_func(nil)
end

function alias_func_skrypty_team_por_id()
    ateam:por_func(matches[2])
end

function alias_func_skrypty_team_por_desc()
    ateam:por2_func(matches[2])
end

function alias_func_skrypty_team_gzwycofaj_sie()
    ateam:w_func(string.upper(matches[2]))
end

function alias_func_skrypty_team_rozkaz_blokady()
    if gmcp.objects.nums and ateam.current_attack_target and ateam.current_attack_target_relative and table.contains(gmcp.objects.nums, ateam.current_attack_target) then
        ateam:rb_func(ateam.current_attack_target_relative)
    end
end

function alias_func_skrypty_team_zaslon_team_group2()
    ateam:za_func_group(matches[2], 2)
end

function alias_func_skrypty_team_zaslon_team_group2_def()
    ateam:za_func_group(nil, 2)
end

function alias_func_skrypty_team_zaslon_team_group3()
    ateam:za_func_group(matches[2], 3)
end

function alias_func_skrypty_team_zaslon_team_group3_def()
    ateam:za_func_group(nil, 3)
end

function alias_func_skrypty_team_zaslon_team_group4()
    ateam:za_func_group(matches[2], 4)
end

function alias_func_skrypty_team_zaslon_team_group4_def()
    ateam:za_func_group(nil, 4)
end

function alias_func_skrypty_team_obecni()
    ateam:check_team_here()
end

function alias_func_skrypty_team_przekaz_prowadzenie()
    ateam:give_leader(string.upper(matches[2]))
end

function alias_func_skrypty_team_zapros_do_druzyny()
    ateam:zap_func(string.upper(matches[2]))
end

function alias_func_skrypty_team_zablokuj_noarg()
    send("zablokuj cel ataku", true)
end

function alias_func_skrypty_team_zablokuj()
    ateam:block_func(matches[2])
end

function alias_func_skrypty_team_puszczanie_zaslon()
    ateam:switch_releasing_guards()
end

