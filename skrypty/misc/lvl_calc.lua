misc.lvl_calc = misc.lvl_calc or {}
misc.lvl_calc.current_stats = {}
misc.lvl_calc.current_val_to_next = {}

misc.lvl_calc.stat_to_number = {
    ["slabiutki"] = 1,
    ["slabiutka"] = 1,
    ["watly"] = 2,
    ["watla"] = 2,
    ["slaby"] = 3,
    ["slaba"] = 3,
    ["krzepki"] = 4,
    ["krzepka"] = 4,
    ["silny"] = 5,
    ["silna"] = 5,
    ["mocny"] = 6,
    ["mocna"] = 6,
    ["potezny"] = 7,
    ["potezna"] = 7,
    ["mocarny"] = 8,
    ["mocarna"] = 8,
    ["epicko silny"] = 9,
    ["epicko silna"] = 9,
    ["nieskoordynowany"] = 1,
    ["nieskoordynowana"] = 1,
    ["niezreczny"] = 2,
    ["niezreczna"] = 2,
    ["niezgrabny"] = 3,
    ["niezgrabna"] = 3,
    ["sprawny"] = 4,
    ["sprawna"] = 4,
    ["zwinny"] = 5,
    ["zwinna"] = 5,
    ["zreczny"] = 6,
    ["zreczna"] = 6,
    ["gibki"] = 7,
    ["gibka"] = 7,
    ["akrobatyczny"] = 8,
    ["akrobatyczna"] = 8,
    ["epicko zreczny"] = 9,
    ["epicko zreczna"] = 9,
    ["charlawy"] = 1,
    ["cherlawa"] = 1,
    ["rachityczny"] = 2,
    ["rachityczna"] = 2,
    ["mizerny"] = 3,
    ["mizerna"] = 3,
    ["dobrze zbudowany"] = 4,
    ["dobrze zbudowana"] = 4,
    ["wytrzymaly"] = 5,
    ["wytrzymala"] = 5,
    ["twardy"] = 6,
    ["twarda"] = 6,
    ["muskularny"] = 7,
    ["muskularna"] = 7,
    ["atletyczny"] = 8,
    ["atletyczna"] = 8,
    ["epicko wytrzymaly"] = 9,
    ["epicko wytrzymala"] = 9,
    ["bezmyslny"] = 1,
    ["bezmyslna"] = 1,
    ["tepy"] = 2,
    ["tepa"] = 2,
    ["ograniczony"] = 3,
    ["ograniczona"] = 3,
    ["pojetny"] = 4,
    ["pojetna"] = 4,
    ["inteligentny"] = 5,
    ["inteligentna"] = 5,
    ["bystry"] = 6,
    ["bystra"] = 6,
    ["blyskotliwy"] = 7,
    ["blyskotliwa"] = 7,
    ["genialny"] = 8,
    ["genialna"] = 8,
    ["epicko inteligenty"] = 9,
    ["epicko inteligenta"] = 9,
    ["thorzliwy"] = 1,
    ["thorzliwa"] = 1,
    ["strachliwy"] = 2,
    ["strachliwa"] = 2,
    ["niepewny"] = 3,
    ["niepewna"] = 3,
    ["zdecydowany"] = 4,
    ["zdecydowana"] = 4,
    ["odwazny"] = 5,
    ["odwazna"] = 5,
    ["dzielny"] = 6,
    ["dzielna"] = 6,
    ["nieugiety"] = 7,
    ["nieugieta"] = 7,
    ["nieustraszony"] = 8,
    ["nieustraszona"] = 8,
    ["epicko odwazny"] = 9,
    ["epicko odwazna"] = 9,
    ["nadludzki poziom"] = 10,
}

misc.lvl_calc["val_to_next_to_number"] = {
    ["bardzo duzo"] = 0,
    ["duzo"] = 1,
    ["troche"] = 2,
    ["niewiele"] = 3,
    ["bardzo niewiele"] = 4,
}

misc.lvl_calc["stat_to_index"] = {
    ["sile"] = 1,
    ["zrecznosc"] = 2,
    ["wytrzymalosc"] = 3,
    ["intelekt"] = 4,
    ["odwage"] = 5,
}

misc.lvl_calc["stat_to_real_lvl"] = {
    58,
    70,
    82,
    94,
    106,
    118,
    130,
    142,
    154,
    166,
    178,
    190,
}

misc.lvl_calc["real_lvl_string"] = {
    [1] = "ktos niedoswiadczony",
    [2] = "ktos kto widzial juz to i owo",
    [3] = "ktos kto pewnie stapa po swiecie",
    [4] = "ktos kto niejedno widzial",
    [5] = "ktos kto swoje przezyl",
    [6] = "ktos doswiadczony",
    [7] = "ktos kto wiele przeszedl",
    [8] = "ktos kto widzial kawal swiata",
    [9] = "ktos bardzo doswiadczony",
    [10] = "ktos kto zwiedzil caly swiat",
    [11] = "ktos wielce doswiadczony",
    [12] = "ktos kto widzial i doswiadczyl wszystkiego",
    [13] = "osoba owiana legenda",
}

function misc.lvl_calc:cechy()
    if self.is_running then
        -- juz uruchomione
        return
    end
    self.is_running = true

    misc.lvl_calc.current_stats = {}
    misc.lvl_calc.current_val_to_next = {}

    self.trigger1 = tempRegexTrigger("^Jestes ([a-z ]+) i ([a-z ]+) ci brakuje, zebys mogl(|a) wyzej ocenic sw(a|oj) ([a-z]+)\\.$", function() self:cechy_replace(matches[2], matches[3]) end, 5)
    self.trigger2 = tempRegexTrigger("^Tw.* osiagn.* (nadludzki poziom)\\.$", function() self:cechy_replace(matches[2]) end, 5)
    self.trigger3 = tempRegexTrigger("^Obecnie do waznych cech zaliczasz", function() 
        misc.lvl_calc:calculate_lvl()
        killTrigger(self.trigger1)
        killTrigger(self.trigger2)
        self.is_running = false
    end, 1)

    send('cechy', false)

    tempTimer(3, function()
        killTrigger(self.trigger1)
        killTrigger(self.trigger2)
        killTrigger(self.trigger3)
        self.is_running = false
    end)
 
end

function misc.lvl_calc:cechy_replace(m1, m2)
    local value, step= misc.lvl_calc:collect_stat(m1, m2)

    if selectString(m1, 1) > -1 then
        creplace(m1..' <green>['..value..'/10]')
    end
    if m1 and step and selectString(m2, 1) > -1 then
        creplace(m2..' <green>['..step..'/5]')
    end

    local sum = (value -1 ) * 5
    if step then sum = sum + step end
    cecho(' <green>['..sum..']')
end

function misc.lvl_calc:calculate_lvl()
    if not misc.lvl_calc.current_stats or not misc.lvl_calc.val_to_next_to_number or
            table.size(misc.lvl_calc.current_stats) == 0 or
            table.size(misc.lvl_calc.val_to_next_to_number) == 0 then
        return
    end

    -- Calculate full number of stats
    local full_stat = 0
    for k, v in pairs(misc.lvl_calc.current_stats) do
        full_stat = full_stat + (tonumber(v) - 1) * 5
    end

    -- add current stat lvls
    for k, v in pairs(misc.lvl_calc.current_val_to_next) do
        full_stat = full_stat + tonumber(v)
    end

    -- find current lvl
    local curr_lvl = 1
    for k, v in pairs(misc.lvl_calc.stat_to_real_lvl) do
        curr_lvl = k
        if full_stat < v then
            break
        end
    end

    local msg = nil

    misc.lvl_calc.full_stat = full_stat

    if full_stat < 190 then
        local missing = misc.lvl_calc.stat_to_real_lvl[curr_lvl] - full_stat
        msg = "Twoj aktualny poziom to <green>" .. misc.lvl_calc.real_lvl_string[curr_lvl] .. " (" .. tostring(full_stat) ..
                ")<tomato> i brakuje ci do nastepnego <green>" .. tostring(missing) .. "<tomato> podcech (<green>" ..
                misc.lvl_calc.real_lvl_string[curr_lvl + 1] .. "<tomato>)"
    else
        local extra = (full_stat - misc.lvl_calc.stat_to_real_lvl[curr_lvl])
        msg = string.format("Twoj aktualny poziom to <green> %s (%s) i masz + <green>%s<tomato> podcech", misc.lvl_calc.real_lvl_string[curr_lvl + 1], tostring(full_stat), tostring(extra))
    end

    scripts:print_log(msg, true)
end

function misc.lvl_calc:collect_stat(stat, val_to_next)
    local value = misc.lvl_calc.stat_to_number[stat]
    local step_value = nil
    table.insert(misc.lvl_calc["current_stats"], value)
    if val_to_next then
        step_value = misc.lvl_calc.val_to_next_to_number[val_to_next]
        table.insert(misc.lvl_calc["current_val_to_next"], step_value)
    end

    return value, step_value
end


function alias_func_skrypty_misc_lvl_calc_cechy()
    misc.lvl_calc:cechy()
end