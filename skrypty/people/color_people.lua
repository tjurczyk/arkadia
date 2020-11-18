function scripts.people:process_person_color(id, text)
    if not scripts.people.color_table[id] then
        return
    end

    local to_select_string = text

    if scripts.people.color_suffix[string.lower(text)] then
        to_select_string = to_select_string .. " (" .. scripts.people.color_suffix[string.lower(text)] .. ")"
        selectString(text, 1)
        replace(to_select_string)
    end

    selectString(to_select_string, 1)
    fg(scripts.people.color_table[id])
    resetFormat()
end

function scripts.people:color_person_build(item, color)
    if item["short"] == "" then
        return
    end

    local short_to_check = item["short"]
    if scripts.people.color_people[short_to_check] then
        return
    end

    scripts.people.color_people[short_to_check] = true

    local first_capitalized = string.upper(string.sub(item["short"], 0, 1))
    local guild_str = scripts.people:get_guild_name(item["guild"])

    -- it gets the rest of the string (without the first letter)
    local rest_string = string.sub(item["short"], 2, #item["short"])

    -- finally, it constructs the regex
    local regex
    scripts.people.color_table[item["_row_id"]] = color

    local norm_short = string.lower(item["short"])

    regex = "(^|\\W)((" .. string.sub(item["short"], 0, 1) .. "|" .. first_capitalized .. ")" .. rest_string .. ")(?! chaosu)(\\W|$)"

    if norm_short ~= "" then
        if item["name"] ~= "" then
            scripts.people.color_suffix[norm_short] = item["name"]
        end

        if guild_str then
            if scripts.people.color_suffix[norm_short] then
                scripts.people.color_suffix[norm_short] = scripts.people.color_suffix[norm_short] .. " " .. guild_str
            end
        end
    end

    if item["name"] ~= "" then
        if not scripts.people.color_suffix[string.lower(item["name"])] then
            regex = "(^|\\W)((" .. string.sub(item["short"], 0, 1) .. "|" .. first_capitalized .. ")" .. rest_string .. "|" .. item["name"] .. ")(?! chaosu)(\\W|$)"
        else
            regex = "(^|\\W)((" .. string.sub(item["short"], 0, 1) .. "|" .. first_capitalized .. ")" .. rest_string .. ")(?! chaosu)(\\W|$)"
        end
    else
        regex = "(^|\\W)((" .. string.sub(item["short"], 0, 1) .. "|" .. first_capitalized .. ")" .. rest_string .. ")(?! chaosu)(\\W|$)"
    end

    table.insert(self.color_triggers, tempRegexTrigger(regex, function() scripts.people:process_person_color( item["_row_id"], matches[3] ) end))
    scripts.people.color_items[item["_row_id"]] = { ["person"] = item }
end

function scripts.people:color_people_guild(guild_name, color)
    if not scripts.people.guilds[guild_name] then
        scripts:print_log("Nie ma takiej gildii: " .. guild_name .. ", sprawdz /gildie")
        return
    end

    local guild_code = scripts.people.guilds[guild_name]
    local results = db:fetch(scripts.people.db.people, db:eq(scripts.people.db.people.guild, guild_code))

    for k, item in pairs(results) do
        if not scripts.people.enemy_table[item["_row_id"]] then
            scripts.people:color_person_build(item, color)
        end
    end
end

function scripts.people:color_people_starter()
    for _, id in pairs(scripts.people.color_triggers) do
        killTrigger(id)
    end

    scripts.people.color_triggers = {}
    scripts.people.color_items = {}
    scripts.people.color_table = {}
    scripts.people.color_people = {}
    scripts.people.color_suffix = {}

    for k, v in pairs(scripts.people.colored_people) do
        local results = db:fetch(scripts.people.db.people, db:eq(scripts.people.db.people.name, k))
        if not table.is_empty(results) then
            for id, item in pairs(results) do
                if not scripts.people.enemy_table[item["_row_id"]] then
                    scripts.people:color_person_build(item, v)
                end
            end
        else 
            table.insert(scripts.people.color_triggers, tempRegexTrigger("(?i)(" .. k .. ")", function()
                selectCaptureGroup(2)
                fg(v)
                resetFormat()
            end ))
        end
    end

    for k, v in pairs(scripts.people.colored_guilds) do
        scripts.people:color_people_guild(k, v)
    end
end

