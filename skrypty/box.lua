scripts["boxes"] = scripts["boxes"] or {
    valid_banks = {
        [5364] = "ebino",
        [20164] = "val'kare",
        [15395] = "kv",
        [6739] = "kraina zgromadzenia",
        [7334] = "nuln",
        [4661] = "quenelles",
        [10416] = "skellige",
        [9776] = "baccala",
        [4574] = "daevon",
        [2687] = "novigrad",
        [1467] = "carbon",
        [316] = "wyzima",
        [893] = "scala",
        [1999] = "rinde",
        [8059] = "guleta",
    }
}

scripts.boxes.db = db:create("boxestwo", {
    boxes = {
        character = "",
        bank = "",
        type = -1,
        box = "",
        updated = "",
        room_id = -1,
        changed = db:Timestamp("CURRENT_TIMESTAMP"),
        _index = { "name" }
    }
})


