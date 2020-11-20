scripts.gag_colors = {}
-- Ciosy
scripts.gag_colors["moje_ciosy"] = "alice_blue"
scripts.gag_colors["moje_spece"] = "green_yellow"

scripts.gag_colors["innych_ciosy"] = "LightGrey"
scripts.gag_colors["innych_ciosy_we_mnie"] = "LightGrey"
scripts.gag_colors["innych_spece"] = "slate_grey"

scripts.gag_colors["moje_uniki"] = "SteelBlue"
scripts.gag_colors["innych_uniki"] = "dark_slate_grey"

scripts.gag_colors["moje_parowanie"] = "SteelBlue"
scripts.gag_colors["innych_parowanie"] = "dark_slate_gray"

scripts.gag_colors["zaslony_udane"] = "deep_sky_blue"
scripts.gag_colors["zaslony_nieudane"] = "dark_slate_blue"

scripts.gag_colors["bron"] = "gold"

scripts.gag_colors["npc"] = "floral_white"

scripts.gag_settings = {
    ["moje_ciosy"] = 2,
    ["moje_spece"] = 2,
    ["innych_ciosy"] = 2,
    ["innych_ciosy_we_mnie"] = 2,
    ["innych_spece"] = 2,
    ["moje_uniki"] = 2,
    ["innych_uniki"] = 2,
    ["moje_parowanie"] = 2,
    ["innych_parowanie"] = 2,
    ["zaslony_udane"] = 2,
    ["zaslony_nieudane"] = 2,
    ["cele"] = 2,
    ["rozkazy"] = 2,
    ["bloki"] = 2,
    ["bron"] = 2,
    ["npc"] = 2,
}

function scripts.ui:set_gag_options()
    for k, v in pairs(scripts.gag_settings) do
        disableTrigger("color_" .. k)
        if v > 0 then
            enableTrigger("color_" .. k)
        end
    end
end

tempTimer(3, function() scripts.ui:set_gag_options() scripts:print_log("Opcje gagow zaladowane") end)

