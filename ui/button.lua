scripts.ui.button = scripts.ui.button or {}

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


function scripts.ui.button:new(id, label, x, y, size, callback, window)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.id = id
    o.label = label
    o.x = x
    o.y = y
    o.callback = callback
    o.window = window or "main"
    o.r = 70
    o.g = 130
    o.b = 30
    o.r_off = 130
    o.g_off = 30
    o.b_off = 30
    o.font_size = 10
    o.size = variants[size] and size or "m"
    o.width = variants[o.size].width
    o.height = variants[o.size].height
    o:init()
    return o
end

function scripts.ui.button:init()
    deleteLabel(self.id .. "_background")
    createLabel(self.window, self.id .. "_background", self.x, self.y, self.width, self.height, true, false)
    deleteLabel(self.id)
    createLabel(self.window, self.id, self.x, self.y, self.width, self.height, true, false)
    setLabelCursor(self.id, "PointingHand")
    self:set_text(self.label)
    self:updateStyleSheet()
    setLabelReleaseCallback(self.id, function()
        self:onRelease()
    end)
end

function scripts.ui.button:onRelease()
    self.callback(self)
end

function scripts.ui.button:updateStyleSheet()
    local color = string.format("rgb(%s, %s, %s, %%s)", self.r, self.g, self.b)
    setLabelStyleSheet(self.id, scripts.ui.current_theme:get_button_stylesheet(color, self.font_size))
end

function scripts.ui.button:set_text(text)
    clearWindow(self.id)
    echo(self.id, string.format("<center>%s</center>", text))
end

function scripts.ui.button:set_font_size(size)
    self.font_size = size
    self:updateStyleSheet()
end

function scripts.ui.button:set_color(r, g, b)
    self.r = r
    self.g = g
    self.b = b
    self:updateStyleSheet()
end

function scripts.ui.button:set_color_off(r, g, b)
    self.r_off = r
    self.g_off = g
    self.b_off = b
    self:updateStyleSheet()
end
