scripts["ui"] = scripts["ui"] or { cfg = {} }

scripts.ui.map_loaded = false
scripts.ui.states_windows_loaded = false

-- width for wrapping the states window
scripts.ui.states_window_p_width = 95

-- width for wrapping the talk window
scripts.ui.separate_talk_window_p_width = 0.8

-- prefix for the talk window
scripts.ui.separate_talk_window_prefix = ""

-- msg types for separate talk window
scripts.ui.separate_talk_window_msg_types = { ["comm"] = true, ["emotes"] = true }

scripts.ui["footer_info_normal"] = "#b3b3b3"
scripts.ui["footer_info_neutral"] = "#e6e600"
scripts.ui["footer_info_green"] = "#00e600"
scripts.ui["footer_info_yellow"] = "#ffff00"
scripts.ui["footer_info_red"] = "#e60000"

scripts.ui["footer_info_walk_mode_to_text"] = {
    "<font color='" .. scripts.ui["footer_info_green"] .. "'></font>",
    "<font color='" .. scripts.ui["footer_info_green"] .. "'>ja</font>",
    "<font color='" .. scripts.ui["footer_info_green"] .. "'>ja+d</font>"
}

-- W ktorym miejscu (% okna) ma sie zaczac dolna belka
scripts.ui.footer_start = 0
-- Wysokosc (w pikselsach) dolnej belki
scripts.ui.footer_height = 70
-- Szerokosc (w %) dolnej belki
scripts.ui.footer_width = 100

-- Jaki % dolnej belki ma zajmowac roza wiatrow
scripts.ui.footer_map_width_p = 14
-- Jaki % dolnej belki ma zajmowac prawa czesc belki (informacyjna z zaslonami itp)
scripts.ui.footer_info_width_p = 46
-- Ilosc wierszy w prawej, informacyjnej czesci belki
scripts.ui.footer_info_row_count = 4

-- Margines wysokosci (w pikselach) rozy wiatrow
scripts.ui.footer_map_width_margin = 3
-- Margines szerokosci (w pikselach) rozy wiatrow
scripts.ui.footer_map_height_margin = 0

-- Ile elementow/jeden wiersz ma byc w srodkowym pasku
-- Moga byc tam maksymalnie 3 wiersze, wiec przy uzywaniu wszystkich
-- paskow, 4 lub 5 to dobra wartosc
scripts.ui.footer_main_items_per_row = 4

scripts.ui.footer_map_font_size = 10
scripts.ui.footer_font_size = 11
scripts.ui.states_font_size = 11

scripts.ui.footer_r = 0
scripts.ui.footer_g = 0
scripts.ui.footer_b = 47

scripts.ui.footer_b = 47

scripts.ui.separate_talk_window = false
scripts.ui.separate_talk_window_font_size = 12

scripts.ui.cfg["footer_mode"] = "mode2"
scripts.ui.cfg["footer_items"] = {
    "zmeczenie",
    "mana",
    "pragnienie",
    "upicie",
}

scripts.ui.cfg.info_items = {
    "weapon",
    "order",
    "cover",
    "killed",
    "sneaky",
    "hidden",
    "attack",
    "collect",
    "mail",
    "alert",
    "lamp",
    "compass",
    "combat",
}

-- control if using navbar or not
scripts.ui.cfg["states_window_navbar"] = false

-- map key <-> scripts_key
scripts.ui["states_window_elem_map"] = {
    ["bron"] = "weapon_state",
    ["weapon_state"] = "bron",
    ["guard_state"] = "zaslona",
    ["zaslona"] = "guard_state",
    ["order_state"] = "rozkaz",
    ["rozkaz"] = "order_state",
    ["ukryty"] = "hidden_state",
    ["hidden_state"] = "ukryty",
}

-- current states
scripts.ui["states_window_nav_states"] = {}

-- this is defined in the config
scripts.ui.cfg["states_window_nav_elements"] = {
    "bron",
    "zaslona",
    "rozkaz",
    "ukryty",
}

-- key to printable
scripts.ui.cfg["states_window_nav_printable_key_map"] = {
    ["bron"] = "BRON",
    ["zaslona"] = "ZASLONA",
    ["rozkaz"] = "ROZKAZ",
    ["ukryty"] = "UKRYTY",
}

-- val to printable
-- 'len' is for padding
scripts.ui["states_window_nav_printable_val_map"] = {
    ["weapon_state"] = { [true] = "<green>on <white>", [false] = "<yellow>off<white>" },
    ["guard_state"] = {
        ["len"] = 2,
        [false] = "<green>ok",
        ["ok"] = "<green>ok",
        [1] = " <red>1",
        [2] = " <red>2",
        [3] = " <red>3",
        [4] = " <red>4",
        [5] = " <red>5"
    },
    ["order_state"] = {
        ["len"] = 2,
        [false] = "<green>ok",
        ["ok"] = "<green>ok",
        [1] = " <red>1",
        [2] = " <red>2",
        [3] = " <red>3",
        [4] = " <red>4",
        [5] = " <red>5",
        [6] = " <red>6",
        [7] = " <red>7",
        [8] = " <red>8",
        [9] = " <red>9",
        [10] = "<red>10",
        [11] = "<red>11",
        [12] = "<red>12",
        [13] = "<red>13",
        [14] = "<red>14",
        [15] = "<red>15"
    },
    ["hidden_state"] = {
        ["len"] = 2,
        [false] = "  ",
        [""] = "  ",
        ["ok"] = "<green>ok",
        [1] = " <red>1",
        [0] = " <red>0",
        [2] = " <red>2",
        [3] = " <red>3",
        [4] = " <red>4",
        [5] = " <yellow>5",
        [6] = " <yellow>6",
        [7] = " <yellow>7",
        [8] = " <yellow>8",
        [9] = " <yellow>9",
        [10] = "<green>10",
        [11] = "<green>11",
        [12] = "<green>12",
        [13] = "<green>13",
        [14] = "<green>14",
    }
}

-- to allow O(1)
scripts.ui.cfg["states_window_nav_hash"] = {}

-- po zmianie wartosci atrybutu jak hp po jakim czasie ma zniknac oznaczenie ze 
-- atrybut ulegl zmianie
scripts.ui.cfg["change_indicator_duration"] = 10

scripts.ui.cfg["footer_mode5_settings"] = {
  -- Dostepne wartosci to:
  --   percent - wyswietli np. 10%
  --   raw     - wyswietli np. 5/10
  --   none    - nie wyswietli zadnej wartosci
  ["display_value_mode"] = "raw",
  
  ["values"] = {
    ["hp"] = {
       ["color"]= "#e4190c",
    },
    ["fatigue"] = {
       ["color"]= "#05b12f",
    },
    ["mana"] = {
       ["color"]= "#308dff",
    },
    ["soaked"] = {
       ["color"]= "#add8e6",
    },
    ["stuffed"] = {
       ["color"]= "#8C482E",
    },
    ["intox"]= {
       ["color"]= "#fb00ff",
    },
    ["headache"] = {
       ["color"]= "#777777",
    },
    ["panic"] = {
       ["color"]= "#ffd504",
    },
    ["encumbrance"] = {
       ["color"]= "#e2ef27",
    },
    ["improve"] = {
       ["color"]= "#522699",
    },
    ["form"] = {
       ["color"]= "#ff8404",
    },
  }
}

function scripts.ui:decode_states_window_navbar_key(k)
    if not scripts.ui.states_window_elem_map[k] then
        error("wrong input: " .. k)
    end

    return scripts.ui.states_window_elem_map[k]
end

scripts.ui.states_window_navbar_str = ""

tempTimer(2.348, function() scripts.ui:init_states_window_navbar() end)

function alias_func_skrypty_ui_restart_ui()
    scripts.ui:setup()
end

function alias_func_skrypty_ui_help()
    scripts.ui:print_help()
end

function alias_func_skrypty_ui_kondycje()
    showWindow("states_window")
end

