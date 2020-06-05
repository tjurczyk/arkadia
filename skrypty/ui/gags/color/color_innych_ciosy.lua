function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_ledwo_muska()
    if string.match(matches[2], "blyskawicznie") then
        return
    end

    selectCurrentLine()
    local str_replace = "[1/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_lekko_rani()
    if string.match(matches[2], "blyskawicznie") then
        return
    end

    selectCurrentLine()
    local str_replace = "[2/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_rani()
    local ignore_list = {
        ["lekko"] = true,
        ["powaznie"] = true,
        ["ciezko"] = true,
        ["paskudnie"] = true,
        ["i"] = true,
        ["mocno"] = true,
        ["krwawo"] = true,
        ["smiertelnie"] = true,
    }

    if ignore_list[matches[3]] then
        return
    end

    if string.match(matches[2], "blyskawicznie") then
        return
    end

    selectCurrentLine()
    local str_replace = "[3/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_powaznie_rani()
    local ignore_list = {
        ["blyskawicznie"] = true,
        ["jatagana"] = true,
        ["poteznym"] = true,
        ["pelnego"] = true,
        ["paskudnie"] = true,
        ["Twardym"] = true,
        ["desperacki"] = true
    }

    for k, v in pairs(ignore_list) do
        if string.match(matches[2], k) then
            return
        end
    end

    selectCurrentLine()
    local str_replace = "[4/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_bardzo_ciezko_rani()
    local ignore_list = {
        ["blyskawicznie"] = true,
        ["jatagana"] = true,
        ["poteznym"] = true,
        ["pelnego"] = true,
        ["paskudnie"] = true,
        ["Twardym"] = true,
        ["desperacki"] = true
    }

    for k, v in pairs(ignore_list) do
        if string.match(matches[2], k) then
            return
        end
    end

    selectCurrentLine()
    local str_replace = "[5/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_masakruje()
    local ignore_list = {
        ["blyskawicznie"] = true,
        ["jatagana"] = true,
        ["poteznym"] = true,
        ["pelnego"] = true,
        ["paskudnie"] = true,
        ["Twardym"] = true,
        ["desperacki"] = true
    }

    for k, v in pairs(ignore_list) do
        if string.match(matches[2], k) then
            return
        end
    end

    selectCurrentLine()
    local str_replace = "[6/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy"])
    resetFormat()
end

