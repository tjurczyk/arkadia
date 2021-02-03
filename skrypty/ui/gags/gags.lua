scripts.gags = scripts.gags or {}

function scripts.gags:gag(power, total_power, kind)
    self:gag_prefix(string.format("%d/%d", power, total_power), kind)
end

function scripts.gags:gag_spec(prefix, power, total_power, kind)
    self:gag_prefix(string.format("%s %d/%d", prefix, power, total_power), kind)
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