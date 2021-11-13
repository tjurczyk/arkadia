function ateam:check_team_here()
    local not_here = {}

    -- first, clean team
    for k, v in pairs(ateam.team) do
        if type(v) == "number" and ateam.objs[v]["team"] == false then
            local letter = ateam.team[v]
            ateam.team[v] = nil
            ateam.team[letter] = nil
        end
    end

    for k, v in pairs(ateam.team) do
        if type(v) == "number" and table_has_value(gmcp.objects.nums, v) == false then
            table.insert(not_here, ateam.objs[v]["desc"])
        end
    end

    if table.size(not_here) == 0 then
        scripts:print_log("Wszyscy sa")
    else
        scripts:print_log("Brakuje: <LawnGreen>" .. table.concat(not_here, ", "))
    end
end

function ateam:check_team_last_activity()

    self.triggerId = self.triggerId or nil;
    if self.triggerId then
        killTrigger(self.triggerId)
    end

    local members = {}
    local max_length = 0
    
    for k, v in pairs(ateam.team) do
        if type(v) == "number" and v ~= ateam.my_id and table_has_value(gmcp.objects.nums, v) == true then
            local desc = ateam.objs[v]["desc"]
            table.insert(members, desc)
            if string.len(desc) > max_length then
                max_length = string.len(desc)
            end
        end
    end

    if table.size(members) == 0 then
        scripts:print_log("Nie jestes w druzynie")
        return
    end

    self.triggerId = tempTrigger("Aktywnosc", function() 
        selectCurrentLine()
        local line = getCurrentLine()

        local color = 'ansi_light_red'
        if string.find(line, ': aktywn') then
            color = 'green'
        end
        fg(color)
        resetFormat()

        selectString("Aktywnosc          :", 1)
        local replacement = "Aktywnosc "..scripts.utils.str_pad(members[1]..":", max_length + 1)
        replace(replacement)
        table.remove(members,1)
    end, table.size(members))

    for k, v in pairs(members) do
        send('ostatnio ' .. v, false)
    end
end

function ateam:can_perform_sneaky_attack()
    local hidden_count_number = tonumber(scripts.ui.states_window_nav_states.hidden_state)
    if not hidden_count_number then
        return false
    end

    local sneaky_attack_cond_number = tonumber(ateam.sneaky_attack_cond)
    if hidden_count_number >= 15 or (sneaky_attack_cond_number and hidden_count_number >= sneaky_attack_cond_number) then
        return true
    end
    return false
end

