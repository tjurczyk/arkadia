function gmcp_msgs()
    feedTriggers(dec(gmcp.gmcp_msgs.text))
    if scripts.ui.separate_talk_window and scripts.ui.separate_talk_window_msg_types[gmcp.gmcp_msgs.type] then
        local timestamp = ""
        if scripts.ui.separate_talk_window_timestamp and string.trim(scripts.ui.separate_talk_window_timestamp) ~= "" then
            timestamp = string.format("[%s] ", os.date(scripts.ui.separate_talk_window_timestamp))
        end
        
        decho("talk_window", timestamp .. scripts.ui.separate_talk_window_prefix .. ansi2decho(dec(gmcp.gmcp_msgs.text)))
    end
end

if scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"])
end

scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"] = registerAnonymousEventHandler("gmcp.gmcp_msgs", gmcp_msgs)

