function ard_buildColumnLengthTable(input, index)
    local lTable = {}
    for k, v in pairs(input) do
        table.insert(lTable, string.len(input[k][index]))
    end
    return lTable
end

function ard_getColumnLength(input, index)
    local lengths = ard_buildColumnLengthTable(input, index)
    local max = math.max(unpack(lengths))
    return max
end

function ard_calculatePad(str, max)
    return max - string.len(str)
end

function ard_prettyTable(input)
    local lengths = {}
    local output = ""
    for k, v in pairs(input[1]) do
        local l = ard_getColumnLength(input, k)
        table.insert(lengths, l)
    end

    for kk, vv in pairs(input) do
        for kkk, vvv in pairs(input[kk]) do
            local pad = ard_calculatePad(vvv, lengths[kkk])
            output = output .. " " .. vvv .. " " .. string.rep(" ", pad)
        end
        output = output .. "\n"
    end

    return output
end

