scripts["inv"] = scripts["inv"] or {
    lamp = {
        working = false,
        lamp_seconds_val = 0,
        lamp_seconds_default_start_val = 300,
        lamp_warning_times = { 120, 60, 30, 10 },
        lamp_beeps = { 10 },
        lamp_yellow_seconds = 60,
        lamp_red_seconds = 30,
        lamp_empty_bottle_bind = "odloz olej;wez butelke z plecaka;napelnij lampe olejem",
        lamp_no_bottle_bind = "wez butelke z plecaka"
    },
    equipment = {},
    magics_color = "tomato",
    magic_keys_color = "green_yellow",
    magics_url = "http://158.69.205.60/data/magics.json",
    magic_keys_url = "http://158.69.205.60/data/magic_keys.json",
    magics_file_path = getMudletHomeDir() .. "/magics_data",
    magic_keys_file_path = getMudletHomeDir() .. "/magic_keys_data",
    magics_trigger_ids = {},
    magic_keys_trigger_ids = {},
}

scripts.inv["kamienie_rzeczowniki"] = {
    "agat",
    "akwamaryn",
    "aleksandryt",
    "almandyn",
    "ametyst",
    "apatyt",
    "awenturyn",
    "azuryt",
    "bursztyn",
    "celestyn",
    "chryzopraz",
    "chryzoberyl",
    "cyrkon",
    "cytryn",
    "diament",
    "diopsyd",
    "fluoryt",
    "gagat",
    "granat",
    "heliodor",
    "hematyt",
    "iolit",
    "karneol",
    "krysztal",
    "kyanit",
    "labrador",
    "lazuryt",
    "malachit",
    "monacyt",
    "nefryt",
    "obsydian",
    "onyks",
    "opal",
    "opal",
    "ortoklaz",
    "perla",
    "piryt",
    "rodochrozyt",
    "rodolit",
    "rubin",
    "serpentyn",
    "spinel",
    "szafir",
    "szmaragd",
    "topaz",
    "turkus",
    "turmalin",
    "tytanit",
    "zoisyt"
}




function trigger_func_skrypty_inventory_bron_w_pochwie()
    selectString(matches[5], 1)
    fg("yellow")
    resetFormat()
end

function trigger_func_skrypty_inventory_trzyma_bron()
    selectString(matches[3], 1)

    local color = "yellow"
    if scripts.inv.magics_data.magics[matches[3]] then
        return
    end

    fg(color)
    resetFormat()
end

function alias_func_skrypty_inventory_help()
    scripts.inv:print_help()
end

