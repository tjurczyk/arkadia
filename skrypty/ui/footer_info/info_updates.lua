--
-- walking
--
function scripts_ui_info_sneaky_click(id)
    if id and type(id) == "number" then
        if id < 1 or id > 3 then
            error("Wrong input")
        end

        amap.walk_mode = id
        scripts.ui.footer_info_sneaky:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Przemykam:</font> " .. scripts.ui["footer_info_walk_mode_to_text"][amap.walk_mode] .. "</font>")
    else
        amap.walk_mode = amap.walk_mode % 3 + 1
        scripts.ui.footer_info_sneaky:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Przemykam:</font> " .. scripts.ui["footer_info_walk_mode_to_text"][amap.walk_mode] .. "</font>")
    end
end

--
-- hiding
--
function scripts_ui_info_hidden_click()
    send("ukryj sie", true)
end

function scripts.ui:info_hidden_update(val)
    if val == "" then
        scripts.ui.footer_info_hidden:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Ukryty:&nbsp;&nbsp;&nbsp;</font>")
    else
        local color = nil
        if val == "ok" then
            color = scripts.ui["footer_info_green"]
        elseif tonumber(val) < 5 then
            color = scripts.ui["footer_info_red"]
        elseif tonumber(val) < 10 then
            color = scripts.ui["footer_info_yellow"]
        elseif tonumber(val) < 15 then
            color = scripts.ui["footer_info_green"]
        end

        scripts.ui.footer_info_hidden:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Ukryty:&nbsp;&nbsp;&nbsp;</font> <font color='" .. color .. "'>" .. tostring(val) .. "</font>")

        --if color then
        --  scripts.ui.footer_info_hidden:echo("<font color='"..scripts.ui["footer_info_normal"].."'>Ukryty:&nbsp;&nbsp;&nbsp;</font> <font color='"..color.."'>"..tostring(val).."</font>")
        --else
        --  val = "ok"
        --  scripts.ui.footer_info_hidden:echo("<font color='"..scripts.ui["footer_info_normal"].."'>Ukryty:&nbsp;&nbsp;&nbsp;</font> <font color='"..scripts.ui["footer_info_green"].."'>"..tostring(val).."</font>")
        --  scripts.ui.info_hidden_value = 15
        --  disableTimer("hidden_timer")
        --end
    end
end

--
-- walk dir
--
function scripts_ui_info_compass_click()
    if amap.using_pre_walk_cmd or amap.using_post_walk_cmd then
        amap.using_pre_walk_cmd = nil
        amap.using_post_walk_cmd = nil
        scripts.ui:info_compass_update("")
    end
end

function scripts.ui:info_compass_update(working)
    if working == 1 then
        scripts.ui.footer_info_compass:echo("<font color='yellow'>PRZED: </font><font color='" .. scripts.ui["footer_info_green"] .. "'>" .. amap.using_pre_walk_cmd .. "</font>")
    elseif working == 2 then
        scripts.ui.footer_info_compass:echo("<font color='yellow'>PO: </font><font color='" .. scripts.ui["footer_info_green"] .. "'>" .. amap.using_post_walk_cmd .. "</font>")
    else
        scripts.ui.footer_info_compass:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Komenda</font>")
    end
end

--
-- cover
--
function scripts_ui_info_cover_ready_click()
    if scripts.ui.footer_info_cover_ready_enable_click and ateam.cover_command then
        expandAlias(ateam.cover_command)
    end
end

function scripts.ui:info_cover_ready_update(val)
    if val == "5" then
        scripts.ui.footer_info_cover_ready:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Zaslona:</font> <font color='" .. scripts.ui["footer_info_red"] .. "'>5</font>")
        scripts.ui.footer_info_cover_ready_enable_click = nil
    elseif val == "0" or val == "ok" then
        scripts.ui.footer_info_cover_ready:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Zaslona:</font> <font color='" .. scripts.ui["footer_info_green"] .. "'>ok</font>")
        scripts.ui.footer_info_cover_ready_enable_click = true
    else
        scripts.ui.footer_info_cover_ready:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Zaslona:</font> <font color='" .. scripts.ui["footer_info_red"] .. "'>" .. val .. "</font>")
    end
end

--
-- order
--
function scripts.ui:info_order_ready_update(val)
    if val == "0" or val == "ok" then
        scripts.ui.footer_info_order_ready:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Rozkaz:&nbsp;</font> <font color='" .. scripts.ui["footer_info_green"] .. "'>ok</font>")
    else
        scripts.ui.footer_info_order_ready:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Rozkaz:&nbsp;</font> <font color='" .. scripts.ui["footer_info_red"] .. "'>" .. val .. "</font>")
    end
end

--
-- lamp
--
function scripts_ui_info_lamp_click()
    if not scripts.inv.lamp.working then
        expandAlias("/zap")
        scripts.ui:info_lamp_update("zapalona")
    else
        expandAlias("/nlo")
    end
end

function scripts.ui:info_lamp_update(val)
    if val == "" then
        scripts.ui.footer_info_lamp:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Lampa:</font> <font color='" .. scripts.ui["footer_info_green"] .. "'></font>")
    elseif val == "zapalona" then
        scripts.ui.footer_info_lamp:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Lampa:</font> <font color='" .. scripts.ui["footer_info_green"] .. "'>zapalona</font>")
    end
end

--
-- attack_mode
--
function scripts_ui_info_attack_mode_click()
    ateam.attack_mode = ateam.attack_mode % 3 + 1
    scripts.ui.footer_info_attack_mode:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Atak:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font> <font color='" .. scripts.ui["footer_info_neutral"] .. "'>" .. ateam["footer_info_attack_mode_to_text"][ateam.attack_mode] .. "</font>")
end

--
-- collect_mode
--
function scripts_ui_info_collect_mode()
    scripts.inv.collect.current_mode = scripts.inv.collect.current_mode % 7 + 1
    scripts.inv.collect:set_mode(scripts.inv.collect.current_mode)
    scripts.ui.footer_info_collect_mode:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Zbieranie: </font> <font color='" .. scripts.ui["footer_info_neutral"] .. "'>" .. scripts.inv.collect["footer_info_collect_to_text"][scripts.inv.collect.current_mode] .. "</font>")
end

--
-- mail
--

function scripts.ui:info_mail_update(str)
    scripts.ui.footer_info_mail:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Mail:&nbsp;</font> <font color='" .. scripts.ui["footer_info_yellow"] .. "'>" .. str .. "</font>")
end

function scripts.ui:info_mail_clear()
    scripts.ui.footer_info_mail:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Mail:&nbsp;</font> <font color='" .. scripts.ui["footer_info_yellow"] .. "'></font>")
end

function scripts_ui_info_mail_click()
    if scripts.ui.footer_info_mail_click_bind and scripts.ui.footer_info_mail_click_bind ~= "" then
        send(scripts.ui.footer_info_mail_click_bind, true)
    end
end

--
-- action
--

function scripts.ui:info_action_update(str)
    scripts.ui.footer_info_alert:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Alert:</font> <font color='" .. scripts.ui["footer_info_yellow"] .. "'>" .. str .. "</font>")
end

function scripts.ui:info_action_clear()
    scripts.ui.footer_info_alert:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Alert:</font> <font color='" .. scripts.ui["footer_info_yellow"] .. "'></font>")
end

function scripts_ui_info_action_click()
    scripts.ui:info_action_clear()
    if scripts.ui.info_action_bind then
        local cmds = string.split(scripts.ui.info_action_bind, ";")
        for k, v in pairs(cmds) do
            expandAlias(v, false)
        end

        scripts.ui.info_action_bind = nil
    end
end

--
-- weapon
--

function scripts_ui_info_weapon_update(str)
    if scripts.inv.weapon_grip then
        scripts.inv.weapon_grip = false
        expandAlias("/ob", false)
    else
        scripts.inv.weapon_grip = true
        expandAlias("/db", false)
    end
end

function scripts.ui:info_weapon_update(state)
    if state then
        scripts.ui.footer_info_weapon:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Bron:&nbsp;&nbsp;&nbsp;</font> <font color='" .. scripts.ui["footer_info_green"] .. "'>on</font>")
        scripts.ui:info_action_clear()
    else
        scripts.ui.footer_info_weapon:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Bron:&nbsp;&nbsp;&nbsp;</font> <font color='" .. scripts.ui["footer_info_yellow"] .. "'>off</font>")
    end
end

--
-- killed
--

function scripts.ui:info_killed_update()
    if misc.counter.all_kills > 0 then
        scripts.ui.footer_info_killed:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Zabici:&nbsp;</font> <font color='" .. scripts.ui["footer_info_neutral"] .. "'>" .. tostring(misc.counter.killed_amount.JA) .. "/" .. tostring(misc.counter.all_kills) .. "</font>")
    else
        scripts.ui.footer_info_killed:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Zabici:</font> <font color='" .. scripts.ui["footer_info_neutral"] .. "'></font>")
    end
end

function scripts.ui:info_combat_state_update(is_combat, cool_off, command)
    local color, text
    if is_combat then
        color = scripts.ui["footer_info_red"]
        text = "on"
    else
        color = cool_off > 0 and scripts.ui["footer_info_yellow"] or scripts.ui["footer_info_normal"]
        text = cool_off > 0 and cool_off .. "s" or "off"
    end
    if command then
        text = text .. " (" .. command .. ")"
    end
    scripts.ui.footer_info_combat_state:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Walka:</font> <font color='" .. color .. "'>" .. text .. "</font>")
end
