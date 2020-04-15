scripts.people.last_seen = {}

function scripts.people:remove_from_last_seen(short)
    scripts.people.last_seen[short] = nil
end

function scripts.people:print_last_seen()
    local people_str = "Ostatnio widzialem: "
    local found = 0
    for k, v in pairs(scripts.people.last_seen) do
        local results = nil
        if table.size(string.split(k, " ")) > 1 then
            results = db:fetch(scripts.people.db.people, db:like(scripts.people.db.people.short, "%" .. k .. "%"))
        else
            results = db:fetch(scripts.people.db.people, db:eq(scripts.people.db.people.name, k))
        end

        found = found + table.size(results)
        for i, j in pairs(results) do
            people_str = people_str .. scripts.people:print_person(j)
        end
    end

    if found > 0 then
        scripts:print_log(people_str)
    else
        scripts:print_log("Nie widzialem ostatnio nikogo, kogo mialbym w bazie")
    end
end

