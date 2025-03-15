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
        [26630] = "parravon",
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

function scripts.boxes:update()
    if self.trigger then
        scripts:print_log("Aktualizacja depozytu juz dziala")
        return
    end

    if not amap or not amap.curr or not amap.curr.id or amap.curr.id == -1 then
        scripts:print_log("Problem z mapperem")
        return
    end

    if not self.valid_banks[amap.curr.id] then
        scripts:print_log("Ta lokacja wydaje sie nie byc bankiem")
        return
    end

    if not scripts.character_name then
        scripts:print_log("Korzystanie z depozytow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    self.current_box = self.valid_banks[amap.curr.id]

    self.trigger = tempRegexTrigger(
        "(Twoj depozyt jest pusty|Nie posiadasz wykupionego depozytu|Twoj depozyt zawiera .*)\\.$", function()
            self:update_box(matches[1])
            self.trigger = nil
        end, 1)
    send("przejrzyj depozyt")
end

function scripts.boxes:update_box(update_str)
    local retrieved = db:fetch(self.db.boxes, {
        db:eq(self.db.boxes.character, scripts.character_name),
        db:eq(self.db.boxes.bank, self.current_box)
    })

    if not retrieved or table.size(retrieved) == 0 then
        if not db:add(self.db.boxes, { character = scripts.character_name, bank = self.current_box }) then
            self.current_box = nil
            scripts:print_log("Cos nie tak z baza")
            return
        end
    end

    local bank_item = db:fetch(self.db.boxes, {
        db:eq(self.db.boxes.character, scripts.character_name),
        db:eq(self.db.boxes.bank, self.current_box)
    })[1]

    bank_item["box"] = update_str

    bank_item["updated"] = getTime(true, "dd/MM/yyyy hh:mm:ss")
    if not db:update(self.db.boxes, bank_item) then
        self.current_box = nil
        scripts:print_log("Cos nie tak z baza")
        return
    end

    scripts:print_log("Ok, depozyt '" .. self.current_box .. "' uaktualniony", true)
    self.current_box = nil
end

function scripts.boxes:print_boxes()
    if not scripts.character_name then
        scripts:print_log("Korzystanie z depozytow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local retrieved = db:fetch(self.db.boxes, { db:eq(self.db.boxes.character, scripts.character_name) })

    cecho("\n <orange>Postac: " .. "<yellow>" .. scripts.character_name .. "\n\n")

    for k, v in pairs(retrieved) do
        local str = string.split(v["box"], "Twoj depozyt zawiera ")[2]
        local print_str = "<green>" .. v["box"]

        if str then
            print_str = self:get_printable_text(str)
        end

        cecho(" <light_slate_blue>bank<grey>:    <tomato>" .. v["bank"] .. "\n" .. print_str .. "\n\n")
    end
end

function scripts.boxes:get_printable_text(txt)
    local ret_txt = "<grey>"
    local items = scripts.utils:extract_string_list(txt)
    for k, v in pairs(items) do
        local amount_tmp = "     " .. tostring(v["amount"])
        amount_str = string.sub(amount_tmp, string.len(amount_tmp) - 4, string.len(amount_tmp))
        ret_txt = ret_txt .. "<grey>" .. amount_str .. " | <green>" .. v["name"] .. "\n"
    end

    return ret_txt
end

function alias_func_skrypty_boxes_update_bank()
    scripts.boxes:update()
end

function alias_func_skrypty_boxes_print_banks()
    scripts.boxes:print_boxes()
end
