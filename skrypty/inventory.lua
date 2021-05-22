scripts.inv = scripts.inv or {
    lamp = {
        working = false,
        lamp_seconds_val = 0,
        lamp_seconds_default_start_val = 300,
        lamp_warning_times = { 120, 60, 30, 10 },
        lamp_beeps = { 10 },
        lamp_yellow_seconds = 60,
        lamp_red_seconds = 30,
    },
    equipment = {},
    magics_color = "tomato",
    magic_keys_color = "green_yellow",
    magics_url = "https://raw.githubusercontent.com/tjurczyk/arkadia-data/master/magics_data.json",
    magic_keys_url = "https://raw.githubusercontent.com/tjurczyk/arkadia-data/master/magic_keys.json",
    magics_file_path = getMudletHomeDir() .. "/magics_data_v2.json",
    magic_keys_file_path = getMudletHomeDir() .. "/magic_keys_data",
    magics_trigger_ids = {},
    magic_keys_trigger_ids = {},
    magics_data = {},
    magic_keys_data = {}
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
    local color = "yellow"
    for i = 2, table.size(matches), 1 do
        if not scripts.inv.magics_data.magics[matches[i]] then
            selectCaptureGroup(i)
            fg(color)
            resetFormat()
        end
    end
end

function alias_func_skrypty_inventory_help()
    scripts.inv:print_help()
end

