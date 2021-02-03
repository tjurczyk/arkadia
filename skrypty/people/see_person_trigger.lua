function see_person_trigger()
    if not scripts.people["showing_names"] then
        return
    end

    for k, v in pairs(gmcp.objects.data) do
        if v["desc"] then
            if table.size(string.split(v["desc"], " ")) > 1 then
                -- only if desc is not a name
                if not scripts.people.already_processed_desc[v["desc"]] then
                    -- create a trigger iff the one with this desc doesn't exist
                    local results = db:fetch(scripts.people.db.people, db:like(scripts.people.db.people.short, "%" .. v["desc"] .. "%"))

                    if table.size(results) == 1 then
                        scripts.people:color_person_build(results[1], scripts.people.name_color, scripts.people.guild_color)
                    end
                end
            end
        end
    end
end

if scripts.event_handlers["skrypty/people/see_person_trigger.gmcp.objects.data.see_person_trigger"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/people/see_person_trigger.gmcp.objects.data.see_person_trigger"])
end

scripts.event_handlers["skrypty/people/see_person_trigger.gmcp.objects.data.see_person_trigger"] = registerAnonymousEventHandler("gmcp.objects.data", see_person_trigger)

