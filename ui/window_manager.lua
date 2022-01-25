scripts.ui.window_manager = scripts.ui.window_manager or {
    windows = {}
}

function scripts.ui.window_manager:init()
    self.resize_handler = scripts.event_register:force_register_event_handler(self.resize_handler, "sysUserWindowResizeEvent", function(event, x, y, windowName)
        if self.windows[windowName] then
            self.windows[windowName]:refresh()
        end
    end)
    self.ui_handler = scripts.event_register:force_register_event_handler(self.ui_handler, "uiReady", function() self:refresh_wrap() end)
end

function scripts.ui.window_manager:register(window)
    self.windows[window.id] = window
end

function scripts.ui.window_manager:refresh_wrap()
    for k, v in pairs(self.windows) do
        v:refresh_wrap()
    end
end

scripts.ui.window_manager:init()