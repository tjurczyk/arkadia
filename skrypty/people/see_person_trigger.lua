function see_person_trigger()
    if not scripts.people["showing_names"] then
        return
    end

    for k, v in pairs(gmcp.objects.data) do
        if v["desc"] then
            if table.size(string.split(v["desc"], " ")) > 1 then
                -- only if desc is not a name
                if not scripts.people.people_triggers[v["desc"]] and not scripts.people.enemy_suffix[v["desc"]] and
                        not scripts.people.color_suffix[v["desc"]] and not scripts.people.trigger_suffix[v["desc"]] then
                    -- create a trigger iff the one with this desc doesn't exist
                    local results = db:fetch(scripts.people.db.people, db:like(scripts.people.db.people.short, "%" .. v["desc"] .. "%"))

                    if table.size(results) == 1 then
                        -- only if the return list was a single item

                        local item = results[1]

                        -- it gets the first letter from the short
                        local first_capitalized = string.upper(string.sub(item["short"], 0, 1))

                        -- it gets the rest of the string (without the first letter)
                        local rest_string = string.sub(item["short"], 2, #item["short"])

                        -- finally, it constructs the regex
                        local regex = nil
                        regex = "(^|\\W)((" .. string.sub(item["short"], 0, 1) .. "|" .. first_capitalized .. ")" .. rest_string .. ")(\\W|$)"
                        --echo ("regex: " .. tostring(regex) .. "\n")
                        local trigger_id = tempRegexTrigger(regex, "scripts.people:process_trigger_name(matches[3])")
                        scripts.people.people_triggers[v["desc"]] = trigger_id
                        scripts.people.people_triggers_objects[trigger_id] = item
                    end
                end
            end
        end
    end
end

function scripts.people:process_trigger_name(short)
    selectString(short, 1)
    local add_text = ""

    local obj = scripts.people.people_triggers_objects[scripts.people.people_triggers[string.lower(short)]]
    local guild_name = scripts.people:get_guild_name(obj["guild"])

    if obj["name"] ~= "" and guild_name then
        add_text = obj["name"] .. ", " .. guild_name
    elseif obj["name"] ~= "" then
        add_text = obj["name"]
    elseif guild_name then
        add_text = guild_name
    end

    local r, g, b = getFgColor()

    replace(short .. " (" .. add_text .. ")")

    selectString(short, 1)
    setFgColor(r, g, b)

    if obj["name"] ~= "" then
        selectString(obj["name"], 1)
        fg(scripts.people.name_color)
    end

    if guild_name then
        selectString(guild_name, 1)
        fg(scripts.people.guild_color)
    end
    resetFormat()
end

if scripts.event_handlers["skrypty/people/see_person_trigger.gmcp.objects.data.see_person_trigger"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/people/see_person_trigger.gmcp.objects.data.see_person_trigger"])
end

scripts.event_handlers["skrypty/people/see_person_trigger.gmcp.objects.data.see_person_trigger"] = registerAnonymousEventHandler("gmcp.objects.data", see_person_trigger)

