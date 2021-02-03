function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_ledwo_muska()
    if string.match(matches[2], "blyskawicznie") then
        return
    end

    scripts.gags:gag(1, 6, "innych_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_lekko_rani()
    if string.match(matches[2], "blyskawicznie") then
        return
    end

    scripts.gags:gag(2, 6, "innych_ciosy")
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

    scripts.gags:gag(3, 6, "innych_ciosy")
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

    scripts.gags:gag(4, 6, "innych_ciosy")
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

    scripts.gags:gag(5, 6, "innych_ciosy")
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

    scripts.gags:gag(6, 6, "innych_ciosy")
end

