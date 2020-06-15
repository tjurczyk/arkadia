misc["weapon_damaged_desc"] = {
    ["w znakomitym stanie."] = "[max]",
    ["w dobrym stanie."] = "[6/7]",
    ["liczne walki wyryly na niej swoje pietno."] = "[5/7]",
    ["liczne walki wyryly na nim swoje pietno."] = "[5/7]",
    ["w zlym stanie."] = "[4/7]",
    ["w bardzo zlym stanie."] = "[3/7]",
    ["wymaga natychmiastowej konserwacji."] = "[2/7]",
    ["moze peknac w kazdej chwili."] = "[1/7]",
}

misc["weapon_damaged_color"] = {
    ["w znakomitym stanie."] = "green",
    ["w dobrym stanie."] = "green",
    ["liczne walki wyryly na niej swoje pietno."] = "yellow",
    ["liczne walki wyryly na nim swoje pietno."] = "yellow",
    ["w zlym stanie."] = "red",
    ["w bardzo zlym stanie."] = "red",
    ["wymaga natychmiastowej konserwacji."] = "red",
    ["moze peknac w kazdej chwili."] = "red",
}

function misc:weapon_damaged_replace(text)
    local text = trim_string(text)
    local color = misc.weapon_damaged_color[text]

    if not color then
        return
    end

    fg(color)
    selectString(text, 1)
    local add_text = " " .. misc.weapon_damaged_desc[text]
    replace(text .. add_text)
    selectString(misc.weapon_damaged_desc[text], 1)
    resetFormat()
end

function misc:weapon_damaged_wyryly(text, weapon)
    selectCaptureGroup(1)
    creplace("Wyglada na to, ze na " .. weapon .. " <yellow>liczne walki wyryly swoje pietno. [5/7]<reset>")
end

