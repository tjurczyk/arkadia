function scripts.boxes.update()
    if not amap or not amap.curr or not amap.curr.id or amap.curr.id == -1 then
        scripts:print_log("Problem z mapperem")
        return
    end

    if not scripts.boxes.valid_banks[amap.curr.id] then
        scripts:print_log("Ta lokacja wydaje sie nie byc bankiem")
        return
    end

    if not scripts.character_name then
        scripts:print_log("Korzystanie z depozytow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    scripts.boxes.current_box = scripts.boxes.valid_banks[amap.curr.id]

    enableTrigger("boxes")
    tempTimer(1, [[ send("przejrzyj depozyt") ]])
    tempTimer(2, function() scripts.boxes.post_update() end)
end

function scripts.boxes.update_box(update_str)
    local retrieved = db:fetch(scripts.boxes.db.boxes, {
        db:eq(scripts.boxes.db.boxes.character, scripts.character_name),
        db:eq(scripts.boxes.db.boxes.bank, scripts.boxes.current_box)
    })

    if not retrieved or table.size(retrieved) == 0 then
        if not db:add(scripts.boxes.db.boxes, { character = scripts.character_name, bank = scripts.boxes.current_box }) then
            scripts.boxes.current_box = nil
            scripts:print_log("Cos nie tak z baza")
            return
        end
    end

    local bank_item = db:fetch(scripts.boxes.db.boxes, {
        db:eq(scripts.boxes.db.boxes.character, scripts.character_name),
        db:eq(scripts.boxes.db.boxes.bank, scripts.boxes.current_box)
    })[1]

    bank_item["box"] = update_str

    bank_item["updated"] = getTime(true, "dd/MM/yyyy hh:mm:ss")
    if not db:update(scripts.boxes.db.boxes, bank_item) then
        scripts.boxes.current_box = nil
        scripts:print_log("Cos nie tak z baza")
        return
    end
end

function scripts.boxes.post_update()
    scripts:print_log("Ok, depozyt '" .. scripts.boxes.current_box .. "' uaktualniony")
    scripts.boxes.current_box = nil
    disableTrigger("boxes")
end

function scripts.boxes.print_boxes()
    if not scripts.character_name then
        scripts:print_log("Korzystanie z depozytow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local retrieved = db:fetch(scripts.boxes.db.boxes, { db:eq(scripts.boxes.db.boxes.character, scripts.character_name) })

    cecho("\n <orange>Postac: " .. "<yellow>" .. scripts.character_name .. "\n\n")

    for k, v in pairs(retrieved) do
        local str = string.split(v["box"], "Twoj depozyt zawiera ")[2]
        local print_str = "<green>" .. v["box"]

        if str then
            print_str = scripts.boxes.get_printable_text(str)
        end

        cecho(" <light_slate_blue>bank<grey>:    <tomato>" .. v["bank"] .. "\n" .. print_str .. "\n\n")
    end
end

function scripts.boxes.get_printable_text(txt)
    local ret_txt = "<grey>"
    local items = scripts.utils:extract_string_list(txt)
    for k, v in pairs(items) do
        local amount_tmp = "     " .. tostring(v["amount"])
        amount_str = string.sub(amount_tmp, string.len(amount_tmp) - 4, string.len(amount_tmp))
        ret_txt = ret_txt .. "<grey>" .. amount_str .. " | <green>" .. v["name"] .. "\n"
    end

    return ret_txt
end

