ateam.next_attack_objs = ateam.next_attack_objs or {queue = {}, next_attak_obj = nil}

if ateam["ateam_next_attack_objs_on_amap_new_location_handler"] == nil then
    ateam.ateam_next_attack_objs_on_amap_new_location_handler = scripts.event_register:register_singleton_event_handler(nil, "amapNewLocation", "ateam_reset_next_attack_obj", false)
end

if ateam["ateam_next_attack_objs_on_ateam_enemy_killed_handler"] == nil then
  ateam.ateam_next_attack_objs_on_ateam_enemy_killed_handler = scripts.event_register:register_singleton_event_handler(nil, "ateamEnemyKilled", "ateam_may_execute_next_attack_obj", false)
end

function ateam:add_next_attack_obj(id)
  local next_obj_arkadia_id = ateam.enemy_op_ids[id]
  if not next_obj_arkadia_id then
    scripts:print_log("Brak tego id")
    return
  end

  local next_obj = ateam.objs[next_obj_arkadia_id]
  local next_obj_id = next_obj_arkadia_id
  table.insert(ateam.next_attack_objs.queue, next_obj_id)
  scripts:print_log("Ok, dodalem '" .. next_obj["desc"] .. "' do kolejki")
end

function ateam_may_execute_next_attack_obj(...)
  local remaining_enemies = arg[2]
  if remaining_enemies == 0 or table.size(ateam.next_attack_objs.queue) == 0 then
    return
  end

  ateam.next_attack_objs.next_attak_obj = ateam.next_attack_objs.queue[1]
  table.remove(ateam.next_attack_objs.queue, 1)
  raiseEvent("ateam_next_attack_obj_bind", ateam.next_attack_objs.next_attak_obj, id, ateam.objs[ateam.next_attack_objs.next_attak_obj])
  cecho(" <orange>/nn zeby zaatakowac nastepny cel: " .. ateam.objs[ateam.next_attack_objs.next_attak_obj]["desc"])
end

function ateam_execute_next_attack_obj()
  -- attack only if attacking not this one
  if ateam.next_attack_objs.next_attak_obj and ateam.objs[ateam.my_id]["attack_num"] ~= ateam.next_attack_objs.next_attak_obj then
    ateam:zab_func(ateam.next_attack_objs.next_attak_obj)
  end
  ateam.next_attack_objs.next_attak_obj = nil
end

function ateam_reset_next_attack_obj()
  ateam.next_attack_objs.queue = {}
  ateam.next_attack_objs.next_attak_obj = nil
end
