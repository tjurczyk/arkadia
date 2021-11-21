scripts.mahakam = scripts.mahakam or {}

function scripts.mahakam:init()
    self.handler = scripts.event_register:force_register_event_handler(self.handler, "amapNewLocation", function(event, loc)
        if loc == 23948 then
            amap:locate_on_next_location(true)
            amap:init_self_locating(true)
        end
    end)
end

scripts.mahakam:init()