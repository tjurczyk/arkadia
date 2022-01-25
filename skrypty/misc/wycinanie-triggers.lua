function trigger_func_skrypty_misc_wycinanie_triggers_wyciete_cialo()
    misc.currently_cutting = misc.currently_cutting + 1
    local delay = 1.172 * math.random() + 0.498468125

    if misc.currently_cutting > misc.counted_bodies then
        misc.currently_cutting = nil
        tempTimer(delay, function() scripts.inv:put_into_bag({"wszystkie szczatki"}, "other", 1) end)
        delay = delay + 0.81251 * math.random() + 0.4788152
        tempTimer(delay, function() misc:cutting_post_action() end)
        disableTrigger("wycinanie-triggers")
    else
        if misc.cutting_mode == 1 then
            tempTimer(delay, function() send ("wytnij wszystko z " .. misc.currently_cutting .. ". ciala") end)
        else
            tempTimer(delay, function() send ("wyrwij wszystko z " .. misc.currently_cutting .. ". ciala") end)
        end
    end
end

function trigger_func_skrypty_misc_wycinanie_triggers_brak_ciala()
    misc.currently_cutting = nil
    local delay = 1.1 * math.random() + 0.57231
    tempTimer(delay, function() scripts.inv:put_into_bag({"wszystkie szczatki"}, "other", 1) end)
    delay = delay + 1.067523 * math.random() + 0.7125612
    tempTimer(delay, function() misc:cutting_post_action() end)
    disableTrigger("wycinanie-triggers")
    disableTrigger("wycinanie-triggers")
end

