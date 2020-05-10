misc["knowledge_desc"] = {
    ["znikoma"] = "     [1/10]=         |",
    ["niewielka"] = "   [2/10]==        |",
    ["czesciowa"] = "   [3/10]===       |",
    ["niezla"] = "      [4/10]====      |",
    ["dosc dobra"] = "  [5/10]=====     |",
    ["dobra"] = "       [6/10]======    |",
    ["bardzo dobra"] = "[7/10]=======   |",
    ["doskonala"] = "   [8/10]========  |",
    ["prawie pelna"] = "[9/10]========= |",
    ["pelna"] = "      [10/10]==========|",
}

function misc:knowledge_replace(text)
    selectString(text, 1)
    local add_text = " " .. misc.knowledge_desc[text]
    replace(text .. add_text)
    selectString(misc.knowledge_desc[text], 1)
    resetFormat()
end

last_knowledge = nil

-- rozbija output dostepnych do zglebiania wiedzy na linie
function misc:zglebiaj_replace(text)
    selectString(text, 1)
    replace("\n")

    text = string.gsub(text, "czy o ([^?]*)?", ", o %1")
    local available = string.split(text, ",")
    last_knowledge = available
    for i,var in pairs(available) do
        var = string.lower(string.trim(var))
        cecho(''..i..'. '..var..'\n')
    end
end

function misc:zglebiaj_wiedze(index)
    index = tonumber(index)
    if last_knowledge == nil then
        send('zglebiaj')
        return
    end

    local name = last_knowledge[index]
    if name == nil then
        cecho("<orange>Nie odnalazlem wiedzy o tym indeksie. Sprobuj podac pelna nazwe.\n")
        return
    end
    send('zglebiaj wiedze '..name)
end

function alias_func_skrypty_misc_zglebiaj_wiedze()
    misc:zglebiaj_wiedze(tonumber(matches[2]))
end

function trigger_func_skrypty_misc_knowledge_O_czym_wiedze_checesz_zglebiac()
    misc:zglebiaj_replace(matches[2])
end
