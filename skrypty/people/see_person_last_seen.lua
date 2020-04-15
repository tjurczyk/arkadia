function see_person_last_seen()
    for k, v in pairs(gmcp.objects.data) do
        if v["desc"] then
            scripts.people.last_seen[v["desc"]] = true
            tempTimer(math.random(25, 45), function() scripts.people:remove_from_last_seen(v["desc"]) end)
        end
    end
end

if scripts.event_handlers["skrypty/people/see_person_last_seen.gmcp.objects.data.see_person_last_seen"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/people/see_person_last_seen.gmcp.objects.data.see_person_last_seen"])
end

scripts.event_handlers["skrypty/people/see_person_last_seen.gmcp.objects.data.see_person_last_seen"] = registerAnonymousEventHandler("gmcp.objects.data", see_person_last_seen)

