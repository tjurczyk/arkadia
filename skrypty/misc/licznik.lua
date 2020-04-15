function alias_func_skrypty_misc_licznik_zabici()
    misc.counter:print_killed()
end

function alias_func_skrypty_misc_licznik_reset()
    misc.counter:reset()
    scripts.ui.footer_info_killed:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Zabici:&nbsp;</font> <font color='" .. scripts.ui["footer_info_neutral"] .. "'></font>")
end

function alias_func_skrypty_misc_licznik_zabici2()
    misc.counter2:show_short()
end

function alias_func_skrypty_misc_licznik_zabici2()
    misc.counter2:show_long()
end

function alias_func_skrypty_misc_licznik_zabici2_date()
    local sep = string.split(matches[2], "/")
    misc.counter2:show_logs(sep[1], sep[2], sep[3])
end

function alias_func_skrypty_misc_licznik_zabici2_reset()
    misc.counter2:reset()
end

