misc.counter.utils = misc.counter or {}

misc.counter.utils.two_word_mobs = {
    "czarnego orka",
    "krasnoluda chaosu",
    "rycerza chaosu"
}

function misc.counter.utils:get_entry_key(key)
    -- Find the last key
    local l_keys = string.split(key, " ")
    local l_key

    if table.size(l_keys) == 4 and table.contains(misc.counter.utils.two_word_mobs, l_keys[3] .. " " .. l_keys[4])  then
        l_key = l_keys[3] .. " " .. l_keys[4]
    else
        l_key = l_keys[table.size(l_keys)]
    end
    return l_key
end
