function misc.lvl_calc:calculate_lvl()
    if not misc.lvl_calc.current_stats or not misc.lvl_calc.val_to_next_to_number or
            table.size(misc.lvl_calc.current_stats) == 0 or
            table.size(misc.lvl_calc.val_to_next_to_number) == 0 then
        return
    end

    -- Calculate full number of stats
    local full_stat = 0
    for k, v in pairs(misc.lvl_calc.current_stats) do
        full_stat = full_stat + (tonumber(v) - 1) * 5
    end

    -- add current stat lvls
    for k, v in pairs(misc.lvl_calc.current_val_to_next) do
        full_stat = full_stat + tonumber(v)
    end

    -- find current lvl
    local curr_lvl = 1
    for k, v in pairs(misc.lvl_calc.stat_to_real_lvl) do
        curr_lvl = k
        if full_stat < v then
            break
        end
    end

    local msg = nil

    misc.lvl_calc.full_stat = full_stat

    if full_stat < 190 then
        local missing = misc.lvl_calc.stat_to_real_lvl[curr_lvl] - full_stat
        msg = "Twoj aktualny poziom to <green>" .. misc.lvl_calc.real_lvl_string[curr_lvl] .. " (" .. tostring(full_stat) ..
                ")<tomato> i brakuje ci do nastepnego <green>" .. tostring(missing) .. "<tomato> podcech (<green>" ..
                misc.lvl_calc.real_lvl_string[curr_lvl + 1] .. "<tomato>)"
    else
        local extra = (full_stat - misc.lvl_calc.stat_to_real_lvl[curr_lvl])
        msg = "Twoj aktualny poziom to <green>" .. misc.lvl_calc.real_lvl_string[curr_lvl + 1] .. "(" .. tostring(full_stat) ..
                " i masz + <green>" .. tostring(extra) .. "<tomato> podcech"
    end

    scripts:print_log(msg)
end

function misc.lvl_calc:collect_stat_v2(stat, val_to_next)
    table.insert(misc.lvl_calc["current_stats"], misc.lvl_calc.stat_to_number[stat])
    if val_to_next then
        table.insert(misc.lvl_calc["current_val_to_next"], misc.lvl_calc.val_to_next_to_number[val_to_next])
    end
end

