scripts.tokens = scripts.tokens or {
    registered = {}
}

function scripts.tokens:register(substring, callback, key)
    local key = key or self:get_key()
    local tokens = substring:lower():split(" ")
    local current_table = self.registered
    for _, value in ipairs(tokens) do
        current_table[value] = current_table[value] or {}
        current_table = current_table[value]
    end
    current_table.callbacks = current_table.callbacks or {}
    current_table.callbacks[key] = callback
end

function scripts.tokens:process_line(msg)
    if table.is_empty(self.registered) then
        return
    end
    local tokens = table.n_filter(ansi2string(msg):split("[ \n\t%.,!%?%*()/%[%]]"), function(item) return item ~= "" end)
    local already_matched = {}
    for i = 1, #tokens, 1 do
        local current_match = {}
        local current_table = self.registered
        for j = i, #tokens, 1 do
            current_table = current_table[tokens[j]:lower()]
            if current_table then
                table.insert(current_match, tokens[j])
                if current_table.callbacks then
                    local full_string = table.concat(current_match, " ")
                    if not already_matched[full_string] then
                        already_matched[full_string] = true
                        for key, callback in pairs(current_table.callbacks) do
                            callback(full_string)
                        end
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

function scripts.tokens:process_token(what, callback, additional_checks)
    additional_checks = additional_checks or function() return true end
    local c, k = 1, 1
    while k > 0 do
        k = line:find(what, k)
        if k == nil then return; end
        c = c + 1
        if k == line:find("%f[%a]"..what.."%f[%A]", k) and additional_checks(what, k) then
        if selectString(what, c-1) > -1 then
           callback()
        else return end
        end
        k = k + 1
    end
end

function scripts.tokens:highlight(what, color, bold, underline, italicize)
    local c, k = 1, 1
    while k > 0 do
        k = line:find(what:gsub("%-", "%%-"), k)
        if k == nil then return; end
        c = c + 1
        if k == line:find("%f[%a]"..what:gsub("%-", "%%-").."%f[%A]", k) then
        if selectString(what, c-1) > -1 then
            if color     then fg(color) end
            if bold      then setBold(true) end
            if underline then setUnderline(true) end
            if italicize then setItalics(true) end
            resetFormat()
        else return end
        end
        k = k + 1
    end
end
