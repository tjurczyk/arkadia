misc["item_damaged_desc"] = {
    -- common
    ["w znakomitym stanie."] = "[max]",
    -- items
    ["lekko podniszczona."] = "[4/5]",
    ["lekko podniszczone."] = "[4/5]",
    ["lekko podniszczony."] = "[4/5]",
    ["w kiepskim stanie."] = "[3/5]",
    ["w oplakanym stanie."] = "[2/5]",
    ["gotowy sie rozpasc w kazdej chwili."] = "[1/5]",
    ["gotowa sie rozpasc w kazdej chwili."] = "[1/5]",
    ["gotowe sie rozpasc w kazdej chwili."] = "[1/5]",
    -- weapons
    ["w dobrym stanie."] = "[6/7]",
    ["liczne walki wyryly na niej swoje pietno."] = "[5/7]",
    ["liczne walki wyryly na nim swoje pietno."] = "[5/7]",
    ["w zlym stanie."] = "[4/7]",
    ["w bardzo zlym stanie."] = "[3/7]",
    ["wymaga natychmiastowej konserwacji."] = "[2/7]",
    ["moze peknac w kazdej chwili."] = "[1/7]",
}

misc["item_damaged_color"] = {
    -- common
    ["w znakomitym stanie."] = "green",
    -- items
    ["lekko podniszczona."] = "yellow",
    ["lekko podniszczone."] = "yellow",
    ["lekko podniszczony."] = "yellow",
    ["w kiepskim stanie."] = "red",
    ["w oplakanym stanie."] = "red",
    ["gotowy sie rozpasc w kazdej chwili."] = "red",
    ["gotowa sie rozpasc w kazdej chwili."] = "red",
    ["gotowe sie rozpasc w kazdej chwili."] = "red",
    -- weapons
    ["w dobrym stanie."] = "green",
    ["liczne walki wyryly na niej swoje pietno."] = "yellow",
    ["liczne walki wyryly na nim swoje pietno."] = "yellow",
    ["w zlym stanie."] = "red",
    ["w bardzo zlym stanie."] = "red",
    ["wymaga natychmiastowej konserwacji."] = "red",
    ["moze peknac w kazdej chwili."] = "red",
}

function misc:item_damaged_replace(text, filtered)
    if misc.item_damaged_desc[text] == nil then
        setTriggerStayOpen("gzocen", 0)
        return
    end
    fg(misc.item_damaged_color[text])
    selectString(text, 1)
    local add_text = " " .. misc.item_damaged_desc[text]
    replace(text .. add_text)
    selectString(misc.item_damaged_desc[text], 1)
    resetFormat()
    if filtered then
        setTriggerStayOpen("gzocen", 1)
    end
end

function misc:weapon_damaged_wyryly(text, weapon)
    selectCaptureGroup(1)
    creplace("Wyglada na to, ze na " .. weapon .. " <yellow>liczne walki wyryly swoje pietno. [5/7]<reset>")
    setTriggerStayOpen("gzocen", 1)
end