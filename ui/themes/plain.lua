scripts.ui.themes.plain = {}

function scripts.ui.themes.plain:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function scripts.ui.themes.plain:apply_app_stylesheet()
    setAppStyleSheet("")
end

function scripts.ui.themes.plain:get_footer_stylesheet()
    return ""
end

function scripts.ui.themes.plain:get_window_stylesheet()
    return ""
end

function scripts.ui.themes.plain:get_window_stylesheet()
    return [[
        QWidget { 
            padding: 1px;
        }
    ]]
end

function scripts.ui.themes.plain:get_button_window_stylesheet(height)
    return string.format([[
        QWidget { 
            padding: %dpx 1px 1px 1px;
        }
    ]], height)
end

function scripts.ui.themes.plain:get_button_area_bg(height)
    return ""
end

function scripts.ui.themes.plain:get_border_stylesheet()
    return "background: none; border: 0px;"
end

function scripts.ui.themes.plain:get_notification_color()
    return "black";
end

function scripts.ui.themes.plain:get_notification_stylesheet()
    return [[
        QLabel {
            color: #000000;
            padding: 5px;
            border: 1px solid #ffffff;
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.8);
            qproperty-wordWrap: true;
        }
    ]]
end

function scripts.ui.themes.plain:get_notification_close_stylesheet()
    return [[
        QLabel {
            background: rgba(0, 0, 0, 0);
            color: #000000;
        }
    ]]
end

function scripts.ui.themes.plain:get_button_stylesheet(color, font_size, variant)
    return [[
        QLabel {
            border: 0;
            padding: 0;
            background-color: ]] .. string.format(color, 125) .. [[;
            text-transform: uppercase;
            font-weight: 500;
            color: #CCC;
            font-size: ]] .. font_size ..[[px;
        }

        QLabel:hover{
            background-color: ]] .. string.format(color, 255) .. [[;
        }
    ]]
end
