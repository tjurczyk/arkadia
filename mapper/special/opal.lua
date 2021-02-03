amap.opal = amap.opal or {
    handler = nil,
    connected_id = false
}

local up_location = 17253

function amap.opal:init()
    self.handler = scripts.event_register:register_singleton_event_handler(self.handler, "amapNewLocation", function(event, location_id, dir) self:bind_exit(location_id, dir) end, false)
end

function amap.opal:bind_exit(location_id, dir)
    if location_id ~= up_location then
        return
    end
    if dir == "down" then
        self.connected_id = amap.prev.id
    elseif dir == "up" and self.connected_id then
        amap:set_position(self.connected_id, true)
    end
end

amap.opal:init()