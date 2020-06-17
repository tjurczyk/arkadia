amap.db.personal_keys = amap.db.personal_keys or {
    db_name = "personalMapKeys",
    backup_keys = {}
}

function amap.db.personal_keys:init()
    self:create_db()
    scripts.event_register:register_singleton_event_handler("amap.db.personal_keys.save", "amapMapKeysSave", function()
        self:save_keys()
    end)
    scripts.event_register:register_singleton_event_handler("amap.db.personal_keys.load", "amapMapKeysLoad", function()
        self:load_keys()
    end)
end

function amap.db.personal_keys:create_db()
    self.db = db:create(self.db_name, {
        backup = {
            room_id = "",
            key = "",
            hash = "",
            value = "",
            _index = { "room_id" },
            _unique = { "hash" }
        }
    })
end

function amap.db.personal_keys:save_keys()
    if table.is_empty(self.backup_keys) then
        return
    end
    db:delete(self.db.backup, true)
    local rooms = getRooms()
    for id, _ in pairs(rooms) do
        for _, key in pairs(self.backup_keys) do
            local value = getRoomUserData(id, key)
            if value ~= nil and value ~= "" then
                self:add(id, key, value)
            end
        end
    end
    scripts:print_log("Klucze mapy zapisane (" .. table.concat(self.backup_keys, ", ") .. ")")
end

function amap.db.personal_keys:add(room_id, key, value)
    db:add(self.db.backup, { room_id = room_id, key = key, hash = room_id .. "#" .. key, value = value })
end

function amap.db.personal_keys:get_all()
    return db:fetch(self.db.backup)
end

function amap.db.personal_keys:load_keys()
    if table.is_empty(self.backup_keys) then
        return
    end
    for _, room_key in pairs(self:get_all()) do
        local value_to_compare = getRoomUserData(room_key.room_id, room_key.key)
        if value_to_compare ~= nil and value_to_compare ~= "" and value_to_compare ~= room_key.value then
            scripts:print_log(string.format(
                    "RoomID: %s | Klucz: %s | Wartosc z mapy: %s | Wartosc z bazy: %s",
                    room_key.room_id,
                    room_key.key,
                    value_to_compare,
                    room_key.value
            ))
            setRoomUserData(room_key.room_id, room_key.key, room_key.value)
        end
    end
    scripts:print_log("Zaladowano klucze z bazy")
end

amap.db.personal_keys:init()
