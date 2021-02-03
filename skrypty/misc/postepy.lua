function alias_func_skrypty_misc_postepy_postepy()
    misc.improve:print_improve()
end

function alias_func_skrypty_misc_postepy_postepy2()
    misc.improve:print_improvee2()
end

function alias_func_skrypty_misc_postepy_postepy3()
    misc.improve:print_improvee3()
end

function alias_func_skrypty_misc_postepy_postepy_reset()
    misc.improve:improve_reset()
end

function alias_func_skrypty_misc_postepy_postepy2_reset()
    misc.improve:reset_improvee2()
end

function alias_func_skrypty_misc_postepy_postepy2_plus()
    misc.improve:add_improvee2(1)
end

function alias_func_skrypty_misc_postepy_postepy2__val()
    misc.improve:add_improvee2(tonumber(matches[2]))
end

function alias_func_skrypty_misc_postepy_postepy2_minus()
    misc.improve:remove_improvee2(tonumber(matches[2]))
end

function alias_func_skrypty_misc_postepy_postepy2_minus_val()
    misc.improve:remove_improvee2_val(tonumber(matches[2]), tonumber(matches[3]))
end

function alias_func_skrypty_misc_postepy_postepy2_off()
    misc.improve["improve2_enabled"] = false
    scripts:print_log("Ok, nie bede dodawal do globalnego licznika postepow")
end

function alias_func_skrypty_misc_postepy_postepy2_on()
    misc.improve["improve2_enabled"] = true
    scripts:print_log("Ok, bede dodawal do globalnego licznika postepow")
end

