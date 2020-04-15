function gmcp_msgs()
    feedTriggers(dec(gmcp.gmcp_msgs.text))
    if scripts.ui.separate_talk_window and scripts.ui.separate_talk_window_msg_types[gmcp.gmcp_msgs.type] then
        --feedTriggers(dec(gmcp.gmcp_msgs.text))
        decho("talk_window", scripts.ui.separate_talk_window_prefix .. ansi2decho(dec(gmcp.gmcp_msgs.text)))
        --selectString(line, 1)
        --copy()
        --appendBuffer("talk_window")
        --deleteLine()
    end
end

if scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"])
end

scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"] = registerAnonymousEventHandler("gmcp.gmcp_msgs", gmcp_msgs)

