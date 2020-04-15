local function format(v)
    return v > 0 and "+" .. tostring(v) or tostring(v)
end


function misc:comparing_after(results)
    cecho("\n\n")
    local iter = 1
    local out = {
        { "#", "OSOBA", "SIL", "ZRE", "WYT", "TOTAL" }
    }
    for i = 1, table.size(results), 3 do
        local id = scripts.comparing_all.objects_to_check[iter]
        local obj = ateam.objs[id]
        local str = results[i]
        local dex = results[i + 1]
        local con = results[i + 2]
        local total = str + dex + con
        table.insert(out, { iter, obj.desc, format(str), format(dex), format(con), format(total) })
        iter = iter + 1
    end
    local pt = ard_prettyTable(out)
    cecho(pt)
end



