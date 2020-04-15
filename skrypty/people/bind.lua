function scripts.people:process_enemy_name(text)
    -- it selects the text first, then adds 'wrog' string
    -- and then color the entire string with red
    local to_select_string = text

    if scripts.people.enemy_suffix[string.lower(text)] then
        to_select_string = to_select_string .. " (" .. scripts.people.enemy_suffix[string.lower(text)] .. ")"
        selectString(text, 1)
        replace(to_select_string)
    end

    selectString(to_select_string, 1)
    fg("red")
    resetFormat()
end

function scripts.people:enemy_person_build(item)
    local first_capitalized = string.upper(string.sub(item["short"], 0, 1))
    local guild_str = scripts.people:get_guild_name(item["guild"])

    -- it gets the rest of the string (without the first letter)
    local rest_string = string.sub(item["short"], 2, #item["short"])

    -- finally, it constructs the regex
    local regex = nil
    scripts.people.enemy_table[item["_row_id"]] = true

    local norm_short = string.lower(item["short"])

    if norm_short ~= "" then
        if item["name"] ~= "" then
            scripts.people.enemy_suffix[norm_short] = item["name"]
        end

        if guild_str then
            if scripts.people.enemy_suffix[norm_short] then
                scripts.people.enemy_suffix[norm_short] = scripts.people.enemy_suffix[norm_short] .. " " .. guild_str
            end
        end
    end

    if item["name"] ~= "" then
        scripts.people.enemy_suffix[item["name"]] = ""
        if not scripts.people.enemy_suffix[string.lower(item["name"])] then
            regex = "(^|\\W)((" .. string.sub(item["short"], 0, 1) .. "|" .. first_capitalized .. ")" .. rest_string .. "|" .. item["name"] .. ")(\\W|$)"
        else
            regex = "(^|\\W)((" .. string.sub(item["short"], 0, 1) .. "|" .. first_capitalized .. ")" .. rest_string .. ")(\\W|$)"
        end
    else
        regex = "(^|\\W)((" .. string.sub(item["short"], 0, 1) .. "|" .. first_capitalized .. ")" .. rest_string .. ")(\\W|$)"
    end

    local id = tempRegexTrigger(regex, "scripts.people:process_enemy_name(matches[3])")
    scripts.people.enemy_table[item["_row_id"]] = { ["trigger_id"] = id, ["person"] = item }
end

function scripts.people:enemy_people_guild(guild_name)
    if not scripts.people.guilds[guild_name] then
        scripts:print_log("Nie ma takiej gildii: " .. guild_name .. ", sprawdz /gildie")
        return
    end

    local guild_code = scripts.people.guilds[guild_name]
    local results = db:fetch(scripts.people.db.people, db:eq(scripts.people.db.people.guild, guild_code))

    for k, item in pairs(results) do
        scripts.people:enemy_person_build(item)
    end
end

function scripts.people:enemy_people_starter()
    for k, v in pairs(scripts.people.enemy_table) do
        killTrigger(v["trigger_id"])
    end

    scripts.people.enemy_table = {}
    scripts.people.enemy_suffix = {}

    for k, v in pairs(scripts.people.enemy_people) do
        local results = db:fetch(scripts.people.db.people, db:like(scripts.people.db.people.name, v))

        for id, item in pairs(results) do
            scripts.people:enemy_person_build(item)
        end
    end

    for k, v in pairs(scripts.people.enemy_guilds) do
        scripts.people:enemy_people_guild(v)
    end
end

