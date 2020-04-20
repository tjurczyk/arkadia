misc.counter.utils = misc.counter.utils or {}

misc.counter.utils.two_word_mobs = {
    "czarnego orka",
    "krasnoluda chaosu",
    "rycerza chaosu",
    "smoczego ogra"
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
