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

    self.info_columns = {}
    self.info_elements = {}

    self.footer_info_elements_creators = {
        ["weapon"] = self.setup_footer_info_weapon,
        ["order"] = self.setup_footer_info_order_ready,
        ["cover"] = self.setup_footer_info_cover_ready,
        ["killed"] = self.setup_footer_info_killed,
        ["sneaky"] = self.setup_footer_info_sneaky,
        ["hidden"] = self.setup_footer_info_hidden,
        ["attack"] = self.setup_footer_info_attack_mode,
        ["collect"] = self.setup_footer_info_collect_mode,
        ["mail"] = self.setup_footer_info_mail,
        ["alert"] = self.setup_footer_info_alert,
        ["lamp"] = self.setup_footer_info_lamp,
        ["compass"] = self.setup_footer_info_compass,
        ["combat"] = self.setup_footer_info_combat_state,
        ["placeholder"] = self.setup_placeholder
    }

    raiseEvent("footerInfoCreators", self.footer_info_elements_creators)

    self.info_placeholders = {}

    for _, info_creator in pairs(scripts.ui.cfg.info_items) do
        if self.footer_info_elements_creators[info_creator] then
            self.footer_info_elements_creators[info_creator](self)
        else
            scripts:print_log("Nieprawidlowy klucz w konfiguracji scripts.ui.cfg.info_items - " .. info_creator)
        end
    end

    local placeholders_count = (table.size(self.info_columns) * self.footer_info_row_count) - table.size(self.info_elements)
    for i=1,placeholders_count do
        self:setup_placeholder()
    end

end

function scripts.ui:setup_info_column(index)
    return Geyser.VBox:new({
        name = "scripts.ui.footer_info_core_" .. index,
        h_policy = Geyser.Dynamic,
    }, self.footer_info_core)
end

function scripts.ui:add_footer_element(element)
    table.insert(self.info_elements, element)
    local element_count = table.size(self.info_elements) - 1
    local element_column = math.floor(element_count / self.footer_info_row_count) + 1
    if not self.info_columns[element_column] then
        self.info_columns[element_column] = self:setup_info_column(element_column)
    end
    self.info_columns[element_column]:add(element)
end


function scripts.ui:setup_footer_info_weapon()
    self.footer_info_weapon = Geyser.Label:new({
        name = "scripts.ui.footer_info_weapon",
        fontSize = self.footer_font_size,
    })
    self.footer_info_weapon:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_weapon:echo("<font color='" .. self["footer_info_normal"] .. "'>Bron:&nbsp;&nbsp;&nbsp;</font> <font color='" .. self["footer_info_neutral"] .. "'>off</font>")
    self.footer_info_weapon:setClickCallback("scripts_ui_info_weapon_update")
    self:add_footer_element(self.footer_info_weapon)
end

function scripts.ui:setup_footer_info_cover_ready()
    self.footer_info_cover_ready = Geyser.Label:new({
        name = "scripts.ui.footer_info_cover_ready",
        fontSize = self.footer_font_size,
    })
    self.footer_info_cover_ready:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_cover_ready:echo("<font color='" .. self["footer_info_normal"] .. "'>Zaslona:</font> <font color='" .. self["footer_info_green"] .. "'>ok</font>")
    self.footer_info_cover_ready:setClickCallback("scripts_ui_info_cover_ready_click")
    self:add_footer_element(self.footer_info_cover_ready)
end

function scripts.ui:setup_footer_info_order_ready()
    self.footer_info_order_ready = Geyser.Label:new({
        name = "scripts.ui.footer_info_order_ready",
        fontSize = self.footer_font_size,
    })
    self.footer_info_order_ready:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_order_ready:echo("<font color='" .. self["footer_info_normal"] .. "'>Rozkaz:&nbsp;</font> <font color='" .. self["footer_info_green"] .. "'>ok</font>")
    self:add_footer_element(self.footer_info_order_ready)
end

function scripts.ui:setup_footer_info_killed()
    self.footer_info_killed = Geyser.Label:new({
        name = "scripts.ui.footer_info_killed",
        fontSize = self.footer_font_size,
    })
    self.footer_info_killed:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self:info_killed_update()
    self:add_footer_element(self.footer_info_killed)
end

function scripts.ui:setup_footer_info_sneaky()
    self.footer_info_sneaky = Geyser.Label:new({
        name = "scripts.ui.footer_info_sneaky",
        fontSize = self.footer_font_size,
    })
    self.footer_info_sneaky:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_sneaky:echo("<font color='" .. self["footer_info_normal"] .. "'>Przemykam:</font> <font color='" .. self["footer_info_green"] .. "'></font>")
    self.footer_info_sneaky:setClickCallback("scripts_ui_info_sneaky_click")
    self:add_footer_element(self.footer_info_sneaky)
end

function scripts.ui:setup_footer_info_hidden()
    self.footer_info_hidden = Geyser.Label:new({
        name = "scripts.ui.footer_info_hidden",
        fontSize = self.footer_font_size,
    })
    self.footer_info_hidden:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_hidden:echo("<font color='" .. self["footer_info_normal"] .. "'>Ukryty:</font> <font color='" .. self["footer_info_green"] .. "'></font>")
    self.footer_info_hidden:setClickCallback("scripts_ui_info_hidden_click")
    self:add_footer_element(self.footer_info_hidden)
end

function scripts.ui:setup_footer_info_attack_mode()
    self.footer_info_attack_mode = Geyser.Label:new({
        name = "scripts.ui.footer_info_attack_mode",
        fontSize = self.footer_font_size,
    })
    self.footer_info_attack_mode:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_attack_mode:echo("<font color='" .. self["footer_info_normal"] .. "'>Atak:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font> <font color='" .. self["footer_info_neutral"] .. "'>" .. ateam["footer_info_attack_mode_to_text"][ateam.attack_mode] .. "</font>")
    self.footer_info_attack_mode:setClickCallback("scripts_ui_info_attack_mode_click")
    self:add_footer_element(self.footer_info_attack_mode)
end

function scripts.ui:setup_footer_info_collect_mode()
    self.footer_info_collect_mode = Geyser.Label:new({
        name = "scripts.ui.footer_info_collect_mode",
        fontSize = self.footer_font_size,
    })
    self.footer_info_collect_mode:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_collect_mode:echo("<font color='" .. self["footer_info_normal"] .. "'>Zbieranie:</font> <font color='" .. self["footer_info_neutral"] .. "'>" .. scripts.inv.collect["footer_info_collect_to_text"][scripts.inv.collect.current_mode] .. "</font>")
    self.footer_info_collect_mode:setClickCallback("scripts_ui_info_collect_mode")
    self:add_footer_element(self.footer_info_collect_mode)
end

function scripts.ui:setup_footer_info_mail()
    self.footer_info_mail = Geyser.Label:new({
        name = "scripts.ui.footer_info_mail",
        fontSize = self.footer_font_size,
    })
    self.footer_info_mail:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_mail:echo("<font color='" .. self["footer_info_normal"] .. "'>Mail:</font> <font color='" .. self["footer_info_yellow"] .. "'></font>")
    self.footer_info_mail_mode = nil
    self.footer_info_mail_click_bind = nil
    self.footer_info_mail:setClickCallback("scripts_ui_info_mail_click")
    self:add_footer_element(self.footer_info_mail)
end

function scripts.ui:setup_footer_info_alert()
    self.footer_info_alert = Geyser.Label:new({
        name = "scripts.ui.footer_info_alert",
        fontSize = self.footer_font_size,
    })
    self.footer_info_alert:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_alert:echo("<font color='" .. self["footer_info_normal"] .. "'>Alert:</font> <font color='" .. self["footer_info_yellow"] .. "'></font>")
    self.footer_info_alert:setClickCallback("scripts_ui_info_action_click")
    self:add_footer_element(self.footer_info_alert)
end

function scripts.ui:setup_footer_info_lamp()
    self.footer_info_lamp = Geyser.Label:new({
        name = "scripts.ui.footer_info_lamp",
        fontSize = self.footer_font_size,
    })
    self.footer_info_lamp:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_lamp:echo("<font color='" .. self["footer_info_normal"] .. "'>Lampa:</font> <font color='" .. self["footer_info_green"] .. "'></font>")
    self.footer_info_lamp:setClickCallback("scripts_ui_info_lamp_click")
    self:add_footer_element(self.footer_info_lamp)
end

function scripts.ui:setup_footer_info_compass()
    self.footer_info_compass = Geyser.Label:new({
        name = "scripts.ui.footer_info_compass",
        fontSize = self.footer_font_size,
    })
    self.footer_info_compass:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_compass:echo("<font color='" .. self["footer_info_normal"] .. "'>Komenda</font>")
    self.footer_info_compass:setClickCallback("scripts_ui_info_compass_click")
    self:add_footer_element(self.footer_info_compass)
end

function scripts.ui:setup_footer_info_combat_state()
    self.footer_info_combat_state = Geyser.Label:new({
        name = "scripts.ui.footer_combat_state",
        fontSize = self.footer_font_size,
    })
    self.footer_info_combat_state:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self.footer_info_combat_state:echo("<font color='" .. self["footer_info_normal"] .. "'>Walka:</font> <font color='" .. self["footer_info_green"] .. "'>off</font>")
    self.footer_info_combat_state:setClickCallback(function () scripts.character.combat_state:run_command() end)
    self:add_footer_element(self.footer_info_combat_state)
end

function scripts.ui:setup_placeholder()
    local id = table.size(self.info_placeholders) + 1
    self.info_placeholders[id] = Geyser.Label:new({
        name = "scripts.ui.placeholder" .. id,
    })
    self.info_placeholders[id]:setStyleSheet(self.footer_info_core_base_css:getCSS())
    self:add_footer_element(self.info_placeholders[id])
end

