ateam.next_attack_objs = ateam.next_attack_objs or {
    queue = {},
    next_attak_obj = nil,
    window = {
        enabled = false,
        shown = false,
        name = "next_attack_objs",
        font_size = getFontSize()
    },
    mark_in_state = false
}

function ateam.next_attack_objs:init()
    self.location_handler = scripts.event_register:register_singleton_event_handler(self.location_handler, "amapNewLocation", function()
        ateam_reset_next_attack_obj()
        self:show_window()
    end, false)
    self.enemy_killed_handler = scripts.event_register:register_singleton_event_handler(self.enemy_killed_handler, "ateamEnemyKilled", function()
        ateam_may_execute_next_attack_obj()
        ateam.next_attack_objs:show_window()
    end, false)
    self.bind_handler = scripts.event_register:register_singleton_event_handler(nil, "ateam_next_attack_obj_bind", function()
        cecho(" <orange>/nn zeby zaatakowac nastepny cel: " .. ateam.objs[ateam.next_attack_objs.next_attak_obj]["desc"] .. "\n")
    end, false)
end

function ateam.next_attack_objs:show_window()
    if not self.window.enabled then
        return
    end
    if not self.window.shown then
        openUserWindow(self.window.name)
        self.window.shown = true
        setUserWindowTitle(self.window.name, "Kolejka")
    end
    clearUserWindow(self.window.name)
    setFontSize(self.window.name, self.window.font_size)
    setFont(self.window.name, getFont())
    for k, v in pairs(ateam.next_attack_objs.queue) do
        echo(self.window.name, string.format(" %d. %s\n", k, ateam.objs[v].desc))
    end
end

function ateam:add_next_attack_obj(id, silent)
    local next_obj_arkadia_id = ateam.enemy_op_ids[id] or ateam.normal_ids[id]
    if not next_obj_arkadia_id then
        scripts:print_log("Brak tego id")
        return
    end

    local next_obj = ateam.objs[next_obj_arkadia_id]
    local next_obj_id = next_obj_arkadia_id
    if table.contains(ateam.next_attack_objs.queue, next_obj_id) then
        scripts:print_log("'" .. next_obj["desc"] .. "' jest juz w kolejce")
        return
    end
    table.insert(ateam.next_attack_objs.queue, next_obj_id)
    if not silent then
        scripts:print_log("Ok, dodalem '" .. next_obj["desc"] .. "' do kolejki")
    end
    ateam.next_attack_objs:show_window()
end

function ateam_may_execute_next_attack_obj(...)
    local remaining_enemies = arg[2]
    if remaining_enemies == 0 then
        return
    end

    ateam.next_attack_objs.next_attak_obj = nil
    for _, objs in ipairs(ateam.next_attack_objs.queue) do
        if table.contains(gmcp.objects.nums, objs) then
            ateam.next_attack_objs.next_attak_obj = objs
            break
        end
    end

    if ateam.next_attack_objs.next_attak_obj then
        raiseEvent("ateam_next_attack_obj_bind", ateam.next_attack_objs.next_attak_obj, ateam.next_attack_objs.next_attak_obj, ateam.objs[ateam.next_attack_objs.next_attak_obj])
    end
end

function ateam_execute_next_attack_obj(force)
    -- attack only if attacking not this one or if team leader to show target and order if applicable
    if force or ateam.objs[ateam.my_id]["team_leader"] or (ateam.next_attack_objs.next_attak_obj and ateam.objs[ateam.my_id]["attack_num"] ~= ateam.next_attack_objs.next_attak_obj) then
        ateam:zab_func(ateam.next_attack_objs.next_attak_obj)
    end
    ateam.next_attack_objs.next_attak_obj = nil
end

function ateam_reset_next_attack_obj()
    ateam.next_attack_objs.queue = {}
    ateam.next_attack_objs.next_attak_obj = nil
end

ateam.next_attack_objs:init()