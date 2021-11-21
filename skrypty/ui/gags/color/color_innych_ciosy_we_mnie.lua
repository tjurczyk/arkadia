local function color_hit(val)
    if line:starts("W slepiach") then
        return
    end
    scripts.gags:gag(val, 6, "innych_ciosy_we_mnie")
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_ledwo_muska_cie()
    color_hit(1)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_lekko_rani_cie()
    color_hit(2)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_rani_cie()
    local exempts = {"lekko", "powaznie", "ciezko", "paskudnie", "smiertelnie"}
    if table.contains(exempts, matches[2]) then return end

    color_hit(3)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_powaznie_rani_cie()
    color_hit(4)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_bardzo_ciezko_rani_cie()
    color_hit(5)
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_masakruje_cie()
    color_hit(6)
end

