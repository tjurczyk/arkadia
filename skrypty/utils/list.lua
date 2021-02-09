--------------------------
-- Below is the support for queue
--------------------------
function scripts.utils.get_new_list()
    return { first = 0, last = -1 }
end

scripts.utils.List = {}
function scripts.utils.List.new()
    return { first = 0, last = -1 }
end

function scripts.utils.List.push(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end

function scripts.utils.List.pop(list)
    local first = list.first
    if first > list.last then
        return nil
    end
    local value = list[first]
    list[first] = nil -- to allow garbage collection
    list.first = first + 1
    return value
end

--[[
Ordered table iterator, allow to iterate on the natural order of the keys of a
table.

Taken from: http://lua-users.org/wiki/SortedIteration
]]

local function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex )
    return orderedIndex
end

local function orderedNext(t, state)
    -- Equivalent of the next function, but returns the keys in the alphabetic
    -- order. We use a temporary ordered key table that is stored in the
    -- table being iterated.

    local key = nil
    --print("orderedNext: state = "..tostring(state) )
    if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
    else
        -- fetch the next value
        for i = 1,table.getn(t.__orderedIndex) do
            if t.__orderedIndex[i] == state then
                key = t.__orderedIndex[i+1]
            end
        end
    end

    if key then
        return key, t[key]
    end

    -- no more value to return, cleanup
    t.__orderedIndex = nil
    return
end

function scripts.utils.List.orderedPairs(t)
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end