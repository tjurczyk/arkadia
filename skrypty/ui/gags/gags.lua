scripts.gags = scripts.gags or {
    own_spec_prefix = ""
}

local combat_types = {
    "combat.avatar",
    "combat.team",
    "combat.others",
    "room.combat"
}

function scripts.gags:is_combat()
    return gmcp and gmcp.gmcp_msgs and table.index_of(combat_types, gmcp.gmcp_msgs.type)
end

function scripts.gags:is_type(type)
    return gmcp and gmcp.gmcp_msgs and gmcp.gmcp_msgs.type == type
end

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
    if selectString(str_replace, 1) > -1 then
        fg(scripts.gag_colors[kind])

        if scripts.debug then
            local i = 2
            local hint = ""
            repeat
                local dbFunc = debug.getinfo(i)
                hint = hint .. (dbFunc.name or dbFunc.short_src or dbFunc.short or "") .. " "
                i = i + 1
            until i > 4
            setLink(function() end, hint)
        end
    end
    resetFormat()
end

function scripts.gags:delete_line(kind)
    if scripts.gag_settings[kind] == 1 then
        deleteLine()
        return true
    end
end

function scripts.gags:who_hits()
    local who
    if self:is_type("combat.avatar") then
        who = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "moje_ciosy"
    else
        who = "innych_ciosy"
    end
    return who
end

-- Same as who_hits but relies on values in matches
function scripts.gags:who_hits_attacker_target()
    if self:is_type("combat.avatar") then
        if matches["attacker"] then return "innych_ciosy_we_mnie" else return "moje_ciosy" end
    else return "innych_ciosy" end
end

function scripts.gags:attacker_target(value, total_power)
    if total_power == nil then total_power = 6 end
    local target = self:who_hits_attacker_target()
    self:gag(value, total_power, target)
end

function scripts.gags:attacker_target_fin()
    local target = self:who_hits_attacker_target()
    self:gag_prefix(self.fin_prefix, target)
end