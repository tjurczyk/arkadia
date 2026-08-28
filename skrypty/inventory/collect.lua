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
scripts.inv.collect["collect_pending"] = false
scripts.inv.collect["collect_armed"] = false
scripts.inv.collect["handlers"] = scripts.inv.collect["handlers"] or {}
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
        if scripts.inv.collect["current_mode"] == 2 or scripts.inv.collect["current_mode"] == 3 or scripts.inv.collect["current_mode"] == 5 or scripts.inv.collect["current_mode"] == 6 then
            sendAll("wez kamienie z " .. from, "ocen kamienie", false)
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

function scripts.inv.collect:collect_all()
    dead_bodies_trigg = tempRegexTrigger("^.*Doliczyl.s sie ([a-z]+) sztuk(|i)\\.$", function() scripts.inv.after_counting_collect(matches[2]) end, 1)
    send("policz wszystkie ciala")
end

function scripts.inv.collect:collect_all_armed()
    if not scripts.inv.collect.collect_armed then
        return
    end
    scripts.inv.collect.collect_armed = false
    scripts.inv.collect:collect_all()
end

function scripts.inv.collect:maybe_arm_after_combat()
    if not scripts.inv.collect.collect_pending then
        return
    end
    if ateam.event.me_attacked or ateam.event.team_attacked then
        return
    end
    scripts.inv.collect.collect_pending = false
    scripts.inv.collect.collect_armed = true
    scripts.utils.echobind("wez ze wszystkich cial", function() scripts.inv.collect:collect_all_armed() end, "wez ze wszystkich cial", "collect_from_body", 1)
end

function scripts.inv.collect:killed_action()
    if scripts.inv.collect["current_mode"] ~= 7 or table.size(scripts.inv.collect.extra) > 0 then
        scripts.inv.collect.collect_pending = true
        scripts.inv.collect.check_body = true
        scripts.inv.collect:maybe_arm_after_combat()
    end
end

function scripts.inv.collect:team_killed_action(name)
    if scripts.inv.collect["current_mode"] ~= 4 and scripts.inv.collect["current_mode"] ~= 5
            and scripts.inv.collect["current_mode"] ~= 6 and table.size(scripts.inv.collect.extra) == 0 then
        return
    end

    if ateam.team_names[name] then
        scripts.inv.collect.collect_pending = true
        scripts.inv.collect.check_body = true
        scripts.inv.collect:maybe_arm_after_combat()
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

function scripts.inv.collect:init()
    for _, event_id in pairs(self.handlers) do
        scripts.event_register:kill_event_handler(event_id)
    end

    table.insert(self.handlers, scripts.event_register:register_event_handler("ateam_am_attacked", function(_, state) if not state then scripts.inv.collect:maybe_arm_after_combat() end end))
    table.insert(self.handlers, scripts.event_register:register_event_handler("ateam_teammate_attacked", function(_, state) if not state then scripts.inv.collect:maybe_arm_after_combat() end end))
    table.insert(self.handlers, scripts.event_register:register_event_handler("amapNewLocation", function() scripts.inv.collect:reset_collect_state() end))
end

function scripts.inv.collect:reset_collect_state()
    scripts.inv.collect.collect_pending = false
    scripts.inv.collect.collect_armed = false
end

scripts.inv.collect:init()

