misc["ishtar_calendar"] = {
    ["Birke"] = "Birke (wczesna wiosna)",
    ["Blathe"] = "Blathe (pozna wiosna)",
    ["Feainn"] = "Feainn (wczesne lato)",
    ["Lammas"] = "Lammas (pozne lato)",
    ["Velen"] = "Velen (wczesna jesien)",
    ["Saovine"] = "Saovine (pozna jesien)",
    ["Yule"] = "Yule (wczesna zima)",
    ["Imbaelk"] = "Imbaelk (pozna zima)",
}

misc["imperium_calendar"] = {
    ["Nachhexen"] = "Nachhexen (wczesna wiosna)",
    ["Jahrdrung"] = "Jahrdrung (wiosna)",
    ["Pflugzeit"] = "Pflugzeit (pozna wiosna)",
    ["Sigmarszeit"] = "Sigmarszeit (wczesne lato)",
    ["Sommerzeit"] = "Sommerzeit (lato)",
    ["Vorgeheim"] = "Vorgeheim (pozne lato)",
    ["Nachgeheim"] = "Nachgeheim (wczesna jesien)",
    ["Erntezeit"] = "Erntezeit (jesien)",
    ["Brauzeit"] = "Brauzeit (pozna jesien)",
    ["Kaltezeit"] = "Kaltezeit (wczesna zima)",
    ["Ulrichszeit"] = "Ulrichszeit (zima)",
    ["Vorhexen"] = "Vorhexen (pozna zima)",
    ["Hexentag"] = "Hexentag (Nowy Rok)",
    ["Mitterfruhl"] = "Mitterfruhl (rownonoc wiosenna)",
    ["Sonnenstill"] = "Sonnenstill (przesilenie letnie)",
    ["Geheimnisnacht"] = "Geheimnisnacht (Noc Tajemnicy)",
    ["Mitterherbst"] = "Mitterherbst (rownonoc jesienna)",
    ["Mondstill"] = "Mondstill (przesilenie zimowe)"
}

function misc:replace_string_calendar_ishtar(str)
    local new_calendar_str = misc.ishtar_calendar[str]
    if new_calendar_str then
        selectString(str, 1)
        replace(new_calendar_str)
    end
end

function misc:replace_string_calendar_imperium(str)
    local new_calendar_str = misc.imperium_calendar[str]
    selectString(str, 1)
    replace(new_calendar_str)
end

function trigger_func_skrypty_misc_calendar_pory_roku_ishtar()
    misc:replace_string_calendar_ishtar(matches[2])
end

function trigger_func_skrypty_misc_calendar_pory_roku_imperium()
    misc:replace_string_calendar_imperium(matches[2])
end

