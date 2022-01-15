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
    scripts.ui.bottom:setStyleSheet("")
end

function scripts.ui.themes.plain:get_window_stylesheet()
    return ""
end

function scripts.ui.themes.plain:get_window_stylesheet()
    return [[
        QWidget { 
            padding: 10px;
        }
    ]]
end

function scripts.ui.themes.plain:get_button_window_stylesheet()
    return [[
        QWidget { 
            padding: 50px 10px 10px 10px;
        }
    ]]
end

function scripts.ui.themes.plain:get_button_area_bg()
    return ""
end

function scripts.ui.themes.plain:get_border_stylesheet()
    return ""
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
