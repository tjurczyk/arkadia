scripts.dev = scripts.dev or {}


function scripts.dev:init()
    addCommandLineMenuEvent("/fake", "pasteFake")

    self.handler = scripts.event_register:force_register_event_handler(self.handler, "pasteFake", function() 
        local text = string.gsub(getClipboardText(), "[\r|\n]", "")
        expandAlias("/fake " .. text)
    end)
end

scripts.dev:init()