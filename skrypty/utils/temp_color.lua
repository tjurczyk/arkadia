scripts.temp_alias_colors = { ["triggers"] = {} }

function scripts.temp_alias_colors:process_text(text)
    local sel = selectString(text, 1)
    local next_id = 1

    while sel > -1 do
        fg(scripts["tcolor_color"])
        next_id = next_id + 1
        sel = selectString(text, next_id)
    end

    resetFormat()
end

function scripts.temp_alias_colors:add_color(regex)
    local id = tempRegexTrigger("(" .. regex .. ")", "scripts.temp_alias_colors:process_text(matches[2])")
    table.insert(scripts.temp_alias_colors.triggers, id)
    scripts:print_log("Ok")
end

