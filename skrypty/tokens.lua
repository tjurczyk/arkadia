scripts.tokens = scripts.tokens or {
    registered = {}
}

function scripts.tokens:register(substring, callback)
    local key = self:get_key()
    local tokens = substring:lower():split(" ")
    local current_table = self.registered
    for _, value in ipairs(tokens) do
        current_table[value] = current_table[value] or {}
        current_table = current_table[value]
    end
    current_table.callbacks = current_table.callbacks or {}
    current_table.callbacks[key] = function(current_match) callback(current_match) end
end

function scripts.tokens:process_line(msg)
    if table.is_empty(self.registered) then
        return
    end
    local tokens = ansi2string(msg):gsub("%.", ""):gsub("[,!?-]", ""):gsub("\t", ""):gsub("\n", ""):split("[ /]")
    for i = 1, #tokens, 1 do
        local current_match = {}
        local current_table = self.registered
        for j = i, #tokens, 1 do
            current_table = current_table[tokens[j]:lower()]
            if current_table then
                table.insert(current_match, tokens[j])
                if current_table.callbacks then
                    for key, callback in pairs(current_table.callbacks) do
                       callback(table.concat(current_match, " "))
                    end
                end
            else
                current_match = {}
                break
            end
        end
    end
end

function scripts.tokens:get_key()
    local caller = debug.getinfo(3)
    return string.format("%s:%s", caller.source or "", caller.currentline or "")
end
