amap.localization = amap.localization or {
    current_exit = "",
    current_short = ""
}

amap.localization.db = db:create("roomDescriptions", {
    roomDescriptions = {
        room_id = -1,
        short = "",
        exitDesc = "",
        _index = { "room_id" },
        _unique = { "room_id" },
        _violations = "REPLACE"
    }
})

function amap.localization:try_to_locate()
    local results = db:fetch(self.db.roomDescriptions, db:AND(
        db:eq(self.db.roomDescriptions.short, self.current_short),
        db:eq(self.db.roomDescriptions.exitDesc, self.current_exit)
    ))
    if #results == 1 then
        amap:set_position(results[1].room_id, true)
        return true
    else
        for k,v in pairs(results) do
            scripts:print_log("Mozliwa lokacja: " .. v.room_id)
        end
    end
end