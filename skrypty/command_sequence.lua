CommandSequence = CommandSequence or {}

function CommandSequence:new(...)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.commands = table.n_flatten{...}
    return o
end

function CommandSequence:add(command)
    table.insert(self.commands, command)
end

function CommandSequence:get_next()
    return table.remove(self.commands, 1)
end

function CommandSequence:send_next(silent)
    local next = self:get_next()
    if next then
        expandAlias(next)
    elseif not silent then
        scripts:print_log("Wszystkie komendy z sekwencji wykonane")
    end
end

function CommandSequence:has_next()
    return self.commands[1]
end

function CommandSequence:print()
    scripts:print_log("Komendy" .. table.concat(self.commands, ";"), true)
end