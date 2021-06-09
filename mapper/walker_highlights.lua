amap.walker_highlights = amap.walker_highlights or {
    event_handlers = {}
}

function amap.walker_highlights:register_events()
    self.handler_s = scripts.event_register:force_register_event_handler(self.handler_s, "amapWalkerStarted", function() self:start() end)
    self.handler_t = scripts.event_register:force_register_event_handler(self.handler_t, "amapWalkerTerminated", function() self:finish() end)
    self.handler_f = scripts.event_register:force_register_event_handler(self.handler_f, "amapWalkerFinished", function() self:finish() end)
end

function amap.walker_highlights:deregister_events()
   scripts.event_register:kill_event_handler(self.handler_s)
   scripts.event_register:kill_event_handler(self.handler_t)
   scripts.event_register:kill_event_handler(self.handler_f)
end

function amap.walker_highlights:start()
    amap.path_display:start(speedWalkPath[#speedWalkPath])
end

function amap.walker_highlights:finish()
    amap.path_display:stop()
end

amap.walker_highlights:register_events()