scripts.ui.toggle_button = scripts.ui.toggle_button or {
    variant = "m"
}

local variants = {
    r = {
        width = 164,
        height = 27,
    },
    m = {
        width = 90,
        height = 27,
    }
}


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
    o.font_size = 10
    o.variant = self.variant
    o.width = variants[o.variant].width
    o.height = variants[o.variant].height
    o:init()
    return o
end

function scripts.ui.toggle_button:regular(id, label, x, y, toggled, callback, window)
   self.variant = "r"
   local button = self:new(id, label, x, y, toggled, callback, window)
   self.variant = "m"
   return button
end

function scripts.ui.toggle_button:init()
    deleteLabel(self.id .. "_background")
    createLabel(self.window, self.id .. "_background", self.x, self.y, self.width, self.height, true, false)
    deleteLabel(self.id)
    createLabel(self.window, self.id, self.x, self.y, self.width, self.height, true, false)
    setLabelCursor(self.id, "PointingHand")
    self:set_text(self.label)
    self:toggle(self.toggled)
    self:updateStyleSheet()
    setLabelReleaseCallback(self.id, function()
        self:toggle()
        self.callback(self.toggled, self)
    end)
end

function scripts.ui.toggle_button:updateStyleSheet()
    local color = self.toggled and string.format("rgb(%s, %s, %s, %%s)", self.r, self.g, self.b) or "rgb(130, 30, 30, %s)"
    setLabelStyleSheet(self.id, scripts.ui.current_theme:get_button_stylesheet(color, self.font_size, self.variant))
end

function scripts.ui.toggle_button:set_text(text)
    clearWindow(self.id)
    echo(self.id, string.format("<center>%s</center>", text))
end

function scripts.ui.toggle_button:set_font_size(size)
    self.font_size = size
    self:updateStyleSheet()
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
