-- Ognisty trojzab

function trigger_func_skrypty_ui_gags_ciosy_ognisty_trojzab(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

-- Srebrzysta kosa

function trigger_func_skrypty_ui_gags_ciosy_kosa(value)
    if line:match("ykorzystujac dogodny moment") then
        return
    end
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 7, target)
end

-- Adamantytowa partyzana

function trigger_func_skrypty_ui_gags_ciosy_partyzana(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 7, target)
end

-- Kobaltowa halabarda

function trigger_func_skrypty_ui_gags_ciosy_kobaltowa(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

function trigger_func_skrypty_ui_gags_kobaltowa_spec(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 3, target)
    magic_prefix("-MANA")
end
