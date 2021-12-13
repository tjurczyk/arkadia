misc["levels"] = {
    ["niedoswiadczonego."] = "[1/13]",
    ["kto widzial juz to i owo."] = "[2/13]",
    ["kto pewnie stapa po swiecie."] = "[3/13]",
    ["kto niejedno widzial."] = "[4/13]",
    ["kto swoje przezyl."] = "[5/13]",
    ["doswiadczonego."] = "[6/13]",
    ["kto wiele przeszedl."] = "[7/13]",
    ["kto widzial kawal swiata."] = "[8/13]",
    ["bardzo doswiadczonego."] = "[9/13]",
    ["kto zwiedzil caly swiat."] = "[10/13]",
    ["wielce doswiadczonego."] = "[11/13]",
    ["kto widzial i doswiadczyl wszystkiego."] = "[12/13]",
    ["owiana legenda"] = "[13/13]"
}

misc["animal_levels"] = {
    ["plochliwe"] = "[1/10]",
    ["nerwowe"] = "[2/10]",
    ["nieufne"] = "[3/10]",
    ["ulegle"] = "[4/10]",
    ["spokojne"] = "[5/10]",
    ["przywiazane"] = "[6/10]",
    ["ufne"] = "[7/10]",
    ["lojalne"] = "[8/10]",
    ["oddane"] = "[9/10]",
    ["calkowicie oddane"] = "[10/10]"
}

function misc:level_replace(text)
    if selectString(text, 1) > -1 then
        local add_text = " " .. misc.levels[text]
        replace(text .. add_text)
    end
    if selectString(misc.levels[text], 1) > -1 then
        fg("light_slate_blue")
        resetFormat()
    end
end

function misc:animal_level_replace(text)
    if selectString(text, 1) > -1 then
        local add_text = " " .. misc.animal_levels[text]
        replace(text .. add_text)
    end
    if selectString(misc.animal_levels[text], 1) > -1 then
        fg("light_slate_blue")
        resetFormat()
    end
end

function trigger_func_skrypty_misc_levels_scripts_knowledge()
    if matches[3] then
        misc.knowledge:knowledge_replace(matches[3])
    else
        misc.knowledge:knowledge_replace(matches[2])
    end
end

function trigger_func_skrypty_misc_levels_scripts_um()
    misc:skill_replace(matches[2])
end

function trigger_func_skrypty_misc_levels_poziomy_doswiadczenia()
    misc:level_replace(matches[4])
end

function trigger_func_skrypty_misc_levels_postepy()
    progress_replace(matches[3])
end

function trigger_func_skrypty_misc_levels_poziomy_zwierzat()
    misc:animal_level_replace(matches[2])
end

