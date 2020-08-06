ateam.last_seen_hp = ateam.last_seen_hp or {}

function ateam.last_seen_hp:get_by_desc(desc)
    for _, obj in pairs(ateam.objs) do
        if obj.desc == desc then
            scripts:print_log(desc .. ", ostatnio widziana kondycja -> [" .. states[obj.hp] .. "<tomato>]")
            return
        end
    end
    scripts:print_log("Nie znaleziono takiego opisu/imienia")
end

function alias_func_last_seen_hp(desc)
    ateam.last_seen_hp:get_by_desc(desc)
end