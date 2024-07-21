misc.counter.utils = misc.counter.utils or {}

misc.counter.utils.two_word_mobs = {
    "czarnego orka",
    "dzikiego orka",
    "elfiego egzekutora",
    "kamiennego trolla",
    "konia bojowego",
    "krasnoluda chaosu",
    "lodowego trolla",
    "pajaka sieciarza",
    "pomiot chaosu",
    "rycerza chaosu",
    "smoczego ogra",
    "smoka chaosu",
    "straznika wiezy",
    "szkielet goblina",
    "szkielet krasnoluda",
    "szkielet orka",
    "tancerza wojny",
    "trolla gorskiego",
    "trolla jaskiniowego",
    "zjawe kobiety",
    "zjawe straznika",
    "zywiolaka ognia",
    "zywiolaka powietrza",
    "zywiolaka wody",
    "zywiolaka ziemi"
}

function misc.counter.utils:get_entry_key(key)
    -- Find killed key
    local l_keys = string.split(key, " ")
    local l_key

    if table.size(l_keys) == 4 and table.contains(misc.counter.utils.two_word_mobs, l_keys[3] .. " " .. l_keys[4])  then
        l_key = l_keys[3] .. " " .. l_keys[4]
    else
        l_key = l_keys[table.size(l_keys)]
    end
    return l_key
end

function misc.counter.utils:is_rare(type)
    local first_letter = type:sub(1, 1)
    return string.upper(first_letter) == first_letter
end