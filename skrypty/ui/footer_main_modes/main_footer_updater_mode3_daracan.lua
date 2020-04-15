function scripts.ui:process_label_text_mode3(prefix, val, max, color)
    if val == -1 then
        -- this happens at the start
        return
    end
    ---------------------------
    -- local str = [[<center><font color='#b3b3b3'>]] .. prefix .. [[: <font color="]] .. color .. [[">]]
    -- str = str .. "[" .. val .. ":" .. max .. "]</font></center>"
    -- return str
    -- end

    ------------------------------

    local str = [[<font color='#b3b3b3'>]] .. prefix .. [[:<font color="]] .. color .. [[">]]
    local str2 = str .. "[" .. val .. ":" .. max .. "]</font>"
    local color2 = "<font color='#404040'>"
    local color3 = "<font color='#00b3b5'>"

    --▍ ▌ ▋ ▉ █

    --local belki1 = "▋"
    --local belki2 = "▋▋"
    --local belki3 = "▋▋▋"
    --local belki4 = "▋▋▋▋"
    --local belki5 = "▋▋▋▋▋"
    --local belki6 = "▋▋▋▋▋▋"
    --local belki7 = "▋▋▋▋▋▋▋"
    --local belki8 = "▋▋▋▋▋▋▋▋"
    --local belki9 = "▋▋▋▋▋▋▋▋▋"

    local belki1 = "▉"
    local belki2 = "▉▉"
    local belki3 = "▉▉▉"
    local belki4 = "▉▉▉▉"
    local belki5 = "▉▉▉▉▉"
    local belki6 = "▉▉▉▉▉▉"
    local belki7 = "▉▉▉▉▉▉▉"
    local belki8 = "▉▉▉▉▉▉▉▉"
    local belki9 = "▉▉▉▉▉▉▉▉▉"


    --local fbelki1 = "█"
    --local fbelki2 = "██"
    --local fbelki3 = "███▌"


    if val <= 15 and prefix == "Pos" then
        return str2

    elseif val == 7 and prefix == "Kon" then
        str = str .. "" .. belki7
    elseif val == 6 and prefix == "Kon" then
        str = str .. "" .. belki6 .. "" .. color2 .. "" .. belki1
    elseif val == 5 and prefix == "Kon" then
        str = str .. "" .. belki5 .. "" .. color2 .. "" .. belki2
    elseif val == 4 and prefix == "Kon" then
        str = str .. "" .. belki4 .. "" .. color2 .. "" .. belki3
    elseif val == 3 and prefix == "Kon" then
        str = str .. "" .. belki3 .. "" .. color2 .. "" .. belki4
    elseif val == 2 and prefix == "Kon" then
        str = str .. "" .. belki2 .. "" .. color2 .. "" .. belki5
    elseif val == 1 and prefix == "Kon" then
        str = str .. "" .. belki1 .. "" .. color2 .. "" .. belki6


    elseif val == 8 and prefix == "Man" then
        str = str .. "" .. color3 .. "" .. belki8
    elseif val == 7 and prefix == "Man" then
        str = str .. "" .. color3 .. "" .. belki7 .. "" .. color2 .. "" .. belki1
    elseif val == 6 and prefix == "Man" then
        str = str .. "" .. belki6 .. "" .. color2 .. "" .. belki2
    elseif val == 5 and prefix == "Man" then
        str = str .. "" .. belki5 .. "" .. color2 .. "" .. belki3
    elseif val == 4 and prefix == "Man" then
        str = str .. "" .. belki4 .. "" .. color2 .. "" .. belki4
    elseif val == 3 and prefix == "Man" then
        str = str .. "" .. belki3 .. "" .. color2 .. "" .. belki5
    elseif val == 2 and prefix == "Man" then
        str = str .. "" .. belki2 .. "" .. color2 .. "" .. belki6
    elseif val == 1 and prefix == "Man" then
        str = str .. "" .. belki1 .. "" .. color2 .. "" .. belki7
    elseif val == 0 and prefix == "Man" then
        str = str .. "" .. color2 .. "" .. belki8



    elseif val == 9 and prefix == "Zme" then
        str = str .. "" .. belki9
    elseif val == 8 and prefix == "Zme" then
        str = str .. "" .. belki8 .. "" .. color2 .. "" .. belki1
    elseif val == 7 and prefix == "Zme" then
        str = str .. "" .. belki7 .. "" .. color2 .. "" .. belki2
    elseif val == 6 and prefix == "Zme" then
        str = str .. "" .. belki6 .. "" .. color2 .. "" .. belki3
    elseif val == 5 and prefix == "Zme" then
        str = str .. "" .. belki5 .. "" .. color2 .. "" .. belki4
    elseif val == 4 and prefix == "Zme" then
        str = str .. "" .. belki4 .. "" .. color2 .. "" .. belki5
    elseif val == 3 and prefix == "Zme" then
        str = str .. "" .. belki3 .. "" .. color2 .. "" .. belki6
    elseif val == 2 and prefix == "Zme" then
        str = str .. "" .. belki2 .. "" .. color2 .. "" .. belki7
    elseif val == 1 and prefix == "Zme" then
        str = str .. "" .. belki1 .. "" .. color2 .. "" .. belki8
    elseif val == 0 and prefix == "Zme" then
        str = str .. "" .. color2 .. "" .. belki9

    elseif val == 6 and prefix == "Prz" then
        str = str .. "" .. belki6
    elseif val == 5 and prefix == "Prz" then
        str = str .. "" .. belki5 .. "" .. color2 .. "" .. belki1
    elseif val == 4 and prefix == "Prz" then
        str = str .. "" .. belki4 .. "" .. color2 .. "" .. belki2
    elseif val == 3 and prefix == "Prz" then
        str = str .. "" .. belki3 .. "" .. color2 .. "" .. belki3
    elseif val == 2 and prefix == "Prz" then
        str = str .. "" .. belki2 .. "" .. color2 .. "" .. belki4
    elseif val == 1 and prefix == "Prz" then
        str = str .. "" .. belki1 .. "" .. color2 .. "" .. belki5
    elseif val == 0 and prefix == "Prz" then
        str = str .. "" .. color2 .. "" .. belki6

    elseif val == 5 and prefix == "Pan" then
        str = str .. "" .. belki5
    elseif val == 4 and prefix == "Pan" then
        str = str .. "" .. belki4 .. "" .. color2 .. "" .. belki1
    elseif val == 3 and prefix == "Pan" then
        str = str .. "" .. belki3 .. "" .. color2 .. "" .. belki2
    elseif val == 2 and prefix == "Pan" then
        str = str .. "" .. belki2 .. "" .. color2 .. "" .. belki3
    elseif val == 1 and prefix == "Pan" then
        str = str .. "" .. belki1 .. "" .. color2 .. "" .. belki4
    elseif val == 0 and prefix == "Pan" then
        str = str .. "" .. color2 .. "" .. belki5

    elseif val == 6 and prefix == "Kac" then
        str = str .. "" .. belki6
    elseif val == 5 and prefix == "Kac" then
        str = str .. "" .. belki5 .. "" .. color2 .. "" .. belki1
    elseif val == 4 and prefix == "Kac" then
        str = str .. "" .. belki4 .. "" .. color2 .. "" .. belki2
    elseif val == 3 and prefix == "Kac" then
        str = str .. "" .. belki3 .. "" .. color2 .. "" .. belki3
    elseif val == 2 and prefix == "Kac" then
        str = str .. "" .. belki2 .. "" .. color2 .. "" .. belki4
    elseif val == 1 and prefix == "Kac" then
        str = str .. "" .. belki1 .. "" .. color2 .. "" .. belki5
    elseif val == 0 and prefix == "Kac" then
        str = str .. "" .. color2 .. "" .. belki6

    elseif val == 3 and prefix == "For" then
        str = str .. "" .. belki3
    elseif val == 2 and prefix == "For" then
        str = str .. "" .. belki2 .. "" .. color2 .. "" .. belki1
    elseif val == 1 and prefix == "For" then
        str = str .. "" .. belki1 .. "" .. color2 .. "" .. belki2
    elseif val == 0 and prefix == "For" then
        str = str .. "" .. color2 .. "" .. belki3

    elseif val == 10 and prefix == "Upi" then
        str = str .. "" .. belki9
    elseif val == 9 and prefix == "Upi" then
        str = str .. "" .. belki9
    elseif val == 8 and prefix == "Upi" then
        str = str .. "" .. belki8 .. "" .. color2 .. "" .. belki1
    elseif val == 7 and prefix == "Upi" then
        str = str .. "" .. belki7 .. "" .. color2 .. "" .. belki2
    elseif val == 6 and prefix == "Upi" then
        str = str .. "" .. belki6 .. "" .. color2 .. "" .. belki3
    elseif val == 5 and prefix == "Upi" then
        str = str .. "" .. belki5 .. "" .. color2 .. "" .. belki4
    elseif val == 4 and prefix == "Upi" then
        str = str .. "" .. belki4 .. "" .. color2 .. "" .. belki5
    elseif val == 3 and prefix == "Upi" then
        str = str .. "" .. belki3 .. "" .. color2 .. "" .. belki6
    elseif val == 2 and prefix == "Upi" then
        str = str .. "" .. belki2 .. "" .. color2 .. "" .. belki7
    elseif val == 1 and prefix == "Upi" then
        str = str .. "" .. belki1 .. "" .. color2 .. "" .. belki8
    elseif val == 0 and prefix == "Upi" then
        str = str .. "" .. color2 .. "" .. belki9

    elseif val == 3 and prefix == "Glo" then
        str = str .. "" .. belki4
    elseif val == 2 and prefix == "Glo" then
        str = str .. "" .. belki3 .. "" .. color2 .. "" .. belki1
    elseif val == 1 and prefix == "Glo" then
        str = str .. "" .. belki2 .. "" .. color2 .. "" .. belki2
    elseif val == 0 and prefix == "Glo" then
        str = str .. "" .. belki1 .. "" .. color2 .. "" .. belki3


    elseif val == 3 and prefix == "Pra" then
        str = str .. "" .. belki4
    elseif val == 2 and prefix == "Pra" then
        str = str .. "" .. belki3 .. "" .. color2 .. "" .. belki1
    elseif val == 1 and prefix == "Pra" then
        str = str .. "" .. belki2 .. "" .. color2 .. "" .. belki2
    elseif val == 0 and prefix == "Pra" then
        str = str .. "" .. belki1 .. "" .. color2 .. "" .. belki3

    elseif val == 0 and prefix == "Pos" then
        str = str .. "" .. str2
    end
    return str
end

