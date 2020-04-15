function amap:add_area(name)
    local new_id = addAreaName(name)

    if new_id == -1 then amap:print_log("Juz istnieje obszar o tej nazwie.\n")
    else amap:print_log("Utworzono obszar o nazwie '" .. name .. "' z id: " .. new_id .. ".\n")
    end

    return new_id
end

function amap:get_area_id(name)
    return getAreaTable()[name]
end

function amap:print_areas()
    if getAreaTable() then
        display(getAreaTable())
    else
        amap:print_log("Nie ma jeszcze zadnych obszarow")
    end
end
    

