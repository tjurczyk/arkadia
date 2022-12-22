misc.improve = misc.improve or {}
misc.improve["current_improve_level"] = misc.improve["current_improve_level"] or 0
misc.improve["level_snapshots"] = misc.improve["level_snapshots"] or {}
misc.improve["improve2_enabled"] = true
misc.improve["improve_start_timestamp"] = nil

misc.improve["levels"] = {
    [0] = "zadne/mini",
    [1] = "nieznaczne",
    [2] = "bardzo male",
    [3] = "male",
    [4] = "nieduze",
    [5] = "zadowalajace",
    [6] = "spore",
    [7] = "dosc duze",
    [8] = "znaczne",
    [9] = "duze",
    [10] = "bardzo duze",
    [11] = "ogromne",
    [12] = "imponujace",
    [13] = "wspaniale",
    [14] = "gigantyczne",
    [15] = "niebotyczne"
}

misc.improve["db_improvee"] = db:create("improvee", {
    improvee = {
        year = 0,
        month = 0,
        day = 0,
        hour = "",
        val = 0,
        character = "",
    }
})

