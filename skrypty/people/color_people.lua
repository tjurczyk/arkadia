function scripts.people:process_person_color(text, name, guild, color, suffix_color)
    if gmcp.gmcp_msgs and gmcp.gmcp_msgs.type == "room.short" then
        return
    end
    local selectedText, offset, len = getSelection()
    if name and text:lower():title() ~= name:lower():title() then
        local sub = text
        if not suffix_color then
            sub = string.format("<%s>%s<reset>", color, sub)
            creplace(sub)
        end
        moveCursor(offset + len, getLineNumber())
        cinsertText(string.format(" <%s>(%s <%s>%s<%s>)<reset>", color, name, suffix_color or color, guild, color))
    elseif not suffix_color then
        fg(color)
    end
    resetFormat()
end

function scripts.people:color_person_build(item, color, guild_color)
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

    scripts.tokens:register(item.short, function(current_match)
        scripts.tokens:process_token(current_match, function()
            local name = not line:find(" %(to chyba") and item.name
            scripts.people:process_person_color(current_match, name, guild_str, color, guild_color)
        end, function(what, k) return not line:find(what .. " chaosu", k) end)
    end, "people" .. (item.name or ""))
   
    if item.name and item.name ~= "" then
        scripts.tokens:register(item.name, function(current_match)
            if current_match:sub(1, 1) == item.name:sub(1,1) then
                scripts.tokens:process_token(current_match, function()
                    scripts.people:process_person_color(current_match, item.name, guild_str, color, guild_color)
                end)
            end
        end, "people" ..item.name .. tostring(color))
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
    scripts.people:color_person_build(item, scripts.people.enemy_color)
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
            scripts.tokens:register(k, function(match)
                if selectString(match, 1) > -1 then
                    fg(v)
                    resetFormat()
                end
            end )
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



function trigger_func_people_process_line()
    scripts.tokens:process_line(line)
end