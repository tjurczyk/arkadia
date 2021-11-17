function scripts.people:retrieve_person(name, short)
    local retrieved_people = nil

    if short then
        -- this is when it has the name and short
        retrieved_people = db:fetch(scripts.people.db.people, {
            db:eq(scripts.people.db.people.name, name),
            db:eq(scripts.people.db.people.short, short)
        })
    end

    if retrieved_people and table.size(retrieved_people) > 0 then
        -- if located some people with this name and short
        return retrieved_people
    end

    -- if previous action not possible/not successful, try to located by name
    retrieved_people = db:fetch(scripts.people.db.people, db:eq(scripts.people.db.people.name, name))

    return retrieved_people
end

function scripts.people:retrieve_person_by_id(id)
    local retrieved_people = nil

    local sql_str = "SELECT * FROM people where _row_id = " .. tostring(id)

    return db:fetch_sql(scripts.people.db.people, sql_str)
end

function scripts.people:retrieve_person_by_name(name)
    local retrieved_people = nil

    local sql_str = 'SELECT * FROM people WHERE name = "' .. string.title(name) .. '"'
    return db:fetch_sql(scripts.people.db.people, sql_str)
end

function scripts.people:check_in_db(name, short)
    local retrieved_people = nil

    local sql_str = 'SELECT * FROM people WHERE name ="' .. string.title(name) .. '" AND short = "' .. string.lower(short) .. '"'
    return db:fetch_sql(scripts.people.db.people, sql_str)
end

function scripts.people:get_last_id()
    local sql_str = "SELECT * FROM people ORDER BY _row_id DESC LIMIT 1"
    return db:fetch_sql(scripts.people.db.people, sql_str)[1]["_row_id"]
end

local ranks = {
    "Kapitan",
    "Sierzant",
    "'Krotki'",
    "Kapral",
    "'Profesor' vel ",
    "Seniore"
}

function scripts.people:strip_ranks(name)
    for _, rank in pairs(ranks) do
        name = name:gsub("^" .. rank, ""):trim()
    end
    return name
end

function scripts.people:process_trigger_data(short, title)
    --
    -- returns two values: name and short
    -- always returns name, short only if exists

    if table.size(string.split(short, " ")) == 1 then
        -- this is when "Adremen przedstawia sie jako", "Adremen" is the `short'
        -- name is then
        return short, nil
    else
        title = scripts.people:strip_ranks(title)
        -- this is when "Siwy siwobrody mezczyzna przedstawia sie jako:"
        -- then get the name from title (first word separated by space)
        local ret_name = string.split(title, " ")[1]

        if string.sub(ret_name, #ret_name) == "," or string.sub(ret_name, #ret_name) == "." then
            -- check if the last character is not dot or not comma. If so, remove it
            ret_name = string.sub(ret_name, 0, #ret_name - 1)
        end
        return ret_name, string.lower(short)
    end
end

function scripts.people:delete_person(id)
    if not id then
        error("Wrong input")
    end

    return db:delete(scripts.people.db.people, id)
end

function scripts.people:add_person(name, short, title)
    if not name or not short then
        error("Wrong input")
    end

    local date = getTime(true, "dd/MM/yyyy hh:mm:ss")
    local room_id = -1

    if amap and amap.curr.id then
        room_id = amap.curr.id
    end

    if title then
        return db:add(scripts.people.db.people, { name = name, short = short, room_id = room_id, updated = date, title = title })
    else
        return db:add(scripts.people.db.people, { name = name, short = short, room_id = room_id, updated = date, })
    end
end

function scripts.people:update_person(person)
    if not person then
        error("Wrong input")
    end

    person["updated"] = getTime(true, "dd/MM/yyyy hh:mm:ss")
    if amap and amap.curr.id then
        person["room_id"] = amap.curr.id
    end

    return db:update(scripts.people.db.people, person)
end

