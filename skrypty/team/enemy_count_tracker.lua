ateam.current_enemies = {}

if ateam["enemy_count_gmcp_finished_handler"] == nil then
  ateam.enemy_count_gmcp_finished_handler = scripts.event_register:register_singleton_event_handler(nil, "gmcp_parsing_finished", "enemy_count_gmcp_parsing_finished", false)
end

if ateam["enemy_count_amap_new_location_handler"] == nil then
    ateam.enemy_count_amap_new_location_handler = scripts.event_register:register_singleton_event_handler(nil, "amapNewLocation", "enemy_count_reset_current_enemies_when_necessary", false)
end


if ateam["enemy_count_panic_trigger"] == nil then
    ateam["enemy_count_panic_trigger"] = tempTrigger("w panice wybiega na", [[ enemy_count_reset_current_enemies_when_necessary() ]])
end

function enemy_count_gmcp_parsing_finished()
    current_enemies = enemy_count_collect_enemies()

    if table.size(ateam.current_enemies) == 0 then
        -- empty the array
        ateam.current_enemies = current_enemies
        return
    end

    if table.size(current_enemies) > table.size(ateam.current_enemies) then
        -- there are new enemies on the location, set.
        ateam.current_enemies = current_enemies
        return
    end

    if table.size(current_enemies) ~= table.size(ateam.current_enemies) - 1 then
        return
    end

    for id_current_enemy, _ in pairs(current_enemies) do
        if ateam.current_enemies[id_current_enemy] == nil then
            ateam.current_enemies = current_enemies
            return
        end
    end

    ateam.current_enemies = current_enemies
    raiseEvent("ateamEnemyKilled", table.size(ateam.current_enemies))
end

function enemy_count_collect_enemies()
    local current_enemies = {}
    for i, obj in pairs(gmcp.objects.nums) do
        if ateam.objs[obj]["enemy"] == true then
            current_enemies[obj] = true
        end
    end
    return current_enemies
end

function enemy_count_reset_current_enemies_when_necessary()
    ateam.current_enemies = {}
end
