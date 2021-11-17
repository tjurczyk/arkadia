function scripts.people:process_person_color(text, name, guild, suffix, color, guild_color)
    if gmcp.gmcp_msgs and gmcp.gmcp_msgs.type == "room.short" then
        return
    end

    if text ~= name and suffix then
        local full_sufix = "(" .. suffix .. ")"
        local replacement = string.format("%s %s", text, full_sufix)
        selectString(text, 1)
        replace(replacement, true)
        selectString(full_sufix, 1)
        fg(color)
    end

    if not guild_color then
        selectString(text, 1)
        fg(color)
    else
        local i = 1
        while selectString(guild, i) > -1 do
            fg(guild_color)
            i = i + 1
        end
    end
    resetFormat()
end

function scripts.people:color_person_build(item, color, suffix_only)
    if item.short == "" or scripts.people.already_processed[item["_row_id"]] then
        return
    end

    local suffix

    local guild_str = scripts.people:get_guild_name(item["guild"])
    local norm_short = string.lower(item["short"])

    
    if norm_short ~= "" then
        if item["name"] ~= "" then
            suffix = item["name"]
        end

        if guild_str then
            if suffix then
                suffix = suffix .. " " .. guild_str
            end
        end
    end

    local items = item.short:lower():split(" ")
    if #items == 3 then
        local value = {
            short = item.short,
            name = item.name,
            guild = guild_str,
            suffix = suffix,
            color = color,
            suffix_only = suffix_only
        }
        self.tokens_table[items[1]] = self.tokens_table[items[1]] or {}
        self.tokens_table[items[1]][items[2]] = self.tokens_table[items[1]][items[2]] or {}
        self.tokens_table[items[1]][items[2]][items[3]] = self.tokens_table[items[1]][items[2]][items[3]] or {}
        self.tokens_table[items[1]][items[2]][items[3]][item.name] = value
        self.tokens_table[item.name] = value
    end

    scripts.people.already_processed[item["_row_id"]] = true
    scripts.people.already_processed_desc[item.short] = true
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

function scripts.people:starter()
    for _, id in pairs(scripts.people.color_triggers) do
        killTrigger(id)
    end

    scripts.people.color_triggers = {}
    scripts.people.already_processed = {}
    scripts.people.already_processed_desc = {}

    scripts.people:enemy_people_starter()
    scripts.people:color_people_starter()
    scripts.people:trigger_people_starter()

    raiseEvent("colorPeopleBuild")
end

function scripts.people:enemy_people_starter()

    scripts.people.bind_enemies = {}

    for _, v in pairs(scripts.people.enemy_people) do
        local results = db:fetch(scripts.people.db.people, db:like(scripts.people.db.people.name, v))

        for _, item in pairs(results) do
            scripts.people:enemy_person_build(item)
        end
    end

    for _, v in pairs(scripts.people.enemy_guilds) do
        scripts.people:enemy_people_guild(v)
    end    
end

function scripts.people:enemy_person_build(item)
    if item.name then
        scripts.people.bind_enemies[item.name] = true
    end
    if item.short then
        scripts.people.bind_enemies[item.short] = true
    end
    scripts.people:color_person_build(item, "red")
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

function scripts.people:color_people_starter()
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

function scripts.people:trigger_people_guild(guild_name)
    if not scripts.people.guilds[guild_name] then
        return
    end

    local guild_code = scripts.people.guilds[guild_name]
    local results = db:fetch(scripts.people.db.people, db:eq(scripts.people.db.people.guild, guild_code))

    for k, item in pairs(results) do
        scripts.people:color_person_build(item, scripts.people.name_color, scripts.people.guild_color)
    end
end

function scripts.people:trigger_people_starter()
    for k, v in pairs(scripts.people.trigger_guilds) do
        scripts.people:trigger_people_guild(v)
    end
end

function scripts.people:process_line(msg)
    local tokens = ansi2string(msg):gsub("%.", ""):gsub("[,!?-]", ""):gsub("\t", ""):gsub("\n", ""):split("[ /]")
    for i = 1, #tokens, 1 do
        if scripts.people.tokens_table[tokens[i]:lower()] and scripts.people.tokens_table[tokens[i]:lower()][tokens[i+1]] and scripts.people.tokens_table[tokens[i]:lower()][tokens[i+1]][tokens[i+2]]
            and tokens[i+3] ~= "chaosu" and (tokens[i+3] ~= "to" and tokens[i+4] ~= "chyba") then
            for k,v in pairs(scripts.people.tokens_table[tokens[i]:lower()][tokens[i+1]][tokens[i+2]]) do
                scripts.people:process_person_color(string.format("%s %s %s", tokens[i], tokens[i+1], tokens[i+2]), v.name,  v.guild, v.suffix, v.color, v.suffix_only)
            end
        end
        if scripts.people.tokens_table[tokens[i]] and scripts.people.tokens_table[tokens[i]].name then
            local item = scripts.people.tokens_table[tokens[i]]
            scripts.people:process_person_color(tokens[i], item.name, item.guild, item.suffix, item.color, item.suffix_only)
        end
    end
end

function trigger_func_people_process_line()
    scripts.people:process_line(line)
end