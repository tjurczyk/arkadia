amap.pausers = amap.pausers or {}

function amap.pausers:init()
    self.handler_data = scripts.event_register:register_singleton_event_handler(self.handler_data, "gmcp.objects.data", function() self:check_for_paralyzed() end)
end


function amap.pausers:check_for_paralyzed()
    local own_data = gmcp.objects.data[tostring(ateam.my_id)]
    if own_data and own_data.paralyzed ~= nil then
        self:toggle(own_data.paralyzed)
    end
    if own_data and own_data.editing ~= nil then
        self:toggle(own_data.editing)
    end
end

function amap.pausers:toggle(state)
    if state then
        self:on()
    else
        self:off()
    end
end

function amap.pausers:on()
    amap:mapper_off()
    amap.pauser_effective = true
    disableKey("temp_bind-")
    disableKey("temp_bind=")
    raiseEvent("amapPauserStarted")
    if scripts.character.bind_paralysis_breaker == true then
        scripts.utils.bind_functional("przestan", silent)
    end
end

function amap.pausers:off()
    amap:follow_mode(true)
    amap.pauser_effective = false
    enableKey("temp_bind-")
    enableKey("temp_bind=")
    raiseEvent("amapPauserStopped")
end

function trigger_func_mapper_pausers_on_pausers()
   amap.pausers:on()
end

function trigger_func_mapper_pausers_off_pausers()
    amap.pausers:off()
end

amap.pausers:init()

