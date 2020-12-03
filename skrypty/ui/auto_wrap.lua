scripts.ui.auto_wrap_main_window = scripts.ui.auto_wrap_main_window or {
    enabled = false
}

function scripts.ui.auto_wrap_main_window:init()
    self.resize_hander = scripts.event_register:register_singleton_event_handler(self.resize_hander, "sysWindowResizeEvent", function () self:adjust_wrap() end)
    self.ui_ready_handler = scripts.event_register:register_singleton_event_handler(self.ui_ready_handler, "uiReady", function () self:adjust_wrap() end)
end

function scripts.ui.auto_wrap_main_window:adjust_wrap()
    if self.enabled then
        setWindowWrap("main", getColumnCount())
    end
end

scripts.ui.auto_wrap_main_window:init()