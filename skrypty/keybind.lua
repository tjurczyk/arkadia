scripts["keybind"] = scripts["keybind"] or {}
scripts.keybind.ids = scripts.keybind.ids or {}

scripts.keybind.printable_items = {
    ["Control"] = "CTRL",
    ["Alt"] = "Alt",
    ["Shift"] = "Shift",
    ["Meta"] = "Meta",
    ["Keypad"] = "Keypad",
    ["GroupSwitch"] = "GroupSwitch",
    ["Equal"] = "=",
    ["Plus"] = "+",
    ["Minus"] = "-",
    ["Asterisk"] = "*",
    ["Ampersand"] = "&",
    ["AsciiCircum"] = "^",
    ["Percent"] = "*",
    ["Dollar"] = "*",
    ["NumberSign"] = "*",
    ["At"] = "*",
    ["Exclam"] = "*",
    ["AsciiTilde"] = "~",
    ["BracketLeft"] = "[",
    ["BracketRight"] = "]",
    ["BraceLeft"] = "{",
    ["BraceRight"] = "}",
    ["ParenLeft"] = "(",
    ["ParenRight"] = ")",
    ["QuoteLeft"] = "`",
    ["QuoteDbl"] = "\"",
    ["Apostrophe"] = "'",
    ["Less"] = "<",
    ["Greater"] = ">",
    ["Slash"] = "/",
    ["Backslash"] = "\\",
    ["Underscore"] = "_",
    ["Comma"] = ",",
    ["Period"] = ".",
    ["Question"] = "_",
    ["Colon"] = ":",
    ["Semicolon"] = ";",
    ["Bar"] = "|",
}

scripts.keybind["configuration"] = {
    ["fight_support"] = {
        ["modifier"] = { "Control" },
        ["key"] = "W",
        ["keys"] = {},
        ["description"] = "Wsparcie",
        ["callback"] = "callback_fight_support",
        ["active"] = true
    },
    ["attack_target"] = {
        ["modifier"] = { "Control" },
        ["key"] = "1",
        ["keys"] = {},
        ["description"] = "Atakowanie celu ataku",
        ["callback"] = "callback_attack_target",
        ["active"] = true
    },
    ["critical_hp"] = {
        ["modifier"] = { "Control", "Alt" },
        ["key"] = "Equal",
        ["keys"] = {},
        ["description"] = "Uzycie kondycji w niskim stanie hp",
        ["callback"] = "callback_critical_hp",
        ["active"] = true
    },
    ["functional_key"] = {
        ["modifier"] = {},
        ["key"] = "BracketRight",
        ["keys"] = {},
        ["description"] = "Funkcjonalny bind",
        ["callback"] = "callback_functional_bind",
        ["active"] = true
    },
    ["attack_bind_obj"] = {},
    ["attack_bind_objs"] = {
        ["modifier"] = {},
        ["key"] = "",
        ["keys"] = {"F1"},
        ["description"] = "Atakowanie osob z bindow",
        ["callback"] = "callback_bind_attack_objs",
        ["active"] = true
    },
    ["break_attack_target"] = {
        ["modifier"] = {},
        ["key"] = "F2",
        ["keys"] = {},
        ["description"] = "Przelamywanie i atakowanie celu ataku",
        ["callback"] = "callback_break_defense",
        ["active"] = true
    },
    ["block_attack_target"] = {
        ["modifier"] = {},
        ["key"] = "F3",
        ["keys"] = {},
        ["description"] = "Blokowanie celu ataku",
        ["callback"] = "callback_block_attack_obj",
        ["active"] = true
    },
    ["collect_from_body"] = {
        ["modifier"] = { "Control" },
        ["key"] = "3",
        ["keys"] = {},
        ["description"] = "Zbieranie z cial",
        ["callback"] = "callback_collect_from_body",
        ["active"] = true
    },
    ["filling_lamp"] = {
        ["modifier"] = { "Control" },
        ["key"] = "4",
        ["keys"] = {},
        ["description"] = "Dopelnianie lampy",
        ["callback"] = "callback_filling_lamp",
        ["active"] = true
    },
    ["empty_bottle"] = {
        ["modifier"] = {},
        ["key"] = "Backslash",
        ["keys"] = {},
        ["description"] = "Odlozenie pustej butelki",
        ["callback"] = "callback_empty_bottle",
        ["active"] = true
    },
    ["enter_ship"] = {
        ["modifier"] = {},
        ["key"] = "BracketLeft",
        ["keys"] = {},
        ["description"] = "Wsiadanie na statki i dylizanse",
        ["callback"] = "callback_enter_ship",
        ["active"] = true
    },
    ["temp1"] = {
        ["modifier"] = { "Control" },
        ["key"] = "Minus",
        ["keys"] = {},
        ["description"] = "Tymczasowy keybind (1)",
        ["callback"] = "callback_temp1",
        ["active"] = true
    },
    ["temp2"] = {
        ["modifier"] = { "Control" },
        ["key"] = "Equal",
        ["keys"] = {},
        ["description"] = "Tymczasowy keybind (2)",
        ["callback"] = "callback_temp2",
        ["active"] = true
    },
    ["temp3"] = {
        ["modifier"] = { "Alt" },
        ["key"] = "Minus",
        ["keys"] = {},
        ["description"] = "Tymczasowy keybind (3)",
        ["callback"] = "callback_temp3",
        ["active"] = true
    },
    ["temp4"] = {
        ["modifier"] = { "Alt" },
        ["key"] = "Equal",
        ["keys"] = {},
        ["description"] = "Tymczasowy keybind (4)",
        ["callback"] = "callback_temp4",
        ["active"] = true
    },
    ["temp5"] = {
        ["modifier"] = {},
        ["key"] = "",
        ["keys"] = {},
        ["description"] = "Tymczasowy keybind (5)",
        ["callback"] = "callback_temp5",
        ["active"] = false
    },
    ["temp6"] = {
        ["modifier"] = {},
        ["key"] = "",
        ["keys"] = {},
        ["description"] = "Tymczasowy keybind (6)",
        ["callback"] = "callback_temp6",
        ["active"] = false
    },
    ["temp7"] = {
        ["modifier"] = {},
        ["key"] = "",
        ["keys"] = {},
        ["description"] = "Tymczasowy keybind (7)",
        ["callback"] = "callback_temp7",
        ["active"] = false
    },
    ["temp8"] = {
        ["modifier"] = {},
        ["key"] = "",
        ["keys"] = {},
        ["description"] = "Tymczasowy keybind (8)",
        ["callback"] = "callback_temp8",
        ["active"] = false
    },
    ["temp9"] = {
        ["modifier"] = {},
        ["key"] = "",
        ["keys"] = {},
        ["description"] = "Tymczasowy keybind (9)",
        ["callback"] = "callback_temp9",
        ["active"] = false
    },
    ["temp10"] = {
        ["modifier"] = {},
        ["key"] = "",
        ["keys"] = {},
        ["description"] = "Tymczasowy keybind (10)",
        ["callback"] = "callback_temp10",
        ["active"] = false
    },
    ["multibind1"] = {
        ["modifier"] = { "Alt" },
        ["key"] = "Minus",
        ["keys"] = {},
        ["description"] = "Multibind lokacyjny (1)",
        ["callback"] = "callback_mbind1",
        ["active"] = true
    },
    ["multibind2"] = {
        ["modifier"] = { "Alt" },
        ["key"] = "Minus",
        ["keys"] = {},
        ["description"] = "Multibind lokacyjny (2)",
        ["callback"] = "callback_mbind2",
        ["active"] = true
    },
    ["multibind3"] = {
        ["modifier"] = { "Alt" },
        ["key"] = "Minus",
        ["keys"] = {},
        ["description"] = "Multibind lokacyjny (3)",
        ["callback"] = "callback_mbind3",
        ["active"] = true
    },
    ["multibind4"] = {
        ["modifier"] = { "Alt" },
        ["key"] = "Minus",
        ["keys"] = {},
        ["description"] = "Multibind lokacyjny (4)",
        ["callback"] = "callback_mbind4",
        ["active"] = true
    },
    ["opening_gate"] = {
        ["modifier"] = { "Control" },
        ["key"] = "2",
        ["keys"] = {},
        ["description"] = "Otwieranie bram",
        ["callback"] = "callback_opening_gate",
        ["active"] = true
    },
    ["drinking"] = {
        ["modifier"] = { "Control" },
        ["key"] = "N",
        ["keys"] = {},
        ["description"] = "Picie ze zrodel wody",
        ["callback"] = "callback_drinking",
        ["active"] = true
    },
    ["special_exit"] = {
        ["modifier"] = { "Control" },
        ["key"] = "P",
        ["keys"] = {},
        ["description"] = "Bindy do przejsc specjalnych",
        ["callback"] = "callback_special_exit",
        ["active"] = true
    },
    ["walk_mode"] = {
        ["modifier"] = {},
        ["key"] = "QuoteLeft",
        ["keys"] = {},
        ["description"] = "Tryby chodzenia",
        ["callback"] = "callback_walk_mode",
        ["active"] = true
    },
}

function alias_func_skrypty_keybind_tbind()
    scripts.temp_binds:pretty_print()
end

function alias_func_skrypty_keybind_tbind_def()
    scripts.temp_binds.temp_bind_set(tonumber(matches[2]), matches[3], false)
end

function alias_func_skrypty_keybind_tbind_reset()
    scripts.temp_binds.unbind_temp()
end

function alias_func_skrypty_keybind_binds_on()
    scripts.utils.enable_keybinds()
end

function alias_func_skrypty_keybind_bind_off()
    scripts.utils.disable_keybinds()
end

