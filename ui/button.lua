scripts.ui.toggle_button = scripts.ui.toggle_button or {}

function scripts.ui.toggle_button:new(id, label, x, y, toggled, callback, window)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.id = id
    o.label = label
    o.x = x
    o.y = y
    o.callback = callback
    o.toggled = toggled
    o.window = window or "main"
    o.r = 70
    o.g = 130
    o.b = 30
    o.width = 90
    o.height = 27
    o:init()
    return o
end

function scripts.ui.toggle_button:init()
    deleteLabel(self.id)
    createLabel(self.window, self.id, self.x, self.y, self.width, self.height, true, false)
    setLabelCursor(self.id, "PointingHand")
    self:set_text(self.label)
    self:toggle(self.toggled)
    setLabelReleaseCallback(self.id, function()
        self:toggle()
        self.callback(self.toggled)
    end)
end

function scripts.ui.toggle_button:updateStyleSheet()
    local color = self.toggled and string.format("rgb(%s, %s, %s, %%s)", self.r, self.g, self.b) or "rgb(130, 30, 30, %s)"
    setLabelStyleSheet(self.id, scripts.ui.current_theme:get_button_stylesheet(color))
end

function scripts.ui.toggle_button:set_text(text)
    clearWindow(self.id)
    echo(self.id, "<center>" .. text .. "</center>")
end

function scripts.ui.toggle_button:toggle(state)
    if state ~= nil then
        self.toggled = state
    else
        self.toggled = not self.toggled
    end
    self:updateStyleSheet()
end

function scripts.ui.toggle_button:set_toggle_color(r, g, b)
    self.r = r
    self.g = g
    self.b = b
    self:updateStyleSheet()
end
