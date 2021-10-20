MudletBase = {}

function MudletBase:new(o)
    o = o or {}
    if o.handlers then
        for _, id in pairs(o.handlers) do
            scripts.event_register:kill_event_handler(id)
        end
    end
    if o.triggers then
        for _, triggerId in pairs(o.triggers) do
            killTrigger(triggerId)
        end
    end
    setmetatable(o, self)
    self.__index = self
    self.handlers = {}
    self.triggers = {}
    return o
end

function MudletBase:register_event(event, handler, onetime)
    handler = handler or function(...) self:event_handler(unpack(arg)) end
    self.handlers[event] = scripts.event_register:force_register_event_handler(self.handlers[event], event, handler, onetime)
end

function MudletBase:event_handler(...)
    local event = table.remove(arg, 1)
    local snake_case = event:gsub('(%u)', '_%1'):lower()
    display(self)
    if self[event] then
        self[event](self, unpack(arg))
    end
    if self[snake_case] then
        self[snake_case](self, unpack(arg))
    end
end

function MudletBase:register_trigger(triggerId)
    table.insert(self.triggers, triggerId)
end
