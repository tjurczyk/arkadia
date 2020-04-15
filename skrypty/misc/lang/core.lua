function misc.lang:say(pre, lang_id, text)
    misc.lang:check_language(lang_id)
    local _text

    if misc.lang["gnome_speech"] then
        text = camelcase(text)
    end

    if misc.lang["aliases_prefix"][pre] then
        _text = misc.lang["aliases_prefix"][pre] .. " " .. text
    else
        _text = text
    end

    if lang_id == 20 then
        send("ppowiedz " .. _text, false)
    else
        send("jppowiedz " .. _text, false)
    end
end

function camelcase(z)
    local tab = string.split(z, "  ")
    local text_to_camel = nil
    local prefix = ""
    if table.size(tab) == 2 then
        text_to_camel = tab[2]
        prefix = tab[1]
    else
        text_to_camel = tab[1]
    end

    local words = string.split(text_to_camel, " ")
    local s = ""
    for _, ss in pairs(words) do
        s = s .. ss:gsub("^%l", string.upper)
    end
    return prefix .. " " .. s
end

function misc.lang:check_language(lang_id)
    if lang_id ~= 20 and lang_id ~= misc.lang["current_lang"] then
        misc.lang["current_lang"] = lang_id
        send("justaw " .. misc.lang["inv_languages"][lang_id], false)
    end
end

function misc.lang:init()
    for k, v in pairs(misc.lang["alias_ids"]) do
        killAlias(v)
    end

    misc.lang["alias_ids"] = {}

    for k, v in pairs(misc.lang["aliases"]) do
        local regex = "^" .. k .. " (.*)$"
        local alias_id = tempAlias(regex, [[ misc.lang:say("]] .. k .. [[", ]] .. misc.lang.languages[v] .. [[, matches[2]) ]])
        table.insert(misc.lang["alias_ids"], alias_id)
    end
end

function misc.lang:kill()
    for k, v in pairs(misc.lang["alias_ids"]) do
        killAlias(v)
    end
end

function misc.lang:show_languages()
    cecho("<green>Wspierane jezyki: \n")
    for k, v in pairs(misc.lang["languages"]) do
        cecho("<grey> - " .. k .. "\n")
    end
end

