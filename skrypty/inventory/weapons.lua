scripts.inv.weapons = {}
scripts.inv.weapons.cases = {}
scripts.inv.weapons.cases_dopelniacz = {}
scripts.inv.weapons.cases_biernik = {}
scripts.inv.weapons.main_weapons_action = {}
scripts.inv.weapons.weapon_on_actions = {}
scripts.inv.weapons.weapon_off_actions = {}

function alias_func_skrypty_inventory_weapons_db()
    scripts.inv.weapons:get_weapons()
end

function alias_func_skrypty_inventory_weapons_db_id()
    scripts.inv.weapons:get_weapon(tonumber(matches[2]))
end

function alias_func_skrypty_inventory_weapons_ob()
    scripts.inv.weapons:lower_weapons()
end

function alias_func_skrypty_inventory_weapons_ob_id()
    scripts.inv.weapons:lower_weapon(tonumber(matches[2]))
end

function alias_func_skrypty_inventory_weapons_help()
    scripts.inv.weapons:print_help()
end

function alias_func_skrypty_inventory_weapons_ocen_bronie_zbroje()
    misc:weapon_item_collective_start()
end

