function gmcp_msgs()
    --TODO extrat to more general method
    local msg = dec(gmcp.gmcp_msgs.text)
    feedTriggers(msg)
    if scripts.ui.separate_talk_window and scripts.ui.separate_talk_window_msg_types[gmcp.gmcp_msgs.type] then
        local timestamp = ""
        if scripts.ui.separate_talk_window_timestamp and string.trim(scripts.ui.separate_talk_window_timestamp) ~= "" then
            timestamp = string.format("[%s] ", os.date(scripts.ui.separate_talk_window_timestamp))
        end
        decho("talk_window", timestamp .. scripts.ui.separate_talk_window_prefix .. ansi2decho(dec(gmcp.gmcp_msgs.text)))
    end
    if gmcp.gmcp_msgs.type == "comm" then
        scripts.ui.talk_history:add(msg)
    end
    if gmcp.gmcp_msgs.type == "comm" then
        scripts.ui.talk_history:add(msg)
    end
    --TODO extrat to more general method
    if gmcp.gmcp_msgs.type == "room.short" then
        amap.localization.current_short = ansi2string(msg):gsub("\n", "")
    end
    if gmcp.gmcp_msgs.type == "room.exits" then
        amap.localization.current_exit = ansi2string(msg):gsub("\n", "")
    end
   
end

if scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"])
end

scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"] = registerAnonymousEventHandler("gmcp.gmcp_msgs", gmcp_msgs)
