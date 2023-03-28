Highlight = {}

function Highlight:new(location_ids, color1_rgb_table, color2_rgb_table)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.location_ids = {}
    if location_ids then
        for _, location_id in pairs(location_ids) do
            location_ids[location_id] = location_id
        end
    end
    o.color1_rgb_table = color1_rgb_table or { 255, 255, 255 }
    o.color2_rgb_table = color2_rgb_table or { 10, 30, 150 }
    o.enabled = false
    return o
end

function Highlight:on()
    for location_id, _ in pairs(self.location_ids) do
        self:highlight_location(tonumber(location_id), self.color1_rgb_table, self.color2_rgb_table)
    end
    self.enabled = true
end

function Highlight:highlight_location(location_id, color1_rgb_table, color2_rgb_table)
    highlightRoom(location_id, color1_rgb_table[1], color1_rgb_table[2], color1_rgb_table[3], color2_rgb_table[1], color2_rgb_table[2], color2_rgb_table[3], 0.85, 255, 0)
end

function Highlight:off()
    for location_id, _ in pairs(self.location_ids) do
        unHighlightRoom(tonumber(location_id))
    end
    self.enabled = false
end

function Highlight:toggle()
    if self.enabled then
        self:off()
    else
        self:on()
    end
end

function Highlight:add_location(location_id)
    self.location_ids[location_id] = location_id
    self:highlight_location(tonumber(location_id), self.color1_rgb_table, self.color2_rgb_table)
end

function Highlight:remove_location(location_id)
    self.location_ids[location_id] = nil
    unHighlightRoom(tonumber(location_id))
end

function Highlight:clear()
    self:off()
    self.location_ids = {}
end

function Highlight:set_locations(location_table)
    self:off()
    for _, location_id in pairs(location_table) do
        self.location_ids[location_id] = true
    end
    self:refresh()
end

function Highlight:refresh()
    local status = self.enabled
    self:off()
    self.enabled = status
    if self.enabled then
        self:on()
    end
end

