local img_path = getMudletHomeDir() .. "/arkadia/ui/assets/"

scripts.ui.combat_window = scripts.ui.combat_window or {
    font_size = getFontSize(),
    enabled = true,
    name = "combat_window",
    separate_combat_window = true,
    captures = {
        ["combat.avatar"] = true,
        ["combat.team"] = true,
        ["combat.others"] = true,
        ["hp"] = true
    }
}

function scripts.ui.combat_window:init()
    if scripts.ui.combat_window.enabled then
        self.window = scripts.ui.window:new(self.name, "Walka")
        self.window:add_buttons(function() self:create_buttons() end)
        self.window:set_font_size(getFontSize() - 2)
    end
    self.handler = scripts.event_register:force_register_event_handler(self.handler, "gmcp.room.info", function()
        moveCursor(self.name, 0, getLastLineNumber(self.name) - 2)
        if getCurrentLine(self.name) ~= "------------------" and not table.contains({"zerknij", "spojrz", "sp"}, scripts.last_send) then
            cecho(self.name, "\n<:transparent>------------------\n\n")
        end
    end)
    self.captures = scripts.state_store:get(self.name) or self.captures
end

function scripts.ui.combat_window:create_buttons()
    local buttons = {
        { label = "Swoja", type  = "combat.avatar" },
        { label = "Druzyny", type  = "combat.team" },
        { label = "Innych", type  = "combat.others" },
        { label = "Kondycje", type = "hp"}
    }

    local base = 30
    for _, value in ipairs(buttons) do
        local label_id = "toggle_" .. value.type
        local button = scripts.ui.toggle_button:new(label_id, value.label, base, 14, self:should_capture(value.type), function(toggled)
            scripts.ui.combat_window:toggle_type(value.type, toggled)
            cecho("combat_window", string.format("%s: <%s>%s<reset>\n", value.label, toggled and "green" or "red", toggled and "ON" or "OFF"))
            scripts.state_store:set(self.name, self.captures)
        end, self.name)
        base = base + 90 + 10
    end
end

function scripts.ui.combat_window:process(msg)
    if gmcp.gmcp_msgs and scripts.ui.combat_window:should_capture(gmcp.gmcp_msgs.type) then
        local numberOfExtraLines = getLineCount() - getLineNumber()
        for i = 1, numberOfExtraLines, 1 do
            selectCurrentLine()
            copy()
            appendBuffer(scripts.ui.combat_window.name)
            deleteLine()
        end
    end
    if scripts.ui.combat_window:should_capture("hp") and rex.match(ansi2string(msg), "[Jj]est(?:es)? (?:ledwo zyw(?:y|a)|ciezko rann(?:y|a)|w zlej kondycji|rann(?:y|a)|lekko rann(?:y|a)|w dobrym stanie|w swietnej kondycji)") then
        decho(self.name, ansi2decho(msg))
    end
end

function scripts.ui.combat_window:toggle_type(type, value)
    self.captures[type] = value
    return self.captures[type]
end

function scripts.ui.combat_window:should_capture(type)
    return self.captures[type]
end

scripts.ui.combat_window:init()
