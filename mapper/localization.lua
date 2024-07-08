amap.localization = amap.localization or {
    current_exit = "",
    current_short = ""
}

amap.localization.db = db:create("roomdescriptions", {
    roomdescriptions = {
        room_id = -1,
        short = "",
        exitDesc = "",
        _index = { "room_id" },
        _unique = { "room_id" },
        _violations = "REPLACE"
    }
})

function amap.localization:try_to_locate()
    local results = db:fetch(self.db.roomdescriptions, db:AND(
        db:eq(self.db.roomdescriptions.short, self.current_short),
        db:eq(self.db.roomdescriptions.exitDesc, self.current_exit)
    ))
    if #results == 1 then
        amap:set_position(results[1].room_id, true)
        return true
    end
end
