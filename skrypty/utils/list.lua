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