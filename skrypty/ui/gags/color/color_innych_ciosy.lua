local function color_hit(value)
    local target
    if scripts.gags:is_type("combat.avatar") then
        target = "innych_ciosy_we_mnie"

        selectString(matches[1] .. "cie", 1)
        setFgColor(255, 153, 51)
        resetFormat()
    else
        target = "innych_ciosy"
    end
    scripts.gags:gag(value, 6, target)
end


function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_ledwo_muska()
    local ignore_list = {
        "opalizujacym runicznym",
    }

    for _, v in pairs(ignore_list) do
        if line:match(v) then
            return
        end
    end

    if rex.match(line, "upiorn\\w+ ciemn\\w+") then
        return
    end

    color_hit(1)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_lekko_rani()
    local ignore_list = {
        "srebrzystej kosy",
        "opalizujacego runicznego",
        "adamantytowego mlota"
    }

    for _, v in pairs(ignore_list) do
        if line:match(v) then
            return
        end
    end

    color_hit(2)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_rani()
        local ignore_list = {
            "lekko",
            "powaznie",
            "ciezko",
            " i ",
            "mocno",
            "smiertelnie"
        }

        for _, v in pairs(ignore_list) do
            if line:match(v) then
                return
            end
        end

    if line:starts("Dostrzegajac szanse na skuteczny atak") then
        return
    end

    if line:starts("W slepiach") then
        return
    end

    if rex.match(line, "upiorn\\w+ ciemn\\w+") then
        return
    end

    color_hit(3)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_powaznie_rani()
    local ignore_list = {
        "poteznym ciosem"
    }

    for _, v in pairs(ignore_list) do
        if line:match(v) then
            return
        end
    end

    color_hit(4)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_bardzo_ciezko_rani()
    local ignore_list = {
        " i ",
    }

    for _, v in pairs(ignore_list) do
        if line:match(v) then
            return
        end
    end
    color_hit(5)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos_masakruje()
        local ignore_list = {
            " i ",
            "srebrzysta kosa bojowa",
            "opalizujacym runicznym toporem",
            "Ruszasz do przodu"
        }

        for _, v in pairs(ignore_list) do
            if line:match(v) then
                return
            end
        end

    if line:starts("Ostrze poszczerbionego oburecznego miecza") then
        return
    end

    color_hit(6)
end

function trigger_func_skrypty_ui_gags_innych_ciosy_pajeczaki(value)

    if value == 3 and line:match("powaznie") then
        return
    end

    local target = line:match(" cie ") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 6, target)
end