herbs.window = herbs.window or {
    name = "herbs_window",
    window = nil,
    font_size = 12
}

function herbs.window:create()
    if herbs.window.enabled and not self.window then
       self.window = scripts.ui.window:new(self.name, "Ziola")
    end
    if self.window then
        self.window:set_font_size(self.font_size)
    end
    self:print()
end

function herbs.window:print()
    if self.window then
        self:clear()
        herbs:v2_do_print(self.name)
    end
end

function herbs.window:clear()
    clearUserWindow(self.name)
end
