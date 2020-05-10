amap["ui"] = amap["ui"] or {}

amap.ui.active = true
amap.ui["compass"] = {
    dirs = { "nw", "n", "ne", "w", "e", "sw", "s", "se", "d", "u", "special1", "special2", "special3" },
    active_dirs = {},
    special_exit1 = nil,
    special_exit2 = nil,
    special_exit3 = nil
}

amap.ui["dir_to_symbol"] = {
    ["nw"] = "\\",
    ["n"] = "|",
    ["ne"] = "/",
    ["w"] = "- ",
    ["e"] = " -",
    ["sw"] = "/",
    ["se"] = "\\",
    ["s"] = "|",
    ["d"] = "v",
    ["u"] = "^"
}

amap.ui["dir_to_fancy_symbol"] = {
    ["nw"] = "↖",
    ["n"] = "↑",
    ["ne"] = "↗",
    ["w"] = "←",
    ["e"] = "→",
    ["sw"] = "↙",
    ["se"] = "↘",
    ["s"] = "↓",
    ["d"] = "▼",
    ["u"] = "▲"
}

amap.ui.use_simplified_compass = false

amap.ui["normal_button"] = "background-color: rgba(0,0,0,0);"
amap.ui["hover_button"] = "background-color: #009E3A;"
amap.ui["inactive_mapper"] = "background-color: #ff9900;"

amap.ui["previous_direction"] = "#ff9900"

