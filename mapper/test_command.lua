-- for special exits
function test_command(_, command)
    local startswith_sneaky = string.sub(command, 1, 10) == "przemknij "
    local startswith_sneaky_team = string.sub(command, 1, 20) == "przemknij z druzyna "
    local after_sneaky = nil
    if startswith_sneaky_team then
        after_sneaky = string.sub(command, 21)
    elseif startswith_sneaky then
        after_sneaky = string.sub(command, 11)
    end

    if not amap.polish_to_english[command] and not amap.short_to_long[command] and
            not amap.polish_to_english[after_sneaky] and not amap.short_to_long[after_sneaky] and amap.mode == "follow" then
        if after_sneaky then
            local ret_val = amap:follow(after_sneaky, false)
        else
            local ret_val = amap:follow(command, false)
        end

        if amap.special_exits[command] then
            scripts.ui:info_hidden_update("")
        end
    end
end

if scripts.event_handlers["mapper/test_command.sysDataSendRequest.test_command"] then
    killAnonymousEventHandler(scripts.event_handlers["mapper/test_command.sysDataSendRequest.test_command"])
end

scripts.event_handlers["mapper/test_command.sysDataSendRequest.test_command"] = registerAnonymousEventHandler("sysDataSendRequest", test_command)

