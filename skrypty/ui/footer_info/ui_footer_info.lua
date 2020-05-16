function scripts.ui:setup_footer_info()
    scripts.ui.footer_info_core = Geyser.HBox:new({
        x = 0,
        y = 0,
        width = "100%",
        height = "100%",
        name = "scripts.ui.footer_info_core",
    }, scripts.ui.footer_info_box_main)

    scripts.ui.footer_info_core_base_css = CSSMan.new([[
    background-color: rgba(]] .. scripts.ui.footer_r .. [[,]] .. scripts.ui.footer_g .. [[,]] .. scripts.ui.footer_b .. [[,0);
    padding-left: 5px;
    font-family:Consolas,Monaco,Lucida Console,Liberation Mono,DejaVu Sans Mono,Bitstream Vera Sans Mono,Courier New, monospace;
  ]])

    scripts.ui.info_columns = {}
    scripts.ui.info_elements = {}

    scripts.ui:setup_footer_info_weapon()
    scripts.ui:setup_footer_info_order_ready()
    scripts.ui:setup_footer_info_cover_ready()
    scripts.ui:setup_footer_info_killed()
    scripts.ui:setup_footer_info_sneaky()
    scripts.ui:setup_footer_info_hidden()
    scripts.ui:setup_footer_info_attack_mode()
    scripts.ui:setup_footer_info_collect_mode()
    scripts.ui:setup_footer_info_mail()
    scripts.ui:setup_footer_info_alert()
    scripts.ui:setup_footer_info_lamp()
    scripts.ui:setup_footer_info_compass()
    scripts.ui:setup_footer_info_combat_state()

    scripts.ui.info_placeholders = {}
    local placeholders_count = (table.size(scripts.ui.info_columns) * scripts.ui.footer_info_row_count) - table.size(scripts.ui.info_elements)
    for i=1,placeholders_count do
        scripts.ui:setup_placeholder()
    end

end

function scripts.ui:setup_info_column(index)
    return Geyser.VBox:new({
        name = "scripts.ui.footer_info_core_" .. index,
        h_policy = Geyser.Dynamic,
    }, scripts.ui.footer_info_core)
end

function scripts.ui:add_footer_element(element)
    table.insert(scripts.ui.info_elements, element)
    local element_count = table.size(scripts.ui.info_elements) - 1
    local element_column = math.floor(element_count / scripts.ui.footer_info_row_count) + 1
    if not scripts.ui.info_columns[element_column] then
        scripts.ui.info_columns[element_column] = scripts.ui:setup_info_column(element_column)
    end
    scripts.ui.info_columns[element_column]:add(element)
end


function scripts.ui:setup_footer_info_weapon()
    scripts.ui.footer_info_weapon = Geyser.Label:new({
        name = "scripts.ui.footer_info_weapon",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_weapon:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_weapon:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Bron:&nbsp;&nbsp;&nbsp;</font> <font color='" .. scripts.ui["footer_info_neutral"] .. "'>off</font>")
    scripts.ui.footer_info_weapon:setClickCallback("scripts_ui_info_weapon_update")
    scripts.ui:add_footer_element(scripts.ui.footer_info_weapon)
end

function scripts.ui:setup_footer_info_cover_ready()
    scripts.ui.footer_info_cover_ready = Geyser.Label:new({
        name = "scripts.ui.footer_info_cover_ready",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_cover_ready:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_cover_ready:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Zaslona:</font> <font color='" .. scripts.ui["footer_info_green"] .. "'>ok</font>")
    scripts.ui.footer_info_cover_ready:setClickCallback("scripts_ui_info_cover_ready_click")
    scripts.ui:add_footer_element(scripts.ui.footer_info_cover_ready)
end

function scripts.ui:setup_footer_info_order_ready()
    scripts.ui.footer_info_order_ready = Geyser.Label:new({
        name = "scripts.ui.footer_info_order_ready",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_order_ready:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_order_ready:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Rozkaz:&nbsp;</font> <font color='" .. scripts.ui["footer_info_green"] .. "'>ok</font>")
    scripts.ui:add_footer_element(scripts.ui.footer_info_order_ready)
end

function scripts.ui:setup_footer_info_killed()
    scripts.ui.footer_info_killed = Geyser.Label:new({
        name = "scripts.ui.footer_info_killed",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_killed:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui:info_killed_update()
    scripts.ui:add_footer_element(scripts.ui.footer_info_killed)
end

function scripts.ui:setup_footer_info_sneaky()
    scripts.ui.footer_info_sneaky = Geyser.Label:new({
        name = "scripts.ui.footer_info_sneaky",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_sneaky:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_sneaky:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Przemykam:</font> <font color='" .. scripts.ui["footer_info_green"] .. "'></font>")
    scripts.ui.footer_info_sneaky:setClickCallback("scripts_ui_info_sneaky_click")
    scripts.ui:add_footer_element(scripts.ui.footer_info_sneaky)
end

function scripts.ui:setup_footer_info_hidden()
    scripts.ui.footer_info_hidden = Geyser.Label:new({
        name = "scripts.ui.footer_info_hidden",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_hidden:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_hidden:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Ukryty:</font> <font color='" .. scripts.ui["footer_info_green"] .. "'></font>")
    scripts.ui.footer_info_hidden:setClickCallback("scripts_ui_info_hidden_click")
    scripts.ui:add_footer_element(scripts.ui.footer_info_hidden)
end

function scripts.ui:setup_footer_info_attack_mode()
    scripts.ui.footer_info_attack_mode = Geyser.Label:new({
        name = "scripts.ui.footer_info_attack_mode",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_attack_mode:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_attack_mode:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Atak:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font> <font color='" .. scripts.ui["footer_info_neutral"] .. "'>" .. ateam["footer_info_attack_mode_to_text"][ateam.attack_mode] .. "</font>")
    scripts.ui.footer_info_attack_mode:setClickCallback("scripts_ui_info_attack_mode_click")
    scripts.ui:add_footer_element(scripts.ui.footer_info_attack_mode)
end
function scripts.ui:setup_footer_info_collect_mode()
    scripts.ui.footer_info_collect_mode = Geyser.Label:new({
        name = "scripts.ui.footer_info_collect_mode",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_collect_mode:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_collect_mode:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Zbieranie:</font> <font color='" .. scripts.ui["footer_info_neutral"] .. "'>" .. scripts.inv.collect["footer_info_collect_to_text"][scripts.inv.collect.current_mode] .. "</font>")
    scripts.ui.footer_info_collect_mode:setClickCallback("scripts_ui_info_collect_mode")
    scripts.ui:add_footer_element(scripts.ui.footer_info_collect_mode)
end
function scripts.ui:setup_footer_info_mail()
    scripts.ui.footer_info_mail = Geyser.Label:new({
        name = "scripts.ui.footer_info_mail",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_mail:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_mail:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Mail:</font> <font color='" .. scripts.ui["footer_info_yellow"] .. "'></font>")
    scripts.ui.footer_info_mail_mode = nil
    scripts.ui.footer_info_mail_click_bind = nil
    scripts.ui.footer_info_mail:setClickCallback("scripts_ui_info_mail_click")
    scripts.ui:add_footer_element(scripts.ui.footer_info_mail)
end
function scripts.ui:setup_footer_info_alert()
    scripts.ui.footer_info_alert = Geyser.Label:new({
        name = "scripts.ui.footer_info_alert",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_alert:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_alert:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Alert:</font> <font color='" .. scripts.ui["footer_info_yellow"] .. "'></font>")
    scripts.ui.footer_info_alert:setClickCallback("scripts_ui_info_action_click")
    scripts.ui:add_footer_element(scripts.ui.footer_info_alert)
end
function scripts.ui:setup_footer_info_lamp()
    scripts.ui.footer_info_lamp = Geyser.Label:new({
        name = "scripts.ui.footer_info_lamp",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_lamp:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_lamp:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Lampa:</font> <font color='" .. scripts.ui["footer_info_green"] .. "'></font>")
    scripts.ui.footer_info_lamp:setClickCallback("scripts_ui_info_lamp_click")
    scripts.ui:add_footer_element(scripts.ui.footer_info_lamp)
end
function scripts.ui:setup_footer_info_compass()
    scripts.ui.footer_info_compass = Geyser.Label:new({
        name = "scripts.ui.footer_info_compass",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_compass:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_compass:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Komenda</font>")
    scripts.ui.footer_info_compass:setClickCallback("scripts_ui_info_compass_click")
    scripts.ui:add_footer_element(scripts.ui.footer_info_compass)
end
function scripts.ui:setup_footer_info_combat_state()
    scripts.ui.footer_info_combat_state = Geyser.Label:new({
        name = "scripts.ui.footer_combat_state",
        fontSize = scripts.ui.footer_font_size,
    })
    scripts.ui.footer_info_combat_state:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui.footer_info_combat_state:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Walka:</font> <font color='" .. scripts.ui["footer_info_green"] .. "'>off</font>")
    scripts.ui.footer_info_combat_state:setClickCallback(function () scripts.character.combat_state:run_command() end)
    scripts.ui:add_footer_element(scripts.ui.footer_info_combat_state)
end
function scripts.ui:setup_placeholder()
    local id = table.size(scripts.ui.info_placeholders) + 1
    scripts.ui.info_placeholders[id] = Geyser.Label:new({
        name = "scripts.ui.placeholder" .. id,
    })
    scripts.ui.info_placeholders[id]:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    scripts.ui:add_footer_element(scripts.ui.info_placeholders[id])
end

