function trigger_func_skrypty_misc_enemies_eq_collect_weapons()
    if not misc["checking_enemies"] then
        return
    end

    misc.enemy_eq[misc["currently_checking_enemy"]]["weapon"] = matches[2]
end

function trigger_func_skrypty_misc_enemies_eq_collect_armor()
    if not misc["checking_enemies"] then
        return
    end

    misc.enemy_eq[misc["currently_checking_enemy"]]["armor"] = matches[2]
end

function trigger_func_skrypty_misc_enemies_eq_collect_clothes()
    if not misc["checking_enemies"] then
        return
    end

    misc.enemy_eq[misc["currently_checking_enemy"]]["clothes"] = matches[2]
end

function trigger_func_skrypty_misc_enemies_eq_ogladasz_dokladnie()
    tempTimer(0.5, function()
        if check_enemies_routine then
            coroutine.resume(check_enemies_routine)
        end
    end)
end

