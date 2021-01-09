PageWindow = PageWindow or {}

function PageWindow:new(name, title, restoreLayout, autoDock, dockingArea, properties)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.name = name
    o.windowName = o.name .. "_window"
    o.title = title
    o.restoreLayout = restoreLayout
    o.autoDock = autoDock
    o.dockingArea = dockingArea
    o.pagesConntentGenerators = {}
    o.properties = properties or {
        ["width"] = 900,
        ["height"] = 530,
        ["padding"] = 15,
        ["x"] = 30,
        ["y"] = 30
    }
    return o
end

function PageWindow:open()
    local width, height, padding = self.properties.width, self.properties.height, self.properties.padding
    openUserWindow(self.windowName, self.restoreLayout, self.autoDock, self.dockingArea)
    setUserWindowTitle(self.windowName, self.title)
    moveWindow(self.windowName, self.properties.x, self.properties.y)
    resizeWindow(self.windowName, width, height)
    createMiniConsole(self.windowName, self.name, padding, padding, width - padding * 2, height - padding * 2)
    setFont(self.name, getFont())
    setWindowWrap(self.name, getColumnCount(self.name))
    showWindow(self.windowName)
    self:displayPage(1)
end

function PageWindow:addPage(contentGeneratorFunction)
    table.insert(self.pagesConntentGenerators, contentGeneratorFunction)
end

function PageWindow:displayPage(index)
    self.currentPage = index
    clearUserWindow(self.name)
    self:displayHeader(index)
    if self.pagesConntentGenerators[index] then
        self.pagesConntentGenerators[index](self, index)
    else
        echo("Strona nie istnieje")
    end
end

function PageWindow:displayHeader(index)
    local charColunCount = getColumnCount(self.name) -- TODO: replace with getWindowWrap when available
    local columnWidth = math.floor((charColunCount - 2) / 3)
    local pageCount = table.size(self.pagesConntentGenerators)
    if index ~= 1 then
        function PageWindowPrevPage()
            self:displayPage(index - 1)
        end
        cechoLink(self.name, scripts.utils.str_pad("<-", columnWidth, "left"), [[PageWindowPrevPage()]], "Nastepna strona", true)
    else
        cecho(self.name, scripts.utils.str_pad(" ", columnWidth, "left"))
    end
    cecho(self.name, scripts.utils.str_pad(string.format("=== Strona %d/%d ===", index, pageCount), columnWidth, "center"))
    if index < pageCount then
        function PageWindowNextPage()
            self:displayPage(index + 1)
        end
        cechoLink(self.name, scripts.utils.str_pad("->", columnWidth, "right"), [[PageWindowNextPage()]], "Nastepna strona", true)
    else 
        cecho(self.name, scripts.utils.str_pad(" ", columnWidth, "left"))
    end
    echo(self.name, "\n\n")
end

function PageWindow:reloadPage()
    self:displayPage(self.currentPage)
end