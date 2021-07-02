function math_round(x)
    if x % 2 ~= 0.5 then
        return math.floor(x + 0.5)
    end
    return x - 0.5
end

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function amap:get_new_coords(x, y, z, dir)
    local new_x = x
    local new_y = y
    local new_z = z
    local short_dir = amap.long_to_short[dir]

    if short_dir == "s" then
        -- south
        new_y = new_y + amap.options["skok_y"]
    elseif short_dir == "n" then
        -- north
        new_y = new_y - amap.options["skok_y"]
    elseif short_dir == "e" then
        -- east
        new_x = new_x + amap.options["skok_x"]
    elseif short_dir == "w" then
        -- west
        new_x = new_x - amap.options["skok_x"]
    elseif short_dir == "nw" then
        -- northwest
        new_x = new_x - amap.options["skok_x"]
        new_y = new_y - amap.options["skok_y"]
    elseif short_dir == "ne" then
        -- northeast
        new_x = new_x + amap.options["skok_x"]
        new_y = new_y - amap.options["skok_y"]
    elseif short_dir == "sw" then
        -- southwest
        new_x = new_x - amap.options["skok_x"]
        new_y = new_y + amap.options["skok_y"]
    elseif short_dir == "se" then
        -- southeast
        new_x = new_x + amap.options["skok_x"]
        new_y = new_y + amap.options["skok_y"]
    elseif short_dir == "d" then
        -- down
        new_z = new_z - 1
    elseif short_dir == "u" then
        -- up
        new_z = new_z + 1
    end

    return new_x, new_y, new_z
end

function amap:parse_exits(exits)
    local p_exits = {}

    for k, v in pairs(exits) do
        if amap.polish_to_english[v] then
            p_exits[k - 1] = amap.exitmap[amap.polish_to_english[v]]
        end
    end

    return p_exits
end

function amap:stub_list_contains_code(list, code)
    if list and code then
        for k, v in pairs(list) do
            if v == code then
                return true
            end
        end
        return false
    end
    return false
end

function amap:retrieve_dir()
    return amap.dir_from_key
end

function amap:retrieve_dir_follow()
    if amap.dir_from_key then
        return amap.dir_from_key
    else
        return nil
    end
end

function amap:copy_loc(dst, src)
    if dst then
        if src then
            dst.id = src.id
            dst.x = src.x
            dst.y = src.y
            dst.z = src.z
            dst.area = src.area
            dst.exits = src.exits
        else
            dst.id = nil
            dst.x = nil
            dst.y = nil
            dst.z = 0
            dst.area = nil
            dst.exits = nil
        end
    end
end



function copy_table(obj)
    local s = {}
    for k, v in pairs(obj) do
        s[k] = v
    end
    return s
end



function amap:show_colors()
    display(amap.color_table)
end

function amap:sp_safety_check()
    if amap.draw == "gmcp" or amap.draw == "manual" then
        amap:print_log("Nie uzywaj sp/spojrz w rysowaniu")
    else
        send("sp", false)
    end
end

function amap:try_locating_on_name(name)
    if amap.locating["name"] and name == amap.locating["name"] then
        amap:print_log("Ok, jestes zlokalizowany po lokacji startowej imienia", true)
        amap:set_position(amap.locating["loc_id"])
        amap.locating_name = nil
    end
end

function amap:trim_sneaky(comm)
    if not comm then
        return
    end

    if string.starts(comm, "przemknij sie z druzyna ") then
        return string.sub(comm, 25)
    elseif string.starts(comm, "przemknij sie ") then
        return string.sub(comm, 15)
    elseif string.starts(comm, "przemknij z druzyna ") then
        return string.sub(comm, 21)
    elseif string.starts(comm, "przemknij ") then
        echo("Caught")
        return string.sub(comm, 11)
    else
        return comm
    end
end

function amap:print_welcome_msg()
    amap:print_log("Uzywasz Arkadia Mapper ver. " .. amap.ver .. ". Pomoc dostepna w '/mapper'")
end

tempTimer(10, function() amap:print_welcome_msg() end)

function amap:set_option(option, value)
    local success = true
    if option == "skok_x" then
        amap.options["skok_x"] = tonumber(value)
    elseif option == "skok_y" then
        amap.options["skok_y"] = tonumber(value)
    elseif option == "laczenie_stubow" then
        amap.options["laczenie_stubow"] = tonumber(value)
    else
        amap:print_log("Nie ma takiej opcji")
        success = false
    end

    if success == true then
        amap:print_log("Ustawilem opcje '" .. option .. "' na wartosc: " .. value)
    end
end

function amap:print_options_values()
    display(amap.options)
end

function amap:print_log(msg, new_line)
    if msg then
        if new_line then
            cecho("\n<CadetBlue>(mapper)<tomato>: " .. msg .. "\n")
        else
            cecho("<CadetBlue>(mapper)<tomato>: " .. msg .. "\n")
        end
    end
end

function amap:parse_trigger_exits(text)
    local sep = string.split(text, ", ")
    local dirs = {}

    for k, v in pairs(sep) do
        local sep_last_i = string.split(v, " i ")
        local sep_last_lub = string.split(v, " lub ")
        local sep_last_oraz = string.split(v, " oraz ")
        local sep_last_albo = string.split(v, " albo na ")

        if #sep_last_i > 1 then
            for j, l in pairs(sep_last_i) do
                table.insert(dirs, l)
            end
        elseif #sep_last_lub > 1 then
            for j, l in pairs(sep_last_lub) do
                table.insert(dirs, l)
            end
        elseif #sep_last_oraz > 1 then
            for j, l in pairs(sep_last_oraz) do
                table.insert(dirs, l)
            end
        elseif #sep_last_albo > 1 then
            for j, l in pairs(sep_last_albo) do
                table.insert(dirs, l)
            end
        else
            table.insert(dirs, v)
        end
    end

    local final_dirs = {}
    for i, dir in pairs(dirs) do
        if amap.long_to_short[amap.polish_to_english[dir]] then
            final_dirs[amap.long_to_short[amap.polish_to_english[dir]]] = true
            --table.insert(final_dirs, amap.long_to_short[amap.polish_to_english[dir]])
        else
            final_dirs[dir] = true
            --table.insert(final_dirs, dir)
        end
    end

    return final_dirs
end

function amap:log_failed_follow(msg)
    local file = io.open(getMudletHomeDir() .. "/" .. "failed_follows_log.txt", "a+")
    io.output(file)
    io.write(msg)
    io.close(file)
end


--------------------------
-- Below is the support for queue
--------------------------
function get_new_list()
    return { first = 0, last = -1 }
end

List = {}
function List.new()
    return { first = 0, last = -1 }
end

function List.push(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end

function List.pop(list)
    local first = list.first
    if first > list.last then
        return nil
    end
    local value = list[first]
    list[first] = nil -- to allow garbage collection
    list.first = first + 1
    return value
end

function List.popright(list)
    local last = list.last
    if list.first > last then return nil end
    local value = list[last]
    list[last] = nil -- to allow garbage collection
    list.last = last - 1
    return value
end

function List.peek_last(list)
    local last = list.last
    if last < list.first then
        return nil
    end
    local value = list[last]
    return value
end

function List.peek_second_to_last(list)
    local last = list.last
    if last < list.first then
        return nil
    end
    local value = list[last - 1]
    return value
end

amap["history"] = get_new_list()

