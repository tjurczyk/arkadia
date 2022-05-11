local function color_hit(val)
    if line:starts("W slepiach") then
        return
    end
    scripts.gags:gag(val, 6, "innych_ciosy")
end


function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_ledwo_muska()
    if string.match(matches[2], "blyskawicznie") then
        return
    end

    color_hit(1)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_lekko_rani()
    if string.match(matches[2], "blyskawicznie") then
        return
    end

    if rex.match(line, "adamantytow\\w+ mlot\\w+ bojow\\w+") then
        return
    end

    if string.match(line, "srebrzystej kosy bojowej") then
        return
    end

    color_hit(2)
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
        ["espadona"] = true
    }

    if ignore_list[matches[3]] then
        return
    end

    if string.match(matches[2], "blyskawicznie") then
        return
    end

    if string.starts(matches[1], "Dostrzegajac szanse na skuteczny atak") then
        return
    end

    if rex.match(line, "upiorn\\w+ ciemn\\w+") then
        return
    end

    color_hit(3)
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

    color_hit(4)
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

    color_hit(5)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_masakruje()
    local ignore_list = {
        ["blyskawicznie"] = true,
        ["jatagana"] = true,
        ["poteznym"] = true,
        ["pelnego"] = true,
        ["paskudnie"] = true,
        ["Twardym"] = true,
        ["desperacki"] = true,
        ["espadonem"] = true
    }

    for k, v in pairs(ignore_list) do
        if string.match(matches[2], k) then
            return
        end
    end

    if string.match(line, "srebrzysta kosa bojowa") then
        return
    end

    color_hit(6)
end

function trigger_func_skrypty_ui_gags_innych_ciosy_pajeczaki(value)

    if value == 3 and string.match(line, "powaznie") then
        return
    end

    local target = string.match(line, " cie ") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 6, target)
end