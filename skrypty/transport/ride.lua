scripts.transports.ride = {}

function scripts.transports.ride:new(definition, index, cleanup_callback)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.definition = definition
    o.index = index
    o.on_board = false
    o.cleanup_callback = cleanup_callback
    o.triggers = {}
    o:init()
    o:initate_cleanup()
    return o
end

function scripts.transports.ride:init()
    table.insert(self.triggers, tempExactMatchTrigger(self.definition.enter, function() self:enter() end))
    table.insert(self.triggers, tempExactMatchTrigger(self.definition.exit, function() self:exit() end))
    table.insert(self.triggers, tempExactMatchTrigger(self.definition.start, function() self:start() end))
end

function scripts.transports.ride:enter()
    self.on_board = true
end

function scripts.transports.ride:exit()
    self.on_board = false
    self:initate_cleanup()
end

function scripts.transports.ride:initate_cleanup()
    if not self.timer then
        self.timer = tempTimer(30, function() self:abort() end)
    end
end

function scripts.transports.ride:abort()
    if not self.on_board then
        self:cleanup()
    else
        self.timer = nil
    end
end

function scripts.transports.ride:cleanup()
    for _, triggerId in pairs(self.triggers) do
        killTrigger(triggerId)
    end
    if self.stop_pattern then
        killTrigger(self.stop_pattern)
    end
    if self.progress_timer then
        killTimer(self.progress_timer)
    end
    self:cleanup_callback()
end

function scripts.transports.ride:start()
    if self.stop_pattern then
        killTrigger(self.stop_pattern)
    end
    self.stop_pattern = tempRegexTrigger(self.definition.stops[self.index].stop_pattern, function() self:stop() end, 1)
    self.start_time = os.time()
    if self.progress_timer then
        killTimer(self.progress_timer)
    end
    self.progress_timer = tempTimer(1, function() self:show_progress() end, true)
end

function scripts.transports.ride:show_progress()
    scripts:print_log(string.format("%s/%s", os.time() - self.start_time, self.definition.stops[self.index].time))
end

function scripts.transports.ride:stop()
    local expected_time = self.definition.stops[self.index].time
    self.index = self.index >= #self.definition.stops and 1 or self.index + 1
    scripts.transports:remove_invalid_rides(self)
    if self.progress_timer then
        killTimer(self.progress_timer)
    end
    self.progress_timer = nil
    local delta = os.time() - self.start_time
    if delta < expected_time then
        scripts:print_log("Czas plyniecia " .. delta)
    end
end