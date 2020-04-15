function mapper_on()
    addMapEvent("ustaw te lokacje", "setThisLocation")
end

if scripts.event_handlers["mapper/events/mapper_on.mapOpenEvent.mapper_on"] then
    killAnonymousEventHandler(scripts.event_handlers["mapper/events/mapper_on.mapOpenEvent.mapper_on"])
end

scripts.event_handlers["mapper/events/mapper_on.mapOpenEvent.mapper_on"] = registerAnonymousEventHandler("mapOpenEvent", mapper_on)

