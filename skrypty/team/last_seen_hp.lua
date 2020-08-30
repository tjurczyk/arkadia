ateam.last_seen_hp = ateam.last_seen_hp or {
    hps = {},
    handler = "hp_check"
}

function ateam.last_seen_hp:init()
    self.handler = scripts.event_register:register_singleton_event_handler(self.handler, "gmcp_parsing_finished", function() ateam.last_seen_hp:collect_hp() end)
end

function ateam.last_seen_hp:get_by_desc(desc)
    local obj = self.hps[desc]
    if obj then
        scripts:print_log(desc .. ", ostatnio widziana kondycja -> [" .. states[obj] .. "<tomato>]")
        return
    end
    scripts:print_log("Nie znaleziono takiego opisu/imienia")
end

function ateam.last_seen_hp:collect_hp()
    for k, v in pairs(gmcp.objects.nums) do
        local obj = ateam.objs[tonumber(v)]
        if obj and obj.desc then
            self.hps[obj.desc] = obj.hp
        end
    end
end

function alias_func_last_seen_hp(desc)
    ateam.last_seen_hp:get_by_desc(desc)
end

ateam.last_seen_hp:init()