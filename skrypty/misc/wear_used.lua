misc["wear_used_desc"] = {
    ["calkiem nowe."] = "[5/5]",
    ["calkiem nowa."] = "[5/5]",
    ["w miare nowe."] = "[4/5]",
    ["w miare nowa."] = "[4/5]",
    ["troche znoszone."] = "[3/5]",
    ["troche znoszona."] = "[3/5]",
    ["prawie calkiem znoszone."] = "[2/5]",
    ["prawie calkiem znoszona."] = "[2/5]",
    ["gotowe rozpasc sie w kazdej chwili."] = "[1/5]",
    ["gotowa rozpasc sie w kazdej chwili."] = "[1/5]",
}

misc["wear_used_color"] = {
    ["calkiem nowe."] = "green",
    ["calkiem nowa."] = "green",
    ["w miare nowe."] = "green",
    ["w miare nowa."] = "green",
    ["troche znoszone."] = "yellow",
    ["troche znoszona."] = "yellow",
    ["prawie calkiem znoszone."] = "red",
    ["prawie calkiem znoszona."] = "red",
    ["gotowe rozpasc sie w kazdej chwili."] = "red",
    ["gotowa rozpasc sie w kazdej chwili."] = "red",
}

function misc:wear_used_replace(text)
    if selectString(text, 1) > -1 then
        fg(misc.wear_used_color[text])
        local add_text = " " .. misc.wear_used_desc[text]
        replace(text .. add_text)
        resetFormat()
    end
end

