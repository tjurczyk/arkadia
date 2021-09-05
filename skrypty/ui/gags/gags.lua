scripts.gags = scripts.gags or {
    own_spec_prefix = ""
}

function scripts.gags:gag(power, total_power, kind)
    self:gag_prefix(string.format("%d/%d", power, total_power), kind)
end

function scripts.gags:gag_spec(prefix, power, total_power, kind)
    local own_prefix = prefix == "" and "" or prefix .. " "
    self:gag_prefix(string.format("%s%d/%d", own_prefix, power, total_power), kind)
end

function scripts.gags:gag_own_spec(power, total_power)
    if total_power then
        self:gag_spec(self.own_spec_prefix, power, total_power, "moje_spece")
    else
        local own_prefix = self.own_spec_prefix == "" and "" or self.own_spec_prefix .. " "
        self:gag_prefix(string.format("%s%s", own_prefix, power), "moje_spece")
    end
end

function scripts.gags:gag_prefix(gag_prefix, kind)
    if self:delete_line(kind) then
        return
    end
    selectCurrentLine()
    local str_replace = string.format("[%s] ", gag_prefix)
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors[kind])
    resetFormat()
end

function scripts.gags:delete_line(kind)
    if scripts.gag_settings[kind] == 1 then
        deleteLine()
        return true
    end
end