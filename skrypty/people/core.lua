function scripts.people:print(results)
    if scripts.ui.results_window.enabled then
        scripts.ui.results_window:print(results)
    else
        scripts:print_log(results)
    end
end

function scripts.people:process_someone(short, name)
    if not name or not short then
        error("Wrong input")
    end

    if scripts.people["updating_names"] then
        tempTimer(math.random() * 0.4, function() scripts.people:process_someone_delay(short, name) end)
    end


    local title = name
    title = title:gsub(" ", "_")

    name = scripts.people:strip_ranks(name)

    local name_short = short
    name_short = name_short:gsub(" ", "_")

    local host = getConnectionInfo()
    if host ~= "arkadia.rpg.pl" then
        return
    end

    echo("http://51.38.32.53/cgi-bin/people_listener.py?people_string=" .. name_short .. "!" .. title)
    getHTTP("http://51.38.32.53/cgi-bin/people_listener.py?people_string=" .. name_short .. "!" .. title)
end

function scripts.people:process_someone_delay(short, title)
    local name = nil
    local lowered_short = nil

    name, lowered_short = scripts.people:process_trigger_data(short, title)

    local retrieved_objs = scripts.people:retrieve_person(name, lowered_short)
    --display(retrieved_objs)
    local ret = nil

    if table.size(retrieved_objs) == 0 and lowered_short then
        -- nobody located and it has the short (Siwy siwobrody mezczyzna), so a new object
        if scripts.people:add_person(name, lowered_short, title) then
            local new_id = scripts.people:get_last_id()
            ret = "Zapisalem imie <green>" .. name .. "<tomato> z id <green>" .. new_id .. "<tomato> w bazie"
        end
    elseif table.size(retrieved_objs) == 1 then
        -- there is when a single object is retrieved from the db, check it and update if necessary
        if lowered_short and retrieved_objs[1]["short"] ~= lowered_short then
            -- add another object with this name if short is different
            if scripts.people:add_person(name, lowered_short, title) then
                local new_id = scripts.people:get_last_id()
                ret = "Zapisalem imie <green>" .. name .. "<tomato> z id <green>" .. new_id .. "<tomato> w bazie"
            end
        else
            -- single object with this name in db, update it
            retrieved_objs[1]["title"] = title
            if scripts.people:update_person(retrieved_objs[1]) then
                ret = "Znam postac o imieniu <green>" .. retrieved_objs[1]["name"] .. "<tomato>, aktualizuje titla"
            else
                ret = "Znam ta postac i probowalem zaktualizowac title, ale cos poszlo nie tak"
            end
        end
    elseif table.size(retrieved_objs) > 1 then
        -- multiple hits in the db, tell the user about it
        ret = "Znalazlem wiecej niz jeden wpis w bazie dla tej osoby, nie robie nic"
    elseif not lowered_short then
        -- if don't have the short nor user in the db, there is no person such that in thhe db
        ret = "Nie mam tej osoby w bazie"
    else
        -- unsupported case, just tell the user about it
        ret = "Nie wiem co zrobic w bazie, nie obsluguje tej sytuacji"
    end

    if not ret then
        scripts:print_log("Cos poszlo nie tak z baza postaci")
    else
        scripts:print_log(ret)
    end
end

function scripts.people:print_id_details(id)
    if not id then
        error("Wrong input")
    end

    local person = scripts.people:retrieve_person_by_id(id)
    if #person == 0 then
        scripts:print_log("Nie ma osoby o takim ID")
        return
    end
    person = person[1]

    self:print(scripts.people:print_person(person, true))
end

function scripts.people:search(short)
    if not short then
        error("Wrong input")
    end

    local results = db:fetch(scripts.people.db.people, db:like(scripts.people.db.people.short, "%" .. short .. "%"))

    if table.size(results) > 0 then
        local str_print = "Znalazlem:\n"
        for k, v in pairs(results) do
            str_print = str_print .. scripts.people:print_person(v)
        end
        self:print(str_print)
    else
        scripts:print_log("Nic nie znalazlem")
    end
end

function scripts.people:print_guilded(guild_name)
    if not guild_name then
        error("Wrong input")
    end

    local guild_code = nil
    if scripts.people["guilds"][guild_name] then
        guild_code = scripts.people["guilds"][guild_name]
    else
        scripts:print_log("Nie ma takiej gildii, sprawdz '/gildie'")
        return
    end


    local results = db:fetch(scripts.people.db.people, db:eq(scripts.people.db.people.guild, guild_code))

    if table.size(results) > 0 then
        local str_print = "Znalazlem:\n"
        for k, v in pairs(results) do
            str_print = str_print .. scripts.people:print_person(v)
        end
        self:print(str_print)
    else
        scripts:print_log("Nie ma osob przypisanych do tej gildii")
    end
end

function scripts.people:print_person(person, long)
    if not person then
        error("Wrong input")
    end

    local str_name = "\n <yellow>(" .. tostring(person["_row_id"]) .. ") <green>" .. person["name"] .. " "
    if person["guild"] ~= 0 then
        str_name = str_name .. "<dark_orange>(" .. scripts.people:get_guild_name(person["guild"]) .. ")\n"
    else
        str_name = str_name .. "\n"
    end

    str_name = str_name .. "<grey>      <yellow>" .. person["short"] .. "\n"

    if person["title"] ~= "" then
        str_name = str_name .. "<grey>      <dark_orange>" .. person["title"] .. "<grey>\n"
    end

    if long then
        str_name = str_name .. "<grey>      <OliveDrab>" .. person["updated"] .. "<grey>\n"

        if person["note"] ~= "" then
            str_name = str_name .. "<grey>      " .. person["note"] .. "\n"
        end

        if person["room_id"] ~= -1 then
            str_name = str_name .. "      Lokacja: " .. tostring(person["room_id"]) .. "\n"
        end
    end

    return str_name
end

function scripts.people:search_hard(phrase)
    if not phrase then
        error("Wrong input")
    end

    local results = db:fetch(scripts.people.db.people, db:like(scripts.people.db.people.title, "%" .. phrase .. "%"))

    if table.size(results) > 0 then
        local str_print = "Znalazlem:\n"
        for k, v in pairs(results) do
            str_print = str_print .. scripts.people:print_person(v)
        end
        self:print(str_print)
    else
        scripts:print_log("Nic nie znalazlem")
    end
end

function scripts.people:search_name(name)
    if not name then
        error("Wrong input")
    end

    local search_name = string.upper(string.sub(name, 0, 1)) .. string.sub(name, 2)
    local results = db:fetch(scripts.people.db.people, db:eq(scripts.people.db.people.name, search_name))

    if table.size(results) > 0 then
        local str_print = "Znalazlem:\n"
        for k, v in pairs(results) do
            str_print = str_print .. scripts.people:print_person(v, true)
        end
        self:print(str_print)
    else
        scripts:print_log("Nic nie znalazlem")
    end
end

function scripts.people:add_person_to_db(input_string, guild)
    if not input_string then
        error("Wrong input")
    end

    local arg_split = string.split(input_string, "#")
    if #arg_split < 2 then
        scripts:print_log("Co najmniej dwa argumenty potrzebne")
        return
    end

    local ret = nil
    local name = string.title(arg_split[1])
    local short = string.lower(arg_split[2])
    local result = scripts.people:check_in_db(name, short)
    if table.size(result) > 0 then
        scripts:print_log("Postac o tym imieniu i opisie juz jest w bazie!")
        return
    end

    if #arg_split == 2 then
        ret = scripts.people:add_person(name, short, nil)
    elseif #arg_split == 3 then
        ret = scripts.people:add_person(name, short, arg_split[3])
    end

    if ret then
        local added = scripts.people:check_in_db(name, short)[1]
        if guild then
            scripts.people:add_person_to_guild(added["_row_id"], guild)
        end
        scripts:print_log("Postac <green>" .. name .. " (" .. added["_row_id"] .. ")<tomato> dodana do bazy.")
    else
        scripts:print_log("Cos poszlo nie tak...")
    end
end

function scripts.people:remove_person_from_db(id)
    if not id then
        error("Wrong input")
    end

    local person = scripts.people:retrieve_person_by_id(id)
    if #person == 0 then
        scripts:print_log("Nie ma osoby o takim ID")
        return
    end

    if scripts.people:delete_person(id) then
        scripts:print_log("Osoba usunieta")
    else
        scripts:print_log("Cos poszlo nie tak...")
    end
end

function scripts.people:add_person_to_guild(id, guild_name)
    if not guild_name then
        error("Wrong input")
    end

    local person = nil
    if tonumber(id) then
        person = scripts.people:retrieve_person_by_id(id)
    else
        person = scripts.people:retrieve_person_by_name(id)
    end

    if table.is_empty(person) then
        scripts:print_log("Nie ma osoby o takim imieniu w bazie.")
        return
    end

    local guild_code = nil

    if scripts.people["guilds"][guild_name] or guild_name == 0 then
        guild_code = scripts.people["guilds"][guild_name]
    else
        scripts:print_log("Nierozpoznana gildia!")
        return
    end

    if guild_name == 0 then
        for k, v in pairs(person) do
            v["guild"] = 0
            if scripts.people:update_person(v) then
                scripts:print_log("Usunieta gildia postaci o imieniu <green>" ..
                    v.name .. "<tomato> i opisie: <green>" .. v.short .. "<tomato>.")
            else
                scripts:print_log("Cos poszlo nie tak...")
            end
        end
    else
        for k, v in pairs(person) do
            v["guild"] = guild_code
            if scripts.people:update_person(v) then
                scripts:print_log("Dodana gildia <green>" ..
                    guild_name ..
                    "<tomato> do postaci o imieniu <green>" ..
                    v.name .. "<tomato> i opisie: <green>" .. v.short .. "<tomato>.")
            else
                scripts:print_log("Cos poszlo nie tak...")
            end
        end
    end
end

function scripts.people:modify_person(id, key, val)
    if not id or not key or not val then
        error("Wrong input")
    end

    if key ~= "imie" and key ~= "short" and key ~= "title" then
        scripts:print_log("Zla opcja, uzyj: 'imie', 'short' albo 'title'")
        return
    end

    local person = scripts.people:retrieve_person_by_id(id)
    if #person == 0 then
        scripts:print_log("Nie ma osoby o takim ID")
        return
    end
    person = person[1]

    local ret = nil

    if key == "imie" then
        person["name"] = val
    elseif key == "short" then
        person["short"] = val
    elseif key == "title" then
        person["title"] = val
    end

    if scripts.people:update_person(person) then
        ret = "<green>" .. key .. "<tomato> osoby o id<green> " .. tostring(id) .. "<tomato> zaktualizowane"
    else
        ret = "Cos poszlo nie tak..."
    end

    scripts:print_log(ret)
end

function scripts.people:add_to_binds_guild(guild_name)
    if not guild_name then
        error("Wrong input")
    end

    local guild_code = nil
    if scripts.people["guilds"][guild_name] then
        guild_code = scripts.people["guilds"][guild_name]
    else
        scripts:print_log("Nie znam takiej gildii, sprawdz '/gildie'")
        return
    end

    local results = db:fetch(scripts.people.db.people, db:eq(scripts.people.db.people.guild, guild_code))

    for k, v in pairs(results) do
        v["enemy"] = (v["enemy"] + 1) % 2

        local msg = "Ok, "
        if v["enemy"] == 0 then
            msg = msg .. "osoba <green>" .. tostring(v["_row_id"]) .. " (" .. v["name"] .. ") usunieta <tomato>z wrogow"
        else
            msg = msg .. "osoba <green>" .. tostring(v["_row_id"]) .. " (" .. v["name"] .. ")<tomato> dodana do wrogow"
        end
        scripts:print_log(msg)

        if not scripts.people:update_person(v) then
            scripts:print_log("Cos poszlo nie tak z baza postaci...")
            return nil
        end
    end

    scripts:print_log("Zaktualizowalem: <green>" .. tostring(table.size(results)) .. " <tomato>wpisow postaci w bazie")
    tempTimer(0.2, function() scripts.people:add_start_binds() end)
end

function scripts.people.go_to_person_location(id, delay)
    if not id then
        error("Wrong input")
    end

    local person = scripts.people:retrieve_person_by_id(id)
    if #person == 0 then
        scripts:print_log("Nie ma osoby o takim id")
        return
    end
    person = person[1]

    if not person["room_id"] or person["room_id"] == -1 then
        scripts:print_log("Ta osoba nie ma zapisanej lokacji")
        return
    else
        if delay then
            amap.walker_delay = delay
        end
        amap.go_to_room_mail = person["room_id"]
        amap:go_to_mail()
    end
end
