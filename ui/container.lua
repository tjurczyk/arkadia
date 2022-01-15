local img_path = getMudletHomeDir() .. "/arkadia/ui/assets/"

setBackgroundColor(0, 0, 0, 0)
setAppStyleSheet([[
    QDockWidget::title {
        background-color: #171512;
        padding: 5px;
        background-image : url(]]..img_path..[[background-02.png);
     }

     QToolBar {
        background-image : url(]]..img_path..[[/background-02.png);
        border-bottom: 1px solid #171512;
      }
]])

scripts.ui.window = scripts.ui.window or {}

function scripts.ui.window:new(id, label, auto_wrap)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.id = id
    o.label = label
    o.font_size = getFontSize()
    o.font = getFont()
    o.auto_wrap = auto_wrap ~= nil and auto_wrap or true
    o:init()
    return o
end

function scripts.ui.window:init()
    openUserWindow(self.id)
    setFontSize(self.id, self.font_size)
    setFont(self.id, self.font)
    setUserWindowTitle(self.id, self.label)
    
    setUserWindowStyleSheet(self.id, [[
        QWidget { 
            padding: 15px 20px;
            background-color: #171512;
            background-origin: border-box;
        }
    ]])
    setBackgroundColor(self.id, 0, 0, 0, 0)
    self:refresh()
    self.resize_handler = scripts.event_register:force_register_event_handler(self.resize_handler, "sysUserWindowResizeEvent", function(event, x, y, windowName)
        if self.id == windowName then
            self:refresh()
        end
    end)
end

function scripts.ui.window:refresh()
    if self.auto_wrap then
        setWindowWrap(self.id, getColumnCount(self.id))
    else
        setWindowWrap(self.id, 1000)
    end

    if self.buttons_func then
        local button_bg_id = string.format("%s-button_bg", self.id)

        setUserWindowStyleSheet(self.id, [[
            QWidget { 
                padding: 55px 20px 10px 20px;
                background-color: #171512;
                background-origin: border-box;
            }
        ]])

        deleteLabel(button_bg_id)
        createLabel(self.id, button_bg_id, 0, 0, getUserWindowSize(self.id), 50, false, false)
        setLabelStyleSheet(button_bg_id, [[
            background: none;
            background-image : url(]]..img_path..[[background-02.png);
            background-origin: padding-box;
            border-bottom: 3px solid #403931;
        ]])
        
        self.buttons_func()
    end
    
    local border_label_id = string.format("%s-border_label", self.id)
    local width, heigth = getUserWindowSize(self.id)
    deleteLabel(border_label_id)
    createLabel(self.id, border_label_id, 0, 0, width, heigth, false, true)
    setLabelStyleSheet(border_label_id, [[
        background: none;
        border-style: solid;
        border-width: 24px 49px 24px 49px;
        border-image: url(]]..img_path..[[uni-container-borders.png) 58 94 repeat;
    ]])

    setLabelOnEnter(border_label_id, function() self:on_mouse_enter() end)
    setLabelOnLeave(border_label_id, function() self:on_mouse_leave() end)
end

function scripts.ui.window:add_buttons(create_func)
    self.buttons_func = create_func
    self:refresh()
end

function scripts.ui.window:set_font_size(font_size)
    setFontSize(self.id, font_size)
    self:refresh()
end

function scripts.ui.window:set_auto_wrap(wrap)
    self.auto_wrap = wrap
    self:refresh()
end

function scripts.ui.window:on_mouse_enter(callback)
    self.on_mouse_enter = callback
end

function scripts.ui.window:on_mouse_leave(callback)
    self.on_mouse_leave = callback
end