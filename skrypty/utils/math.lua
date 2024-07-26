function scripts.utils:to_copper(mithryl, gold, silver, copper)
    if not copper then
        copper = 0
    end
    return copper + (silver * 12) + (gold * 20 * 12) + (mithryl * 100 * 20 * 12)
end
