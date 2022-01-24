function misc:cutting_after_trigger(bodies_count)
    local delay = 1.012512 * math.random() + 0.18351
    misc.counted_bodies = scripts.counted_string_to_int[bodies_count]

    if misc.cutting_mode == 1 then
        tempTimer(delay, [[ send ("wytnij wszystko z pierwszego ciala") ]])
    else
        tempTimer(delay, [[ send ("wyrwij wszystko z pierwszego ciala") ]])
    end
    misc.currently_cutting = 1
end

function misc:cutting_pre_action()
    for k, v in pairs(misc.cutting_pre) do
        expandAlias(v, false)
    end
end

function misc:cutting_post_action()
    for k, v in pairs(misc.cutting_post) do
        expandAlias(v, false)
    end
end

function misc.cutting_post_action_single_body()
    local delay = 0.76135 * math.random() + 0.1782623
    tempTimer(delay, [[ misc:cutting_post_action() ]])
    killTrigger(dead_bodies_trigg_single)
end

function alias_func_skrypty_misc_cutting_wycinaj()
    misc.cutting_mode = 1
    misc:cutting_pre_action()
    dead_bodies_trigg = tempRegexTrigger("^.*Doliczyl.s sie ([a-z]+) sztuk(|i)\\.$", [[misc:cutting_after_trigger(matches[2]) ]])
    enableTrigger(dead_bodies_trigg)
    enableTrigger("wycinanie-triggers")

    send("policz wszystkie ciala", false)
    tempTimer(3, [[ killTrigger("]] .. dead_bodies_trigg .. [[") ]])
end

function alias_func_skrypty_misc_cutting_wycinaj_cialo()
    misc.cutting_mode = 1
    misc:cutting_pre_action()
    dead_bodies_trigg_single = tempRegexTrigger("^.*(Wycinasz|Nie|Slucham).*$", [[ misc.cutting_post_action_single_body() ]])
    local body_id = tonumber(matches[2])
    tempTimer(1.3, [[ send("wytnij wszystko z ]] .. body_id .. [[. ciala", false) ]])
end

function alias_func_skrypty_misc_cutting_wyrywaj()
    misc.cutting_mode = 2
    misc:cutting_pre_action()
    dead_bodies_trigg = tempRegexTrigger("^.*Doliczyl.s sie ([a-z]+) sztuk(|i)\\.$", [[misc:cutting_after_trigger(matches[2]) ]])
    enableTrigger(dead_bodies_trigg)
    enableTrigger("wycinanie-triggers")

    send("policz wszystkie ciala", false)
    tempTimer(3, [[ killTrigger("]] .. dead_bodies_trigg .. [[") ]])
end

function alias_func_skrypty_misc_cutting_wyrywaj_cialo()
    misc.cutting_mode = 2
    misc:cutting_pre_action()
    dead_bodies_trigg_single = tempRegexTrigger("^.*(Wycinasz|Nie|Slucham).*$", [[ misc.cutting_post_action_single_body() ]])
    local body_id = tonumber(matches[2])
    tempTimer(1.3, [[ send("wyrwij wszystko z ]] .. body_id .. [[. ciala", false) ]])
end

