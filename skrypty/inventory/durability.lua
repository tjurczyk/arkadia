scripts.inv.durability = scripts.inv.durability or {}

scripts.inv.durability.replacements = {
    ["naprawde dlugo"] = { short_label = "8d", color = "green" },
    ["bardzo dlugo"] = { short_label = "5d-8d", color = "green" },
    ["dlugo"] = { short_label = "3d-5d", color = "green" },
    ["raczej dlugo"] = { short_label = "2d-3d", color = "green" },
    ["troche"] = { short_label = "1d-2d", color = "yellow" },
    ["raczej krotko"] = { short_label = "6h-1d", color = "orange" },
    ["krotko"] = { short_label = "1h-6h", color = "orange" },
    ["bardzo krotko"] = { short_label = "1h", color = "red" }
}

function trigger_func_durability_replacement()
    local current_item = scripts.inv.durability.replacements[matches[2]]
    if current_item then
        if selectString(matches[2], 1) > -1 then
            fg(current_item.color)
            replace(matches[2] .. " ("..  current_item.short_label ..")")
            resetFormat()
        end
    end
end