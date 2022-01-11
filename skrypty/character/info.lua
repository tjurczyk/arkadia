scripts.character.info_update = scripts.character.info_update or {}
scripts.character.info = scripts.character.info or {
    gender = "male"
}

function scripts.character.info_update:init()
    self.handler = scripts.event_register:force_register_event_handler(self.handler, "gmcp.char.info", function()
        scripts.character.info = gmcp.char.info
    end)
end

function scripts.character:is_male()
    return self.info.gender == "male"
end

scripts.character.info_update:init()