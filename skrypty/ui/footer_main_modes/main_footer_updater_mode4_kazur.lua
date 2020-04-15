function scripts.ui:process_label_text_mode4(prefix, val, max, color)
    if val == -1 then
        -- this happens at the start
        return
    end
    local str = [[<center><font color='#b3b3b3'>]] .. prefix .. [[ <font  face="inversionz" size="6"><font color="]] .. color .. [[">]]
    for tmpi = 1, val, 1 do
        str = str .. tmpi
    end
    str = str .. "</font>" .. [[<font color='#b3b3b3' background='#aaaaaa'>]]
    val = val + 1
    for tmpi = val, max, 1 do
        str = str .. tmpi
    end
    str = str .. "</font></font></center>"
    return str
end

