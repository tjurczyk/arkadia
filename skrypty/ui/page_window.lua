PageWindow = PageWindow or {}

function PageWindow:new(name, title, restore_layout, auto_dock, docking_area, properties)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.name = name
    o.window_name = o.name .. "_window"
    o.title = title
    o.restore_layout = restore_layout
    o.auto_dock = auto_dock
    o.docking_area = docking_area
    o.pages_content_generators = {}
    o.properties = properties or {
        ["width"] = 900,
        ["height"] = 630,
        ["padding"] = 15,
        ["x"] = 30,
        ["y"] = 30
    }
    return o
end

function PageWindow:open()
    local width, height, padding = self.properties.width, self.properties.height, self.properties.padding
    openUserWindow(self.window_name, self.restore_layout, self.auto_dock, self.docking_area)
    setUserWindowTitle(self.window_name, self.title)
    moveWindow(self.window_name, self.properties.x, self.properties.y)
    resizeWindow(self.window_name, width, height)
    createMiniConsole(self.window_name, self.name, padding, padding, width - padding * 2, height - padding * 2)
    setFont(self.name, getFont())
    setWindowWrap(self.name, getColumnCount(self.name))
    showWindow(self.window_name)
    self:display_page(1)
end

function PageWindow:add_page(content_generator_function)
    table.insert(self.pages_content_generators, content_generator_function)
end

function PageWindow:display_page(index)
    self.currentPage = index
    clearUserWindow(self.window_name)
    clearUserWindow(self.name)
    self:display_header(index)
    if self.pages_content_generators[index] then
        self.pages_content_generators[index](self, index)
    else
        echo("Strona nie istnieje")
    end
end

function PageWindow:display_header(index)
    local charColumnCount = getColumnCount(self.name) -- TODO: replace with getWindowWrap when available
    local columnWidth = math.floor((charColumnCount - 2) / 3)
    local pageCount = table.size(self.pages_content_generators)
    if index ~= 1 then
        function PageWindowPrevPage()
            self:display_page(index - 1)
        end
        cechoLink(self.name, scripts.utils.str_pad("<-", columnWidth, "left"), [[PageWindowPrevPage()]], "Nastepna strona", true)
    else
        cecho(self.name, scripts.utils.str_pad(" ", columnWidth, "left"))
    end
    cecho(self.name, scripts.utils.str_pad(string.format("=== Strona %d/%d ===", index, pageCount), columnWidth, "center"))
    if index < pageCount then
        function PageWindowNextPage()
            self:display_page(index + 1)
        end
        cechoLink(self.name, scripts.utils.str_pad("->", columnWidth, "right"), [[PageWindowNextPage()]], "Nastepna strona", true)
    else 
        cecho(self.name, scripts.utils.str_pad(" ", columnWidth, "left"))
    end
    echo(self.name, "\n\n")
end

function PageWindow:reload_page()
    self:display_page(self.currentPage)
end