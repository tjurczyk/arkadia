amap.walker_highlights = amap.walker_highlights or {
    highlighter = Highlight:new({}, {255, 200, 150}, {150, 100, 255}),
    event_handlers = {}
}

function amap.walker_highlights:register_events()
    table.insert(self.event_handlers, scripts.event_register:register_event_handler("amapWalkerStarted", function() self:highlight_current_path() end))
    table.insert(self.event_handlers, scripts.event_register:register_event_handler("amapWalkerTerminated", function() self:clear_highlight() end))
    table.insert(self.event_handlers, scripts.event_register:register_event_handler("amapWalkerFinished", function() self:clear_highlight() end))
end

function amap.walker_highlights:deregister_events()
    for k,v in pairs(self.event_handlers) do
        scripts.event_register:kill_event_handler(v)
    end
end

function amap.walker_highlights:highlight_current_path()
    self.highlighter:set_locations(speedWalkPath)
    self.highlighter:on()
end

function amap.walker_highlights:clear_highlight()
    self.highlighter:clear()
end

amap.walker_highlights:register_events()

