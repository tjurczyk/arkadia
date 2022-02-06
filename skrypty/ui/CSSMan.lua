-- CSSMan by Vadi. Public domain.

CSSMan = {}
CSSMan.__index = CSSMan

function CSSMan.new(stylesheet)
    local obj = { stylesheet = {} }
    setmetatable(obj, CSSMan)
    obj:applyStyleSheet(stylesheet)
    return obj
end

function CSSMan:applyStyleSheet(stylesheet)
    assert(type(stylesheet) == "string", "CSSMan.new: no stylesheet provided. A possible error is that you might have used CSSMan.new, not CSSMan:new")

    local trim = string.trim
    for line in stylesheet:gmatch("[^\r\n]+") do
        local attribute, value = line:match("^(.-):(.-);$")
        if attribute and value then
            attribute, value = trim(attribute), trim(value)
            self.stylesheet[attribute] = value
        end
    end
end

function CSSMan:set(key, value)
    self.stylesheet[key] = value
end

function CSSMan:get(key)
    return self.stylesheet[key]
end

function CSSMan:getCSS(key)
    local lines, concat = {}, table.concat
    for k, v in pairs(self.stylesheet) do lines[#lines + 1] = concat({ k, ": ", v, ";" }) end
    return concat(lines, "\n")
end

function CSSMan:gettable()
    return self.stylesheet
end

function CSSMan:settable(tbl)
    assert(type(tbl) == "table", "CSSMan:settable: table expected, got " .. type(tbl))

    self.stylesheet = tbl
end

