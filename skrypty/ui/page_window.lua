PageWindow = PageWindow or {}

function PageWindow:new(name, title, restoreLayout, autoDock, dockingArea)
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
    return o
end

function PageWindow:open()
    local width, height, padding = 700, 480, 30
    openUserWindow(self.windowName, self.restoreLayout, self.autoDock, self.dockingArea)
    setUserWindowTitle(self.windowName .. "_window", self.title)
    moveWindow(self.windowName, -10, width)
    resizeWindow(self.windowName, width, height)
    createMiniConsole(self.windowName, self.name, padding, padding, width - padding * 2, height - padding * 2)
    setWindowWrap(self.name, getColumnCount(self.name))
    setFont(self.name, getFont())
    self:displayPage(1)
end

function PageWindow:addPage(contentGeneratorFunction)
    table.insert(self.pagesConntentGenerators, contentGeneratorFunction)
end

function PageWindow:displayPage(index)
    clearUserWindow(self.name)
    self:displayHeader(index)
    display(self.pagesConntentGenerators)
    if self.pagesConntentGenerators[index] then
        self.pagesConntentGenerators[index](self, index)
    else
        echo("Strona nie istnieje")
    end
end

function PageWindow:displayHeader(index)
    local charColunCount = getColumnCount(self.name) -- TODO: replace with getWindowWrap when available
    local columnWidth = math.floor((charColunCount - 2) / 3)
    if index ~= 1 then
        cecho(self.name, scripts.utils.str_pad("<-", columnWidth, "left"))
    else
        cecho(self.name, scripts.utils.str_pad("", columnWidth, "left"))
    end
    cecho(self.name, scripts.utils.str_pad(string.format("=== Strona %s ===", index), columnWidth, "center"))
    if index < table.size(self.pagesConntentGenerators) then
        cecho(self.name, scripts.utils.str_pad("->", columnWidth, "right"))
    else 
        cecho(self.name, scripts.utils.str_pad("", columnWidth, "left"))
    end
    echo(self.name, "\n\n")
end