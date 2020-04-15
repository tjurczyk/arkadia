function scripts.inv:construct_bag_id(bag_type, bag_count)
    --[[
    Constructs bag id and returns it.
      --]]
    if not bag_type or not bag_count then
        error("bag_type or/and bag_count is nil in scripts.inv:construct_bag_id")
    end

    local bag_full_id = bag_type .. "_bag_"
    if not bag_count then
        bag_full_id = bag_full_id .. "1"
    else
        bag_full_id = bag_full_id .. bag_count
    end

    return bag_full_id
end

function scripts.inv:put_into_bag(things, bag_type, bag_count)
    --[[
      Executes putting into the bag.
      --]]
    scripts.inv:_put_get_bag("wloz", things, bag_type, bag_count)
end

function scripts.inv:get_from_bag(things, bag_type, bag_count)
    --[[
      Executes getting from the bag.
      --]]

    scripts.inv:_put_get_bag("wez", things, bag_type, bag_count)
end

function scripts.inv:_put_get_bag(operation, things, bag_type, bag_count)
    --[[
      Executes pre_commands, putting or getting "things" into/from the bag and post_commands.

      Args:
      - things (table): things to put in (e.g.: "{["monety"],["kamienie"],["czapki"])
      - bag_type (string): a type (e.g.: "money", "food")
      - bag_count (int): which bag for that
      --]]

    if not operation or not things then
        error("no operation or/and no things in scripts.inv:_put_get_bag")
    end

    local bag_id = scripts.inv:construct_bag_id(bag_type, bag_count)
    local bag_name = scripts.inv[bag_id]

    if not bag_name then
        scripts:print_log("Brak zdefiniowanego pojemnika dla " .. bag_id)
        return
    end

    local bag_in_form = scripts.inv:get_bag_in_dopelniacz(bag_id)

    local commands = {}

    local pre_commands = scripts.inv:get_pre_commands_for_bag(bag_id)
    local post_commands = scripts.inv:get_post_commands_for_bag(bag_id)

    table_concat(commands, pre_commands)

    for k, v in pairs(things) do
        if operation == "wloz" then
            table.insert(commands, "wloz " .. v .. " do " .. bag_in_form)
        elseif operation == "wez" then
            table.insert(commands, "wez " .. v .. " z " .. bag_in_form)
        else
            error("unknown operation in scripts.inv:_put_get_bag")
        end
    end

    table_concat(commands, post_commands)
    table_concat(commands, { true })
    sendAll(unpack(commands), true)
end

function scripts.inv:decorate_command_with_proper_bag_forms(command)
    -- Decorates the command with the proper bag forms. For example:
    -- "wez <biernik_other_bag_1> z <dopelniacz_money_bag_2>"
    -- will replace both macros with their proper forms.
    -- returns decorated string.
    local replaced_command = command

    for bag_macro in string.gmatch(command, "<[^>]+>") do

        local proper_bag_macro = string.sub(bag_macro, 2, -2)
        local elements = string.split(proper_bag_macro, "_")

        local replaced_bag_macro = nil

        if table.size(elements) == 3 then
            replaced_bag_macro = scripts.inv[proper_bag_macro]
        else
            if elements[1] ~= "dopelniacz" and elements[1] ~= "biernik" and elements[1] ~= "desc" then
                error("wrong arg form passed to scripts.inv:decorate_command_with_proper_bag_forms: '" .. bag_macro .. "'")
            end

            local this_form = elements[1]
            local this_bag_id = table.concat({ unpack(elements, 2, 5) }, "_")
            local this_bag_name = scripts.inv[this_bag_id]

            replaced_bag_macro = scripts.inv[proper_bag_macro]

            if replaced_bag_macro == nil then
                -- this case is not defined, take raw form
                replaced_bag_macro = ""
            else
                replaced_bag_macro = replaced_bag_macro .. " "
            end

            if this_form == "desc" then
                replaced_bag_macro = replaced_bag_macro .. this_bag_name
            elseif this_form == "dopelniacz" then
                replaced_bag_macro = replaced_bag_macro .. scripts.inv.bag_in_dopelniacz[this_bag_name]
            elseif this_form == "biernik" then
                replaced_bag_macro = replaced_bag_macro .. scripts.inv.bag_in_biernik[this_bag_name]
            end
        end
        replaced_command = string.gsub(replaced_command, bag_macro, replaced_bag_macro, 1)
    end

    return replaced_command
end


