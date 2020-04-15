function split(str, sep)
    local result = {}
    local regex = ("([^%s]+)"):format(sep)
    for each in str:gmatch(regex) do
        table.insert(result, each)
    end
    return result
end

table.reduce = function(list, fn)
    local acc
    for k, v in ipairs(list) do
        if 1 == k then
            acc = v
        else
            acc = fn(acc, v)
        end
    end
    return acc
end

table.sum = function(t)
    return table.reduce(t,
        function(a, b)
            return a + b
        end)
end

function chunk(t, size)
    local out = {}
    for i = 1, #t, size do
        local row = {}
        for j = 0, size - 1 do
            table.insert(row, t[i + j])
        end
        table.insert(out, row)
    end
    return out
end


