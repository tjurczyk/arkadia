scripts["ui"] = scripts["ui"] or { cfg = {} }

scripts.ui.map_loaded = false
scripts.ui.states_windows_loaded = {}

-- width for wrapping the states window
scripts.ui.states_window_p_width = 95

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
scripts.ui.footer_height = 100
-- Szerokosc (w %) dolnej belki
scripts.ui.footer_width = 100

scripts.ui.footer_actions_height = 25

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

scripts.ui.footer_color = "#00002f"

scripts.ui.separate_talk_window = false
scripts.ui.separate_talk_window_font_size = 12

scripts.ui.separate_team_talk_window = false

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
        [15] = "<green>15",
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
       ["color"]= "#b8b8b8",
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

-- poczatek konfiguracji wyswietlania dla footer mode6 --

--[[ 
  show_tip_on_start - pokazuj podpowiedz do konfiguracji trybu mode6
  bar_width - calkowita szerokosc belki graficznej (bez etykiety tekstowej)
  bar_height - wysokosc belki
  bar_item_space - szerokosc odstepu miedzy elementami belki
  bar_text_color - kolor tekstu na belce
  bar_text_font - niestandardowa czcionka tekstu na belce
  bar_text_font_size - rozmiar tekstu na belce
  bar_text_bold - czy tekst na belce ma byc pogrubiony
  bar_label_width - szerokosc etykiety belki
  bar_label_text_color - kolor tekstu etykiety
  bar_label_improve_text_color - kolor tekstu etykiety dla wyrozniania zmian na plus
  bar_label_decrease_text_color - kolor tekstu etykiety dla wyrozniania zmian na minus
  bar_label_text_font_size -- rozmiar tekstu etykiety belki
  text_indicator_increase - symbol do oznaczania wzrostu
  text_indicator_decrease - symbol do oznaczania spadku
  change_indicator_duration - czas trwania wyroznienia po zmianie atrybutu
  brightness_percentage (0-100) okresla rozpietosc rozjasniania dla colormode brightness
  
  Konfiguracja poszczegolnych elementow
  [values][nazwa_wartosci]
  Dostepne opcje dla paskow:
    color - kolor elementu z wartoscia (aktywny)
    inactive_color - kolor elementu bez wartosci (nieaktywny)
    gradient_color - kolor docelowy dla przejscia tonalnego, kolor poczatkowy to wartosc "color"
    inverted (true/false) - odwraca wartosc paska, dla 0 pasek zapelniony dla max_value pusty, 
                            pozwala zamienic np. poziom najedzenia na glod, poziom napicia na pragnienie itp
    improve_on_decrease - okresla czy wartosc paska polepsza sie przy wzroscie wartosci (false), np. kondycja, 
                          czy na spadku wartosci (true), np. zmeczenie,
                          uzywane do wyrozniania zmian, odwraca logike przy inverted = true
    color_mode: - tryb kolorowania
    - solid - zdefiniowany kolor
    - brightness - zdefiniowany kolor z rozjasnianiem
    - gradient - przejscie tonalne od color do gradient_color
    - footer_bar - kolory wg wartosci zdefiniowane w scripts.ui.footer_bar
]]--
scripts.ui.cfg["footer_mode6_settings"] = {
  ["show_tip_on_start"] = true,
  ["bar_width"] = 102,
  ["bar_height"] = 16,
  ["bar_item_space"] = 1,
  ["bar_text_color"] = "#000000",
  ["bar_text_font"] = "",
  ["bar_text_font_size"] = 8,
  ["bar_text_bold"] = true,
  ["bar_label_width"] = 32,
  ["bar_label_text_color"] = "#ffffff",
  ["bar_label_improve_text_color"] = "#ffff00",
  ["bar_label_worsen_text_color"] = "#00ffff",
  ["text_indicator_increase"] = "↑",
  ["text_indicator_decrease"] = "↓",
  ["bar_label_text_font_size"] = 10,
  ["change_indicator_duration"] = 10,
  ["brightness_percentage"] = 50,
  ["values"] = {
    ["hp"] = {
       ["color"]= "#e4190c",
       ["inactive_color"] = "#6c6563",
       ["gradient_color"] = "#ff0b64",
       ["inverted"] = false,
       ["color_mode"] = "solid",
       ["improve_on_decrease"] = false,
    },
    ["fatigue"] = {
       ["color"]= "#05b12f",
       ["inactive_color"] = "#6c6563",
       ["gradient_color"] = "#0799c9",
       ["inverted"] = false,
       ["color_mode"] = "solid",
       ["improve_on_decrease"] = true,
    },
    ["mana"] = {
       ["color"]= "#308dff",
       ["inactive_color"] = "#6c6563",
       ["gradient_color"] = "#30ffa2",
       ["inverted"] = false,
       ["color_mode"] = "solid",
       ["improve_on_decrease"] = false,
    },
    ["soaked"] = {
       ["color"]= "#add8e6",
       ["inactive_color"] = "#6c6563",
       ["gradient_color"] = "#9fd1a8",
       ["inverted"] = false,
       ["color_mode"] = "solid",
       ["improve_on_decrease"] = false,
    },
    ["stuffed"] = {
       ["color"]= "#8c482e",
       ["inactive_color"] = "#6c6563",
       ["gradient_color"] = "#8c602e",
       ["inverted"] = false,
       ["color_mode"] = "solid",
       ["improve_on_decrease"] = false,
    },
    ["intox"]= {
       ["color"]= "#fb00ff",
       ["inactive_color"] = "#6c6563",
       ["gradient_color"] = "#ff0084",
       ["inverted"] = false,
       ["color_mode"] = "solid",
       ["improve_on_decrease"] = true,
    },
    ["headache"] = {
       ["color"]= "#b8b8b8",
       ["inactive_color"] = "#6c6563",
       ["gradient_color"] = "#9f7f7f",
       ["inverted"] = false,
       ["color_mode"] = "solid",
       ["improve_on_decrease"] = true,
    },
    ["panic"] = {
       ["color"]= "#ffd504",
       ["inactive_color"] = "#6c6563",
       ["gradient_color"] = "#ff04d5",
       ["inverted"] = false,
       ["color_mode"] = "solid",
       ["improve_on_decrease"] = true,
    },
    ["encumbrance"] = {
       ["color"]= "#e2ef27",
       ["inactive_color"] = "#6c6563",
       ["gradient_color"] = "#e324d3",
       ["inverted"] = false,
       ["color_mode"] = "solid",
       ["improve_on_decrease"] = true,
    },
    ["improve"] = {
       ["color"]= "#5b1dbf",
       ["inactive_color"] = "#6c6563",
       ["gradient_color"] = "#ac1dbf",
       ["inverted"] = false,
       ["color_mode"] = "solid",
       ["improve_on_decrease"] = false,
    },
    ["form"] = {
       ["color"]= "#ff8404",
       ["inactive_color"] = "#6c6563",
       ["gradient_color"] = "#ffc404",
       ["inverted"] = false,
       ["color_mode"] = "solid",
       ["improve_on_decrease"] = false,
    },
  }
}

-- koniec konfiguracji wyswietlania dla footer mode6 --

scripts.ui.img_path = getMudletHomeDir() .. "/arkadia/ui/assets/"
scripts.ui.themes = scripts.ui.themes or {}
force_require("ui/themes/plain")
force_require("ui/themes/arkadia")
scripts.ui.theme = "arkadia"
scripts.ui.current_theme = scripts.ui.themes.arkadia:new()

function scripts.ui:decode_states_window_navbar_key(k)
    if not scripts.ui.states_window_elem_map[k] then
        error("wrong input: " .. k)
    end

    return scripts.ui.states_window_elem_map[k]
end

scripts.ui.states_window_navbar_str = ""

function alias_func_skrypty_ui_restart_ui()
    scripts.ui:setup()
end

function alias_func_skrypty_ui_help()
    scripts.ui:print_help()
end

function alias_func_skrypty_ui_kondycje()
    showWindow("states_window")
end
