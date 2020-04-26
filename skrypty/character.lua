scripts.character.stats = scripts.character.stats or {}

function scripts.character.stats:after_death_progress()
    if selectString(matches[1], 1) > -1 then
        fg("SpringGreen")
    end

    if selectString(matches[2], 1) > -1 then
        fg("DeepSkyBlue")
    end
    progress_replace(matches[2])
end

function trigger_func_after_death_progress()
    scripts.character.stats:after_death_progress()
end
