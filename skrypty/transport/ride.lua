scripts.transports.ride = {}

local bar_height = 20
local bar_width = 200
local padding = 10

function scripts.transports.ride:new(id, definition, index, cleanup_callback)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.id = id
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
    self:show_progress()
    self.progress_timer = tempTimer(1, function() self:update_progress() end, true)
end

function scripts.transports.ride:get_progress()
    return os.time() - self.start_time, self.definition.stops[self.index].time
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
    self:hide_progress()
end

function scripts.transports.ride:show_progress()
    local border_bottom = getBorderBottom()
    local border_left = getBorderLeft()
    
    setBorderBottom(border_bottom + bar_height + padding * 4)
    
    self.progress = Geyser.Gauge:new({
        name = string.format("transport.progress.%s.%s", self.id, self.index),
        x = border_left + padding * 2,
        y = -border_bottom - padding * 4 - bar_height,
        height = bar_height,
        width = bar_width
    })


    self.progress.front:setStyleSheet([[
        background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #f04141, stop: 0.1 #ef2929, stop: 0.49 #cc0000, stop: 0.5 #a40000, stop: 1 #cc0000);
        padding: 3px;
    ]])

    self.progress.back:setStyleSheet([[
        background-color: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 #bd3333, stop: 0.1 #bd2020, stop: 0.49 #990000, stop: 0.5 #700000, stop: 1 #990000;
        padding: 3px;
    ]])


    self:update_progress()
end

function scripts.transports.ride:update_progress()
    local current, total = self:get_progress()
    self.progress:setValue(current, total, string.format("<center>%s -> %s   %s/%s</center>", self.definition.stops[self.index].start, self.definition.stops[self.index].destination, current, total))
end

function scripts.transports.ride:hide_progress()
    self.progress:hide()

    local border_bottom = getBorderBottom()
    setBorderBottom(border_bottom - bar_height - padding * 4)
end