function magic_prefix(text)
    text = string.format("[ %s ] ", text)
    prefix(text)
    if selectString(text, 1) > -1 then
        fg("orange")
    end
    resetFormat()
end

function trigger_func_skrypty_inventory_magic_weapons_widelec_leczy()
    magic_prefix("HP+")
end

function trigger_func_skrypty_inventory_magic_weapons_amu_leczy()
    magic_prefix("HP+")
end

function trigger_func_skrypty_inventory_magic_weapons_tasak_dziala()
    magic_prefix("Tasak")
end

function trigger_func_skrypty_inventory_magic_weapons_gadacz_leczy()
    magic_prefix("HP+")
end

function trigger_func_skrypty_inventory_magic_weapons_plaszcz_leczy()
    magic_prefix("HP+")
end

