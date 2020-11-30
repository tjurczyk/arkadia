function trigger_func_skrypty_ui_footer_elements_mail_masz_poczte_login()
    function unread_mail_trigger()
        if not scripts.ui.footer_info_mail_mode or scripts.ui.footer_info_mail_mode == "" then
            scripts.ui:info_mail_update("NEW")
            scripts.ui.footer_info_mail_mode = "new"
        else
            scripts.ui:info_mail_update("NEW+")
            scripts.ui.footer_info_mail_mode = "new+"
        end

        scripts.ui.footer_info_mail_click_bind = "wyslij zwierze"

        scripts.ui.notification_center:add_notification("Masz nowa poczte.")
    end

    tempTimer(2, function() unread_mail_trigger() end)
end

function trigger_func_skrypty_ui_footer_elements_mail_masz_poczte()
    raiseEvent("playBeep")
    tempTimer(1, [[ raiseEvent("playBeep") ]])
    tempTimer(2, [[ raiseEvent("playBeep") ]])

    selectCurrentLine()
    deleteLine()
    cecho("<tomato>\n[  POCZTA   ] " .. matches[2] .. "\n")
    resetFormat()

    if not scripts.ui.footer_info_mail_mode or scripts.ui.footer_info_mail_mode == "" then
        scripts.ui:info_mail_update("NEW")
        scripts.ui.footer_info_mail_mode = "new"
    else
        scripts.ui:info_mail_update("NEW+")
        scripts.ui.footer_info_mail_mode = "new+"
    end

    scripts.ui.notification_center:add_notification(matches[2])

    scripts.ui.footer_info_mail_click_bind = "wyslij zwierze"
end

function trigger_func_skrypty_ui_footer_elements_mail_mail_unread()
    scripts.ui:info_mail_update("READ")
    scripts.ui.footer_info_mail_mode = "read"
end

function trigger_func_skrypty_ui_footer_elements_mail_letter_ready_to_send()
    scripts.ui:info_mail_update("SEND")
    scripts.ui.footer_info_mail_mode = "send"
    scripts.ui.footer_info_mail_click_bind = "wyslij zwierze"
end

function trigger_func_skrypty_ui_footer_elements_mail_no_new_mail()
    if scripts.ui.footer_info_mail_mode ~= "send" then
        scripts.ui:info_mail_update("")
        scripts.ui.footer_info_mail_mode = nil
        scripts.ui.footer_info_mail_click_bind = ""
    end
end

function trigger_func_skrypty_ui_footer_elements_mail_successfully_send()
    if scripts.ui.footer_info_mail_mode ~= "new" and scripts.ui.footer_info_mail_mode ~= "new+" then
        scripts.ui:info_mail_update("")
        scripts.ui.footer_info_mail_mode = nil
        scripts.ui.footer_info_mail_click_bind = ""
    end
end

function trigger_func_skrypty_ui_footer_elements_mail_animal_sent()
    scripts.ui:info_mail_update("SYNC")
    scripts.ui.footer_info_mail_mode = "sync"
    scripts.ui.footer_info_mail_click_bind = ""
end

