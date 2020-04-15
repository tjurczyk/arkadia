function scripts:bags_print_help()
    cecho("+-------------------------- <green>Arkadia skrypty, ver " .. string.sub(scripts.ver .. "   ", 0, 5) .. "<grey> --------------------------+\n")
    cecho("|                                                                                |\n")
    cecho("| Opis dzialania pojemnikow: http://arkadia.kamerdyner.net/pojemniki.html        |\n")
    cecho("|                                                                                |\n")
    cecho("+--------------------------------------------------------------------------------+\n\n")

    types = { "money", "gems", "food", "other" }

    for i, type_name in pairs(types) do
        for var = 1, 10 do
            local bag_id = type_name .. "_bag_" .. tostring(var)
            if scripts.inv[bag_id] then
                local bag = string.sub(bag_id .. "      ", 1, 13)
                local bag_type = string.sub(scripts.inv[bag_id] .. "              ", 1, 15)

                cecho("- <orange>pojemnik:<grey> <green>" .. bag .. "\n")
                cecho("  <orange>typ:<grey> " .. bag_type .. "\n")
                if scripts.inv["desc_" .. bag_id] then
                    cecho("  <orange>opis:<grey> " .. scripts.inv["desc_" .. bag_id] .. "\n")
                end

                local dopelniacz = scripts.inv:get_bag_in_dopelniacz(bag_id)
                if dopelniacz then
                    cecho("  <orange>dopelniacz:<grey> " .. dopelniacz .. "\n")
                end

                local biernik = scripts.inv:get_bag_in_biernik(bag_id)
                if biernik then
                    cecho("  <orange>biernik:<grey> " .. biernik .. "\n")
                end

                local pre_commands = scripts.inv:get_pre_commands_for_bag(bag_id)
                if pre_commands and table.size(pre_commands) > 0 then
                    cecho("  <orange>przed-komendy:<grey> " .. table.concat(pre_commands, ";") .. "\n")
                end

                local post_commands = scripts.inv:get_post_commands_for_bag(bag_id)
                if post_commands and table.size(post_commands) > 0 then
                    cecho("  <orange>po-komendy:<grey> " .. table.concat(post_commands, ";") .. "\n")
                end

                cecho("\n")
            end
        end
    end
end

