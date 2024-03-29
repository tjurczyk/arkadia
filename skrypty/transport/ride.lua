scripts.transports.ride = {}

local bar_height = 30
local bar_width = 350
local padding = 10

function scripts.transports.ride:new(id, definition, index, cleanup_callback)
    scripts:debug_log("Tworzenie obiektu podrozy: " .. id .. " " .. index, true)
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
    table.insert(self.triggers, tempExactMatchTrigger(self.definition.start, function() self:start() end))
end

function scripts.transports.ride:enter()
    self.on_board = true
    if self.definition.bind then
        scripts.utils.echobind(self.definition.bind, nil, self.definition.bind, "special_exit", 1)
        scripts.transports.transport_bind = self.definition.bind
    end
    registerAnonymousEventHandler("gmcp.room.info", function(_)
        if not gmcp.room.info.map then
            return true
        end
        self:exit()
    end, true)
end

function scripts.transports.ride:exit()
    self.on_board = false
    scripts.transports.transport_bind = nil
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
        self.triggers = {}
    end
    if self.stop_pattern then
        killTrigger(self.stop_pattern)
        self.stop_pattern = nil
    end
    if self.progress_timer then
        killTimer(self.progress_timer)
        self.progress_timer = nil
    end
    for _, handlerId in pairs(self.handlers) do
        killAnonymousEventHandler(handlerId)
        self.handlers = {}
    end
    self:hide_progress()
    self:cleanup_callback()
end

function scripts.transports.ride:start()
    if not self.on_board then
        return
    end
    if self.stop_pattern then
        killTrigger(self.stop_pattern)
    end
    self.stop_pattern = tempRegexTrigger(self.definition.stops[self.index].stop_pattern, function() self:stop() end, 1)
    self.start_time = os.time()
    if self.progress_timer then
        killTimer(self.progress_timer)
    end
    self:show_progress()
    self.progress_timer = tempTimer(0.25, function() self:update_progress() end, true)
end

function scripts.transports.ride:get_progress()
    return os.time() - self.start_time, self.definition.stops[self.index].time
end

function scripts.transports.ride:stop()
    local expected_time = self.definition.stops[self.index].time

    local delta = os.time() - self.start_time
    if delta < expected_time then
        scripts:debug_log("Czas podrozy krotszy niz znany do tej pory: " .. delta)
        self:store_new_minimum(delta)
    end

    raiseEvent("travelDestinationReached", self.definition.stops[self.index], self.definition, self)

    self.index = self.index >= #self.definition.stops and 1 or self.index + 1
    scripts.transports:remove_invalid_rides(self)
    if self.progress_timer then
        killTimer(self.progress_timer)
    end
    self.progress_timer = nil
    self:hide_progress()
end

function scripts.transports.ride:store_new_minimum(time)
    local times = scripts.transports:read_minimums()
    times[self.id] = times[self.id] or {}
    times[self.id][self.index] = math.min(time, tonumber(times[self.id][self.index]) or 99999)
    self.definition.stops[self.index].time = math.min(time, self.definition.stops[self.index].time)
    scripts.transports:store_minimums(times)
end

function scripts.transports.ride:show_progress()
    if not scripts.transports.show_progress then
        return
    end
    local border_bottom = getBorderBottom()
    local border_right = getBorderRight()

    self.progress = Geyser.Gauge:new({
        name = string.format("transport.progress.%s.%s", self.id, self.index),
        x = -border_right - padding * 2 - bar_width - 20,
        y = -border_bottom - padding + (-padding * 2 - bar_height ) * table.index_of(scripts.transports.active_rides, self),
        height = bar_height,
        width = bar_width,
        fontSize = getFontSize() - 1,
        font = getFont()
    })

    Ui.setGaugeStyle(self.progress, 42, 28, 15, 3.5, 'SIMPLE', getFontSize() - 1, "")

    self:update_progress()
end

function scripts.transports.ride:update_progress()
    if not self.progress then return end
    local current, total = self:get_progress()
    local current_stop = self.definition.stops[self.index]
    if current > (total * 6) then
        scripts:print_log("Cos poszlo nie tak. Zglos blad zwiazany z przejazdem srodkiem transportu. ID: " .. self.id .. " - " .. current_stop)
        self:exit()
        self:abort()
        return
    end
    local label = current_stop.label and "→ " .. current_stop.label or string.format("%s → %s", current_stop.start, current_stop.destination)
    if self.definition.show_path then
        local path = getPath(current_stop.start, current_stop.destination)
        if path then
            local percentage = math.min(current, total) / total
            raiseEvent("rideProgress", self, speedWalkPath[math.floor(percentage * #speedWalkPath)])
        end
    end
    self.progress:setValue(math.min(current, total), total, string.format("<center>%s %s/%s</center>", label, scripts.utils.str_pad(tostring(current), string.len(tostring(total)), "right"), total))
end

function scripts.transports.ride:hide_progress()
    if self.progress then
        self.progress:hide()
    end
end