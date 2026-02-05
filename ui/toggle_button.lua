scripts.ui.toggle_button = scripts.ui.toggle_button or {}


function scripts.ui.toggle_button:new(id, label, x, y, size, callback, window)
    local o = scripts.ui.button:new(id, label, x, y, size, callback, window)
    self.super_index = getmetatable(o).__index
    setmetatable(o, self)
    self.__index = function(table, key)
        return rawget(self, key) or self.super_index[key]
    end

    return o
end

function scripts.ui.toggle_button:onRelease()
    self:toggle()
    self.callback(self.toggled, self)
end

function scripts.ui.toggle_button:updateStyleSheet()    
    local color = self.toggled and string.format("rgb(%s, %s, %s)", self.r, self.g, self.b) or
        string.format("rgb(%s, %s, %s)", self.r_off, self.g_off, self.b_off)
    setLabelStyleSheet(self.id, scripts.ui.current_theme:get_button_stylesheet(color, self.font_size, self.size))
end

function scripts.ui.toggle_button:toggle(state, call)
    if state ~= nil then
        self.toggled = state
    else
        self.toggled = not self.toggled
    end
    self:updateStyleSheet()
    if call then
        self.callback(self.toggled, self)
    end
end
