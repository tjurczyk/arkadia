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

local colors = { "red", "orange", "yellow", "green", "SkyBlue"}

function misc:skill_replace(text)
    for k, v in pairs(misc["skills_desc"]) do
        local color = math.max(1, round( tonumber(v:sub(2,- 5)) / 11 * #colors))
        local index = 1
        while selectString(k, index) > -1 do
            creplace(string.format("<%s>%s %s<reset>%s", colors[color], k, scripts.utils.str_pad(v, 19 - k:len(), "right"), scripts.utils.str_pad("", k:len())))
            if selectString("]              ", 1) > -1 then
                replace("]", true)
            end
            index = index + 1
            resetFormat()
        end
    end
end

