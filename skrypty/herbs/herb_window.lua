herbs.window = herbs.window or {
    name = "herbs_window",
    window_loaded = false
}

function herbs.window:create()
    if herbs.window.enabled and not self.window_loaded then
        openUserWindow(self.name)
        setUserWindowTitle(self.name, "Ziola")
        self.window_loaded = true
    end

    self:print()
end

function herbs.window:print()
    if self.window_loaded then
        self:clear()
        herbs:v2_do_print(self.name)
    end
end

function herbs.window:clear()
    clearUserWindow(self.name)
end
