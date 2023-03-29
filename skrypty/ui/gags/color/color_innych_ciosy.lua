local function color_hit(value)
    local target
    if scripts.gags:is_type("combat.avatar") then
        target = "innych_ciosy_we_mnie"

        if selectString(matches["damage"] .. " cie", 1) > -1 then
            setFgColor(255, 153, 51)
        end
        resetFormat()
    else
        target = "innych_ciosy"
    end
    scripts.gags:gag(value, 6, target)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_ktos()
    local damage = matches['damage']
    local value = 0
        if damage == "ledwo muska" then value = 1
    elseif damage == "lekko rani" then value = 2
    elseif damage == "rani" then value = 3
    elseif damage == "powaznie rani" then value = 4
    elseif damage == "bardzo ciezko rani" then value = 5
    elseif damage == "masakruje" or damage == "smiertelnie rani" then value = 6 end
    color_hit(value)
end

function trigger_func_skrypty_ui_gags_innych_ciosy_pajeczaki(value)

    if value == 3 and line:match("powaznie") then
        return
    end

    local target = line:match(" cie ") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 6, target)
end