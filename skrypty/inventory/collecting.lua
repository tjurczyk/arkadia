function alias_func_skrypty_inventory_collecting_set_mode()
    scripts.inv.collect:set_mode(tonumber(matches[2]))
    if scripts.inv.collect["footer_info_collect_to_text"][scripts.inv.collect.current_mode] then
        scripts.ui.footer_info_collect_mode:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Zbieranie: </font> <font color='" .. scripts.ui["footer_info_neutral"] .. "'>" .. scripts.inv.collect["footer_info_collect_to_text"][scripts.inv.collect.current_mode] .. "</font>")
    end
end

function alias_func_skrypty_inventory_collecting_help()
    scripts.inv.collect:print_help()
end

function alias_func_skrypty_inventory_collecting_zbieraj()
    scripts.inv.collect:key_pressed(false)
end

function alias_func_skrypty_inventory_collecting_zbieraj_force()
    scripts.inv.collect:key_pressed(true)
end

function alias_func_skrypty_inventory_collecting_zbieranie_monet()
    scripts.inv.collect:set_money_mode(tonumber(matches[2]))
end

function alias_func_skrypty_inventory_collecting_zbieraj_extra()
    local str_trim = trim_string(matches[2])
    display(str_trim)
    if str_trim ~= "" then
        scripts.inv.add_to_collect_extra(str_trim)
    else
        scripts.inv.collect:print_help()
    end
end

function alias_func_skrypty_inventory_collecting_zbieraj_extra_off()
    local str_trim = trim_string(matches[2])
    if str_trim ~= "" then
        scripts.inv.remove_from_collect_extra(str_trim, false)
    else
        scripts.inv.remove_from_collect_extra("", true)
    end
end

function alias_func_skrypty_inventory_collecting_zbierz_z_cial()
    dead_bodies_trigg = tempRegexTrigger("^.*Doliczyl.s sie ([a-z]+) sztuk(|i)\.$", function() scripts.inv.after_counting_collect(matches[2]) end, 1)
    send("policz wszystkie ciala")
end

