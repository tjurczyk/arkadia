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
    ["Hexensnacht"] = "Hexensnacht (Nowy Rok)",
    ["Mitterfruhl"] = "Mitterfruhl (rownonoc wiosenna)",
    ["Sonnenstill"] = "Sonnenstill (przesilenie letnie)",
    ["Geheimnisnacht"] = "Geheimnisnacht (Noc Tajemnicy)",
    ["Mitterherbst"] = "Mitterherbst (rownonoc jesienna)",
    ["Mondstill"] = "Mondstill (przesilenie zimowe)"
}

function misc:replace_string_calendar(str, calendar)
    if calendar[str] == nil then
        debugc("Brak wpisu '"..str.."' w kalendrzu")
        return
    end
    local new_calendar_str = calendar[str]
    if selectString(str, 1) > -1 then
        replace(new_calendar_str)
    end
end

function trigger_func_skrypty_misc_calendar_pory_roku_ishtar()
    misc:replace_string_calendar(matches[2], misc["ishtar_calendar"])
end

function trigger_func_skrypty_misc_calendar_pory_roku_imperium()
    misc:replace_string_calendar_imperium(matches[2])
end

