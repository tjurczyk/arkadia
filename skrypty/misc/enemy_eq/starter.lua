function misc:run_check_enemies(mode)
    enemies_to_check = {}
    check_enemies_routine = nil
    misc["checking_enemies"] = true
    misc["enemy_eq"] = {}

    misc:get_to_check_list(mode)
    display(enemies_to_check)
    check_enemies_routine = coroutine.create(check_enemies_func)
    coroutine.resume(check_enemies_routine)
end

function misc:get_to_check_list(mode)
    if mode == 1 then
        -- everyone
        for k, v in pairs(gmcp.objects.nums) do
            if ateam.objs[v] and v ~= ateam.my_id then
                table.insert(enemies_to_check, v)
            end
        end
        --elseif mode == 2 then
        -- not me/team
        --for k, v in pairs(gmcp.objects.nums) do
        --  if ateam.objs[v] and v ~= ateam.my_id and ateam.objs[v]["team"] ~= true then
        --    table.insert(enemies_to_check, v)
        --  end
        --end
    elseif mode == 3 then
        -- enemies
        for k, v in pairs(gmcp.objects.nums) do
            if ateam.objs[v] and (ateam.objs[v]["enemy"] == true or ateam.team[ateam.objs[v]["attack_num"]]) then
                table.insert(enemies_to_check, v)
            end
        end
    else
        error("Wrong input to misc:get_to_check_list(mode): " .. mode)
    end
end


