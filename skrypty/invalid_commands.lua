scripts.invalid_commands = scripts.invalid_commands or {}

function scripts.invalid_commands:init()
    self.handler = scripts.event_register:force_register_event_handler(self.handler, "sysDataSendRequest", function(_, command) self:deny_invalid_send(command) end)
end

function scripts.invalid_commands:deny_invalid_send(command)
    scripts.last_send = command
    if string.sub(command,1,1) == "/" and string.sub(command,2,2) ~= " " then
        denyCurrentSend()
        scripts:print_log("Nieprawidlowy alias")
    end
end

scripts.invalid_commands:init()
