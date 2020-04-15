function log_cmds_ui(_, command)
    if string.starts(command, "zaslon ") or string.starts(command, "gzzaslon ") then
        ateam.cover_command = command
    end
end

if scripts.event_handlers["skrypty/ui/log_cmds_ui.sysDataSendRequest.log_cmds_ui"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/log_cmds_ui.sysDataSendRequest.log_cmds_ui"])
end

scripts.event_handlers["skrypty/ui/log_cmds_ui.sysDataSendRequest.log_cmds_ui"] = registerAnonymousEventHandler("sysDataSendRequest", log_cmds_ui)

