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

