misc["skills_desc"] = {
    ["ledwo"] = "[1/10]",
    ["troche"] = "[2/10]",
    ["pobieznie"] = "[3/10]",
    ["zadowalajaco"] = "[4/10]",
    ["niezle"] = "[5/10]",
    ["dobrze"] = "[6/10]",
    ["znakomicie"] = "[7/10]",
    ["doskonale"] = "[8/10]",
    ["perfekcyjnie"] = "[9/10]",
    ["mistrzowsko"] = "[10/10]",
}

function misc:skill_replace(text)
    local um_matched = ""
    for k, v in pairs(misc["skills_desc"]) do
        local str = selectString(k, 1)
        if str > -1 then
            um_matched = k
            replace(k .. " " .. v)
            break
        end
    end

    local found = false
    for k, v in pairs(misc["skills_desc"]) do
        local str = selectString(k, 2)
        if str > -1 then
            um_matched = k
            replace(k .. " " .. v)
            found = true
            break
        end
    end

    if found then
        return
    end

    for k, v in pairs(misc["skills_desc"]) do
        if um_matched ~= k then
            local str = selectString(k, 1)
            if str > -1 then
                add_text = " " .. v
                replace(k .. " " .. v)
                break
            end
        end
    end
end

