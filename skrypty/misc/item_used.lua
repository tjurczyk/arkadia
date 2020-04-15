misc["item_used_desc"] = {
    ["calkiem nowy."] = "[5/5]",
    ["w miare nowy."] = "[4/5]",
    ["troche zuzyty."] = "[3/5]",
    ["w duzym stopniu zuzyty."] = "[2/5]",
    ["kompletnie zuzyty."] = "[1/5]",
}

misc["item_used_color"] = {
    ["calkiem nowy."] = "green",
    ["w miare nowy."] = "green",
    ["troche zuzyty."] = "yellow",
    ["w duzym stopniu zuzyty."] = "red",
    ["kompletnie zuzyty."] = "red",
}

function misc:item_used_replace(text)
    fg(misc.item_used_color[text])
    selectString(text, 1)
    local add_text = " " .. misc.item_used_desc[text]
    replace(text .. add_text)
    selectString(misc.item_used_desc[text], 1)
    resetFormat()
end

