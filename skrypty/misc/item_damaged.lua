misc["item_damaged_desc"] = {
    ["w znakomitym stanie."] = "[max]",
    ["lekko podniszczona."] = "[4/5]",
    ["lekko podniszczone."] = "[4/5]",
    ["lekko podniszczony."] = "[4/5]",
    ["w kiepskim stanie."] = "[3/5]",
    ["w oplakanym stanie."] = "[2/5]",
    ["gotowy sie rozpasc w kazdej chwili."] = "[1/5]",
    ["gotowa sie rozpasc w kazdej chwili."] = "[1/5]",
    ["gotowe sie rozpasc w kazdej chwili."] = "[1/5]",
}

misc["item_damaged_color"] = {
    ["w znakomitym stanie."] = "green",
    ["lekko podniszczona."] = "yellow",
    ["lekko podniszczone."] = "yellow",
    ["lekko podniszczony."] = "yellow",
    ["w kiepskim stanie."] = "red",
    ["w oplakanym stanie."] = "red",
    ["gotowy sie rozpasc w kazdej chwili."] = "red",
    ["gotowa sie rozpasc w kazdej chwili."] = "red",
    ["gotowe sie rozpasc w kazdej chwili."] = "red",
}

function misc:item_damaged_replace(text)
    fg(misc.item_damaged_color[text])
    selectString(text, 1)
    local add_text = " " .. misc.item_damaged_desc[text]
    replace(text .. add_text)
    selectString(misc.item_damaged_desc[text], 1)
    resetFormat()
end

