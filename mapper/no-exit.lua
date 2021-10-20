amap.no_exit = MudletBase:new(amap.no_exit)

function amap.no_exit:init()
    self:register_event("amapNewLocation")
end

function amap.no_exit
    :amap_new_location(new, old)
    display(new)
    display(old)
end

amap.no_exit:init()