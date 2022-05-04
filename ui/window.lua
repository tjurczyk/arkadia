scripts.ui.window = scripts.ui.window or {}

function scripts.ui.window:new(id, label, auto_wrap)
    if type(auto_wrap) == "boolean" then
        auto_wrap = function() return auto_wrap end
    end
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.id = id
    o.label = label
    o.font_size = getFontSize()
    o.font = getFont()
    o.border_label_id = string.format("%s-border_label", o.id)
    o.auto_wrap = auto_wrap or function() return true end
    o.button_header_height = 50
    o:init()
    return o
end

function scripts.ui.window:init()
    openUserWindow(self.id)
    setFontSize(self.id, self.font_size)
    setFont(self.id, self.font)
    setUserWindowTitle(self.id, self.label)
    setBackgroundColor(self.id, 0, 0, 0, 0)

    self:refresh()
    scripts.ui.window_manager:register(self)

    setLabelOnEnter(self.border_label_id, function() self:on_mouse_enter() end)
    setLabelOnLeave(self.border_label_id, function() self:on_mouse_leave() end)
end

function scripts.ui.window:refresh()
    self:refresh_wrap()
    setUserWindowStyleSheet(self.id, scripts.ui.current_theme:get_window_stylesheet())

    if self.buttons_func then
        local button_bg_id = string.format("%s-button_bg", self.id)
        setUserWindowStyleSheet(self.id, scripts.ui.current_theme:get_button_window_stylesheet(self.button_header_height))

        deleteLabel(button_bg_id)
        createLabel(self.id, button_bg_id, 0, 0, getUserWindowSize(self.id), self.button_header_height, false, false)
        setLabelStyleSheet(button_bg_id, scripts.ui.current_theme:get_button_area_bg(self.button_header_height))
        
        self.buttons_func()
    end
    
    local width, heigth = getUserWindowSize(self.id)
    deleteLabel(self.border_label_id)
    createLabel(self.id, self.border_label_id, 0, 0, width, heigth, false, true)
    setLabelStyleSheet(self.border_label_id, scripts.ui.current_theme:get_border_stylesheet())
end

function scripts.ui.window:add_buttons(create_func)
    self.buttons_func = create_func
    self:refresh()
end

function scripts.ui.window:set_font_size(font_size)
    setFontSize(self.id, font_size)
    self:refresh()
end

function scripts.ui.window:set_button_header_height(height)
    self.button_header_height = height
    self:refresh()
end

function scripts.ui.window:refresh_wrap()
    if self.auto_wrap() then
        setWindowWrap(self.id, getColumnCount(self.id) - 1)
    else
        setWindowWrap(self.id, 1000)
    end
end

function scripts.ui.window:on_mouse_enter(callback)
    self.on_mouse_enter = callback
end

function scripts.ui.window:on_mouse_leave(callback)
    self.on_mouse_leave = callback
end