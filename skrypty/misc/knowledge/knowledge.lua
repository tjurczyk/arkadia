misc["knowledge_desc"] = {
    ["znikoma"] = " [1/10]=         |",
    ["niewielka"] = " [2/10]==        |",
    ["czesciowa"] = " [3/10]===       |",
    ["niezla"] = " [4/10]====      |",
    ["dosc dobra"] = " [5/10]=====     |",
    ["dobra"] = " [6/10]======    |",
    ["bardzo dobra"] = " [7/10]=======   |",
    ["doskonala"] = " [8/10]========  |",
    ["prawie pelna"] = " [9/10]========= |",
    ["pelna"] = "[10/10]==========|",
}

misc.knowledge = misc.knowledge or
    {
        ["data_url"] = "https://raw.githubusercontent.com/tjurczyk/arkadia-data/master/knowledge_data.json",
        ["data_file_path"] = getMudletHomeDir() .. "/knowledge_data.json",
    }

misc.knowledge["categories"] = {
    "chaos i jego twory",
    "goblinoidy",
    "golemy",
    "istoty demoniczne",
    "jaszczuroludzie",
    "magia i jej twory",
    "nieumarli",
    "pajaki i pajakowate",
    "ryboludzie",
    "smoki i smokowate",
    "starsze rasy",
    "stwory pokoniunkcyjne",
    "szczuroludzie",
    "wampiry"
}

misc.knowledge["declension_category"] = {
    ["chaosie i jego tworach"] = "chaos i jego twory",
    ["goblinoidach"] = "goblinoidy",
    ["golemach"] = "golemy",
    ["istotach demonicznych"] = "istoty demoniczne",
    ["jaszczuroludziach"] = "jaszczuroludzie",
    ["magii i jej tworach"] = "magia i jej twory",
    ["nieumarlych"] = "nieumarli",
    ["pajakach i pajakowatych"] = "pajaki i pajakowate",
    ["ryboludziach"] = "ryboludzie",
    ["smokach i smokowatych"] = "smoki i smokowate",
    ["starszych rasach"] = "starsze rasy",
    ["stworach pokoniunkcyjnych"] = "stwory pokoniunkcyjne",
    ["szczuroludziach"] = "szczuroludzie",
    ["wampirach"] = "wampiry"
}

function misc.knowledge:knowledge_replace(text)
    if selectString(text, 1) > -1 then
        local add_text = " " .. misc.knowledge_desc[text]
        replace(scripts.utils.str_pad(text, 12) .. add_text, true)
        resetFormat()
    end
end

function misc.knowledge:initial_zglebiaj()
    if self.trigger then killTrigger(self.trigger) end;

    self.trigger = tempRegexTrigger("Wiedze o czym chcesz zglebiac\\? (.*)",
        function() self:zglebiaj_replace(matches[2]) end, 1)
    send("zglebiaj")
    tempTimer(5, function() killTrigger(self.trigger) end)
end

-- rozbija output dostepnych do zglebiania wiedzy na linie
function misc.knowledge:zglebiaj_replace(text)
    if selectString(text, 1) > -1 then
        replace("\n")
    end

    text = string.gsub(text, "czy o ([^?]*)?", ", o %1")
    local available = string.split(text, ",")
    self.last_knowledge = available
    for i, var in pairs(available) do
        var = string.lower(string.trim(var))
        cecho('' .. i .. '. ' .. var .. '\n')
    end

    killTrigger(self.trigger)
end

function misc.knowledge:zglebiaj_wiedze(index)
    index = tonumber(index)
    if self.last_knowledge == nil then
        send('zglebiaj')
        return
    end

    local name = self.last_knowledge[index]
    if name == nil then
        cecho("<orange>Nie odnalazlem wiedzy o tym indeksie. Sprobuj podac pelna nazwe.\n")
        return
    end
    send("zglebiaj wiedze " .. name)
end

function alias_func_skrypty_misc_zglebiaj_wiedze()
    local number = string.trim(matches[2])
    if (number == nil or number == '') then
        misc.knowledge:initial_zglebiaj()
    else
        misc.knowledge:zglebiaj_wiedze(tonumber(number))
    end
end
