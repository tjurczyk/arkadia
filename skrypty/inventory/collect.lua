scripts.inv["collect"] = scripts.inv["collect"] or { extra = {} }
scripts.inv.collect["modes"] = {
    "monety",
    "kamienie",
    "monety i kamienie",
    "druzynowe monety",
    "druzynowe kamienie",
    "druzynowe monety i kamienie",
    "nic"
}
scripts.inv.collect["type_modes"] = {
    "wszystkie",
    "srebrne",
    "zlote"
}
scripts.inv.collect["money_type"] = 1
scripts.inv.collect["current_mode"] = 3
scripts.inv.collect["footer_info_collect_to_text"] = { "M", "K", "MK", "M+", "K+", "M+K+", "" }



function scripts.inv.collect:set_mode(mode)
    if not scripts.inv.collect:check_option(mode) then
        return
    end
    scripts.inv.collect["current_mode"] = mode
end

function scripts.inv.collect:set_money_mode(mode)
    if not scripts.inv.collect:check_money_option(mode) then
        return
    end
    scripts.inv.collect["money_type"] = mode
end

function scripts.inv.collect:check_money_option(mode)
    if not scripts.inv.collect["type_modes"][mode] then
        scripts:print_log("Nie ma takiej opcji, sprawdz /zbieranie")
        return false
    else
        return true
    end
end

function scripts.inv.collect:check_option(mode)
    if not scripts.inv.collect["modes"][mode] then
        scripts:print_log("Nie ma takiej opcji, sprawdz /zbieranie")
        return false
    else
        return true
    end
end

function scripts.inv.collect:key_pressed(force, index, put_into_bag)
    put_into_bag = put_into_bag == nil and true or put_into_bag
    local from = "ciala"
    if index ~= nil then
        from = index .. ". ciala"
    end
    if scripts.inv.collect.check_body or force == true then
        if scripts.inv.collect["current_mode"] == 1 or scripts.inv.collect["current_mode"] == 3
                or scripts.inv.collect["current_mode"] == 4 or scripts.inv.collect["current_mode"] == 6 then
            if scripts.inv.collect.money_type == 1 then
                sendAll("wez monety z " .. from, true)
            elseif scripts.inv.collect.money_type == 2 then
                sendAll("wez srebrne monety z " .. from, "wez zlote monety z " .. from, true)
            elseif scripts.inv.collect.money_type == 3 then
                sendAll("wez zlote monety z " .. from, true)
            end

            if put_into_bag then
                scripts.inv:put_into_bag({ "monety" }, "money", 1)
            end
        end
        if scripts.inv.collect["current_mode"] == 2 or scripts.inv.collect["current_mode"] == 3
                or scripts.inv.collect["current_mode"] == 5 or scripts.inv.collect["current_mode"] == 6 then
            sendAll("wez kamienie z " .. from,
                "ocen kamienie",
                false)

            if put_into_bag then
                scripts.inv:put_into_bag({ "kamienie" }, "gems", 1)
            end
        end
        if table.size(scripts.inv.collect.extra) > 0 then
            for _, item in ipairs(scripts.inv.collect.extra) do
                send("wez " .. item .. " z " .. from)
                scripts.inv:put_into_bag({ item }, "other", 1)
            end
        end
        scripts.inv.collect.check_body = false
    end
end

function scripts.inv.collect:killed_action()
    if scripts.inv.collect["current_mode"] ~= 7 or table.size(scripts.inv.collect.extra) > 0 then
        cecho("\n<" .. scripts.ui:get_bind_color_backward_compatible() .. ">[bind <yellow>" .. scripts.keybind:keybind_tostring("collect_from_body") .. "<" .. scripts.ui:get_bind_color_backward_compatible() .. "> wez z ciala\n")
        scripts.inv.collect.check_body = true
    end
end

function scripts.inv.collect:team_killed_action(name)
    if scripts.inv.collect["current_mode"] ~= 4 and scripts.inv.collect["current_mode"] ~= 5
            and scripts.inv.collect["current_mode"] ~= 6 and table.size(scripts.inv.collect.extra) == 0 then
        return
    end

    if ateam.team_names[name] then
        cecho("\n<" .. scripts.ui:get_bind_color_backward_compatible() .. ">[bind <yellow>ctrl+3]<" .. scripts.ui:get_bind_color_backward_compatible() .. "> wez z ciala\n")
        scripts.inv.collect.check_body = true
    end
end

function scripts.inv.collect:print_help()
    scripts:print_log("Wspierane opcje zbierania:")
    for k, v in pairs(scripts.inv.collect["modes"]) do
        echo(k .. " - " .. v .. "\n")
    end
    scripts:print_log("Wspierane opcje zbierania poszczegolnych monet:")
    for k, v in pairs(scripts.inv.collect["type_modes"]) do
        echo(k .. " - " .. v .. "\n")
    end
    scripts:print_log("Aktualne ustawienie: " .. scripts.inv.collect.modes[scripts.inv.collect["current_mode"]])
    scripts:print_log("Aktualne ustawienie monet: " .. scripts.inv.collect.type_modes[scripts.inv.collect["money_type"]])
    scripts:print_log("Ustaw opcje poprzez zawolanie '/zbieranie [numer opcji zbierania]")
    scripts:print_log("Ustaw opcje poprzez zawolanie '/zbieranie_monet [numer opcji zbierania monet]")
    scripts:print_log("Zbierane extra: <orange>" .. table.concat(scripts.inv.collect.extra, ", "))
end

function scripts.inv.add_to_collect_extra(extra_collect)
    table.insert(scripts.inv.collect.extra, extra_collect)
    scripts:print_log("Ok, dodalem '" .. extra_collect .. "' do zbieranych extra. Aktualnie zbierane extra: " .. table.concat(scripts.inv.collect.extra, ", "))
end

function scripts.inv.remove_from_collect_extra(extra_collect, remove_all)
    if remove_all == true then
        scripts.inv.collect.extra = {}
        scripts:print_log("Ok, wyczyscilem zbierane extra")
    else
        for k, v in pairs(scripts.inv.collect.extra) do
            if v == extra_collect then
                table.remove(scripts.inv.collect.extra, k)
                scripts:print_log("Ok, usunalem '" .. v .. "' ze zbieranych extra")
            end
        end
    end
end

function scripts.inv.after_counting_collect(bodies_count)
    local count = scripts.counted_string_to_int[bodies_count]
    for i = 1, count, 1 do
        local last = i == count
        scripts.inv.collect:key_pressed(true, i, last)
    end
end

