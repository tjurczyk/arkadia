scripts.invalid_commands = scripts.invalid_commands or {}

function scripts.invalid_commands:init()
    self.handler = scripts.event_register:force_register_event_handler(self.handler, "sysDataSendRequest", function(_, command) self:deny_invalid_send(command) end)
end

function scripts.invalid_commands:deny_invalid_send(command)
    local s = command:find("/")
    if s and s > 1 then
        if scripts.last_send ~= command then
            denyCurrentSend()
            scripts:print_log("Na pewno chcesz wyslac ta komende? Ponow komende by wyslac.")
            scripts.last_send = command
            return
	end
    end
    scripts.last_send = command
    if string.sub(command,1,1) == "/" and string.sub(command,2,2) ~= " " then
        denyCurrentSend()
        scripts:print_log("Nieprawidlowy alias")
    end
end

scripts.invalid_commands:init()
