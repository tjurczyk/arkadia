scripts.ui.window = scripts.ui.window or {}

function scripts.ui.window:new(id, label, auto_wrap)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.id = id
    o.label = label
    o.font_size = getFontSize()
    o.font = getFont()
    o.auto_wrap = auto_wrap or auto_wrap == nil
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
end

function scripts.ui.window:refresh()
    if self.auto_wrap then
        setWindowWrap(self.id, getColumnCount(self.id))
    else
        setWindowWrap(self.id, 1000)
    end

    setUserWindowStyleSheet(self.id, scripts.ui.current_theme:get_window_stylesheet())

    if self.buttons_func then
        local button_bg_id = string.format("%s-button_bg", self.id)

        setUserWindowStyleSheet(self.id, scripts.ui.current_theme:get_button_window_stylesheet())

        deleteLabel(button_bg_id)
        createLabel(self.id, button_bg_id, 0, 0, getUserWindowSize(self.id), 50, false, false)
        setLabelStyleSheet(button_bg_id, scripts.ui.current_theme:get_button_area_bg())
        
        self.buttons_func()
    end
    
    local border_label_id = string.format("%s-border_label", self.id)
    local width, heigth = getUserWindowSize(self.id)
    deleteLabel(border_label_id)
    createLabel(self.id, border_label_id, 0, 0, width, heigth, false, true)
    setLabelStyleSheet(border_label_id, scripts.ui.current_theme:get_border_stylesheet())

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