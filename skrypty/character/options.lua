scripts.character.options = scripts.character.options or {values = {}}

local command = "char.options {\"%s\" : %s}"

function scripts.character.options:init()
    self.handler = scripts.event_register:force_register_event_handler(
                       self.handler, "gmcp.char.options",
                       function() self:handle_options() end)
end

function scripts.character.options:handle_options()
    self.values = table.update(self.values, gmcp.char.options)
end

function scripts.character.options:set_temporary(option, value)
    local original_value = scripts.character.options.values[option]
    sendGMCP(string.format(command, option, value))
    return function()
        sendGMCP(string.format(command, option, original_value))
    end
end

scripts.character.options:init()
