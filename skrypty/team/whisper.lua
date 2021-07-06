ateam.whisper = ateam.whisper or {}

function ateam.whisper:whisper_to_team(content)
    for k, v in pairs(ateam.team) do
        if type(v) == "number" and table_has_value(gmcp.objects.nums, v) then
            send(string.format("szepnij ob_%d %s", v, content))
        end
    end


end

function alias_func_last_seen_hp(content)
    ateam.whisper:whisper_to_team(content)
end