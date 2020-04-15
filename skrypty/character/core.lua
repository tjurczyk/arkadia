scripts["character"] = scripts["character"] or { ["state"] = { ["fatigue"] = -1, ["hp"] = -1, ["mana"] = -1, ["form"] = -1 } }

scripts.character.break_fatigue_level = 9

scripts.character.bind_hp_level = 1

scripts.character.bind_hp_activated = false

function scripts.character:check_critical_binds()
    scripts.character:check_hp_bind()
end

function scripts.character:check_hp_bind()
    if scripts.character.state.hp > -1 and scripts.character.state.hp <= scripts.character.bind_hp_level then
        if not scripts.character.bind_hp_activated then
            cecho("\n\n <orange>dwukrotne '" .. scripts.keybind:keybind_tostring("critical_hp") .. "': +k\n\n")
        end
        scripts.character.bind_hp_activated = true
    else
        scripts.character.bind_hp_activated = false
    end
end

