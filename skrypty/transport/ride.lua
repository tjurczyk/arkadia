scripts.transports.ride = {}

function scripts.transports.ride:new(definition, index)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.definition = definition
    o.node = index
    return o
end