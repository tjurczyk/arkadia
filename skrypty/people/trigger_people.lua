function scripts.people:process_person_trigger(text)
    local to_select_string = text
    local r, g, b

    if scripts.people.trigger_suffix[string.lower(text)] then
        to_select_string = to_select_string .. " (" .. scripts.people.trigger_suffix[string.lower(text)] .. ")"
        selectString(text, 1)
        r, g, b = getFgColor()
        fg(scripts.people.name_color)
        replace(to_select_string)
    end

    selectString(text, 1)
    setFgColor(r, g, b)
    resetFormat()
end

function scripts.people:trigger_person_build(item, color)
    if item["name"] == "" then
        return
    end

    local first_capitalized = string.upper(string.sub(item["short"], 0, 1))
    local guild_str = scripts.people:get_guild_name(item["guild"])

    -- it gets the rest of the string (without the first letter)
    local rest_string = string.sub(item["short"], 2, #item["short"])

    -- finally, it constructs the regex
    local regex = nil

    local norm_short = string.lower(item["short"])
    local first_entry = false

    if not scripts.people.trigger_suffix[norm_short] then
        scripts.people.trigger_suffix[norm_short] = ""
    else
        scripts.people.trigger_suffix[norm_short] = scripts.people.trigger_suffix[norm_short] .. ", "
        first_entry = true
    end

    regex = "(^|\\W)((" .. string.sub(item["short"], 0, 1) .. "|" .. first_capitalized .. ")" .. rest_string .. ")(\\W|$)"
    scripts.people.trigger_suffix[norm_short] = scripts.people.trigger_suffix[norm_short] .. item["name"]

    if guild_str then
        scripts.people.trigger_suffix[norm_short] = scripts.people.trigger_suffix[norm_short] .. " " .. guild_str
    end

    local id = nil
    if not first_entry then
        id = tempRegexTrigger(regex, "scripts.people:process_person_trigger(matches[3])")
    end

    scripts.people.trigger_items[item["_row_id"]] = { ["trigger_id"] = id, ["person"] = item }
end

function scripts.people:trigger_people_guild(guild_name)
    if not scripts.people.guilds[guild_name] then
        return
    end

    local guild_code = scripts.people.guilds[guild_name]
    local results = db:fetch(scripts.people.db.people, db:eq(scripts.people.db.people.guild, guild_code))

    for k, item in pairs(results) do
        if not scripts.people.enemy_table[item["_row_id"]] and
                not scripts.people.color_items[item["_row_id"]] and
                not scripts.people.color_people[item["short"]] then
            scripts.people:trigger_person_build(item)
        end
    end
end

function scripts.people:trigger_people_starter()
    for k, v in pairs(scripts.people.trigger_items) do
        if v["trigger_id"] then
            killTrigger(v["trigger_id"])
        end
    end

    scripts.people.trigger_items = {}
    scripts.people.trigger_suffix = {}

    for k, v in pairs(scripts.people.trigger_guilds) do
        scripts.people:trigger_people_guild(v)
    end
end

