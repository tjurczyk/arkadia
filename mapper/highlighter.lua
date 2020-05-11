Highlight = {}

function Highlight:new(locations, color1, color2)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.locations = locations or {}
    o.color1 = color1 or {255, 255, 255}
    o.color2 = color2 or {10, 30, 150}
    enabled = false
    return o
end

function Highlight:on()
    local color1 = self.color1
    local color2 = self.color2
    for k,v in pairs(self.locations) do
        highlightRoom(tonumber(v), color1[1], color1[2], color1[3], color2[1], color2[2], color2[3], 0.85, 255, 255)
    end
    self.enabled = true
end

function Highlight:off()
    for k,v in pairs(self.locations) do
        unHighlightRoom( tonumber(v) )
    end
    self.enabled = false
end

function Highlight:add_location(location)
    table.insert(self.locations, location)
    self:refresh()
end

function Highlight:set_locations(locations)
    self:off()
    self.locations = locations
    self:refresh()
end

function Highlight:refresh()
    self:off()
    if self.enabled then
        self.on()
    end
end

