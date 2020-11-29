scripts.ui.results_window = scripts.ui.results_window or {
    enabled = true,
    width = 510
}

function scripts.ui.results_window:show()
    local main_window_width, main_window_height = getMainWindowSize()
    local base_height = main_window_height - scripts.ui.footer_height

    self.container = Geyser.Container:new({
        name = "search_container",
        x = -self.width, y = 0,
        width = self.width - 10, height = base_height
    })
    setBorderRight(self.width)

    self.close_search = Geyser.Label:new({
        name = "close_search",
        fgColor = "white",
        color = "black",
        width = "100%", height = 40,
        message = [[<center>[ Zamknij ]</center>]],
        x = 0,
        y = -40,
    }, self.container)
    setLabelCursor(self.close_search.name, "PointingHand")
    self.close_search:setClickCallback(function() self:close() end)

    self.window = Geyser.MiniConsole:new({
        name = "search_results",
        width = "100%", height = base_height - 50,
        autoWrap = true,
        color = "black",
        scrollBar = true,
        fontSize = 10,
    }, self.container)
end

function scripts.ui.results_window:print(results)
    self:show()
    clearWindow(self.window.name)
    cecho(self.window.name, results)
end

function scripts.ui.results_window:close()
    clearWindow("search_results")
    self.container:hide()
    setBorderRight(0)
end
