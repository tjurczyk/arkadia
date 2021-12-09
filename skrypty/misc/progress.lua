misc["progress_desc"] = {
    ["zadnych"] = "[0/15]",
    ["minimalne"] = "[0/15]",
    ["nieznaczne"] = "[1/15]",
    ["bardzo male"] = "[2/15]",
    ["male"] = "[3/15]",
    ["nieduze"] = "[4/15]",
    ["zadowalajace"] = "[5/15]",
    ["spore"] = "[6/15]",
    ["dosc duze"] = "[7/15]",
    ["znaczne"] = "[8/15]",
    ["duze"] = "[9/15]",
    ["bardzo duze"] = "[10/15]",
    ["ogromne"] = "[11/15]",
    ["imponujace"] = "[12/15]",
    ["wspaniale"] = "[13/15]",
    ["gigantyczne"] = "[14/15]",
    ["niebotyczne"] = "[15/15]",
}

function progress_replace(text)
    if selectString(text, 1) > -1 then
        local add_text = " " .. misc.progress_desc[text]
        replace(text .. add_text)
    end
    resetFormat()
end

