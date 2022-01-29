function herbs:put_herb_bag_down(bag_id)
    sendAll("odbezpiecz " .. tostring(bag_id) .. ". swoj woreczek", "odtrocz " .. tostring(bag_id) .. ". swoj woreczek", "odloz " .. tostring(bag_id) .. ". swoj woreczek")
end

function herbs:use_herb(herb_id, action, amount)
    self:use_herbs({[herb_id] = {action = action, amount = amount}})
end

function herbs:use_herbs(entries)
    if herbs.pre_use then misc:run_separeted_command(herbs.pre_use) end

    for herb_id, entry in pairs(entries) do
        herbs:perform_herb_use(herb_id, entry.action, entry.amount)
    end

    if herbs.post_use then misc:run_separeted_command(herbs.post_use) end
end

function herbs:perform_herb_use(herb_id, herb_action, herb_amount)
    herbs:get_herbs(herb_id, herb_amount)
    local use_herb_command = herb_action
    use_herb_command = use_herb_command .. " " .. herb_amount .. " " .. herbs:get_case(herb_id, herb_amount)
    send(use_herb_command)
end

function herbs:give_herbs_teammate(teammate_name, herb_id, herb_amount)
    local team_member_obj = ateam:get_team_member_obj_id(teammate_name)

    if not team_member_obj then
        scripts:print_log("Nie ma takiego czlonka druzyny")
        return
    end

    if not herbs.data["herb_id_to_odmiana"][herb_id] then
        scripts:print_log("Nie ma takiego ziola")
        return
    end

    herbs:get_herbs(herb_id, herb_amount)

    local command_to_teammate = "daj ziola " .. team_member_obj
    send(command_to_teammate)
end

function herbs:repack_from_to_bag(from_bag, to_bag)
    local string_from_bag = tostring(from_bag)
    local string_to_bag = tostring(to_bag)
    sendAll("otworz " .. string_from_bag .. ". swoj woreczek", "wez ziola z " .. string_from_bag .. ". swojego woreczka", "otworz " .. string_to_bag .. ". swoj woreczek", "wloz ziola do " .. string_to_bag .. ". swojego woreczka", "otworz " .. string_from_bag .. ". swoj woreczek", "wloz ziola do " .. string_from_bag .. ". swojego woreczka", "zamknij otwarte woreczki", true)
end

function herbs:do_pre_actions()
    self.restore = scripts.character.options:set_temporary("parsing_order", 1)
    herbs:do_pre_post_actions("pre")
end

function herbs:do_post_actions()
    herbs:do_pre_post_actions("post")
    self.restore()
end

function herbs:do_pre_post_actions(pre_post)
    local actions = nil
    if pre_post == "pre" then
        actions = herbs.pre_actions
    elseif pre_post == "post" then
        actions = herbs.post_actions
    end
    misc:run_separeted_command(actions)
end
