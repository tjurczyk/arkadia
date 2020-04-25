misc["lang"] = misc["lang"] or {}


misc.lang["current_lang"] = nil
misc.lang["alias_ids"] = misc.lang["alias_ids"] or {}

misc.lang["gnome_speech"] = false

misc.lang["languages"] = {
    ["bretonski"] = 1,
    ["drukh-eltharin"] = 2,
    ["estalijski"] = 3,
    ["fan-eltharin"] = 4,
    ["gnomi"] = 5,
    ["grumbarth"] = 6,
    ["halflinski"] = 7,
    ["khazalid"] = 8,
    ["kislevicki"] = 9,
    ["krasnoludzki"] = 10,
    ["mroczna mowa"] = 11,
    ["nilfgaardzki"] = 12,
    ["norski"] = 13,
    ["reikspiel"] = 14,
    ["skelliganski"] = 15,
    ["starsza mowa"] = 16,
    ["tar-eltharin"] = 17,
    ["tileanski"] = 18,
    ["zerrikanski"] = 19,
    ["potoczna"] = 20
}

misc.lang["inv_languages"] = {
    "bretonski",
    "drukh-eltharin",
    "estalijski",
    "fan-eltharin",
    "gnomi",
    "grumbarth",
    "halflinski",
    "khazalid",
    "kislevicki",
    "krasnoludzki",
    "mroczna mowa",
    "nilfgaardzki",
    "norski",
    "reikspiel",
    "skelliganski",
    "starsza mowa",
    "tar-eltharin",
    "tileanski",
    "zerrikanski",
    "potoczna"
}

misc.lang["aliases"] = {}

misc.lang["aliases_prefix"] = {}


function alias_func_skrypty_misc_lang_jezyki()
    misc.lang:show_languages()
end

