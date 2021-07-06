scripts.transports.ride = {}

local bar_height = 30
local bar_width = 300
local padding = 10

function scripts.transports.ride:new(id, definition, index, cleanup_callback)
    scripts:print_log("Creating ride " .. id .. " " .. index, true)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.id = id
    o.definition = definition
    o.index = index
    o.on_board = false
    o.cleanup_callback = cleanup_callback
    o.triggers = {}
    o.handlers = {}
    o:init()
    o:initate_cleanup()
    return o
end

function scripts.transports.ride:init()
    table.insert(self.triggers, tempExactMatchTrigger(self.definition.enter, function() self:enter() end))
    if self.definition.exit then
        table.insert(self.triggers, tempExactMatchTrigger(self.definition.exit, function() self:exit() end))
    end
    if self.definition.exit_command then
        table.insert(self.handlers, registerAnonymousEventHandler("sysDataSendRequest", function(_, command) 
            if self.definition.exit_command ~= command then
                return
            end
            registerAnonymousEventHandler("gmcp.room.info", function(_)
                self:exit()
            end, true)
        end), true)
    end
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
    for _, handlerId in pairs(self.handlers) do
        killAnonymousEventHandler(handlerId)
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

    local delta = os.time() - self.start_time
    if delta < expected_time then
        scripts:print_log("Czas podrozy " .. delta)
    end

    self.index = self.index >= #self.definition.stops and 1 or self.index + 1
    scripts.transports:remove_invalid_rides(self)
    if self.progress_timer then
        killTimer(self.progress_timer)
    end
    self.progress_timer = nil
    self:hide_progress()
end

function scripts.transports.ride:show_progress()
    local border_bottom = getBorderBottom()
    local border_right = getBorderRight()
    
    self.progress = Geyser.Gauge:new({
        name = string.format("transport.progress.%s.%s", self.id, self.index),
        x = -border_right - padding * 2 - bar_width,
        y = -border_bottom - padding + (-padding * 2 - bar_height ) * table.index_of(scripts.transports.active_rides, self),
        height = bar_height,
        width = bar_width,
        fontSize = getFontSize() - 1,
        font = getFont()
    })

    self:update_progress()
end

function scripts.transports.ride:update_progress()
    local current, total = self:get_progress()
    self.progress:setValue(math.min(current, total), total, string.format("<pre><center>%s -> %s   %s/%s</center></pre>", self.definition.stops[self.index].start, self.definition.stops[self.index].destination, scripts.utils.str_pad(tostring(current), string.len(tostring(total)), "right"), total))
end

function scripts.transports.ride:hide_progress()
    self.progress:hide()
end