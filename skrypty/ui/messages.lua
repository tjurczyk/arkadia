scripts.messages = scripts.messages or {}

local bar_width = 40

function scripts.messages:warning(message)
    self:show(message, "red")
end

function scripts.messages:show(message, color)
    local bar = string.format("<%s>%s<reset>\n", color, string.rep("*", bar_width))
    local middle_line = string.format("<%s>%s<reset>\n", color, scripts.utils.str_pad(message, bar_width, "center"))
   
    echo("\n")
    cecho(bar)
    cecho(middle_line)
    cecho(bar)
end