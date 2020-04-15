-- for pausers
amap["pausers_commands_break"] = { ["q"] = true, ["x"] = true }

function mail_pauser_check(_, command)
    if amap.pauser_effective and amap.pausers_commands_break[command] then
        amap:follow_mode()
        amap.pauser_effective = false
    end
end

if scripts.event_handlers["mapper/mail_pauser_check.sysDataSendRequest.mail_pauser_check"] then
    killAnonymousEventHandler(scripts.event_handlers["mapper/mail_pauser_check.sysDataSendRequest.mail_pauser_check"])
end

scripts.event_handlers["mapper/mail_pauser_check.sysDataSendRequest.mail_pauser_check"] = registerAnonymousEventHandler("sysDataSendRequest", mail_pauser_check)

