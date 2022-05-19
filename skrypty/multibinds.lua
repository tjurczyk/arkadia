scripts.multibinds = scripts.multibinds or {
    max_binds = 4
}

scripts.multibinds.db = db:create("multibinds", {
    multibinds = {
        room_id = -1,
        index = -1,
        action = "",
        uniqness = "",
        _index = { "room_id" },
        _unique = { "uniqness" },
        _violations = "REPLACE"
    }
})

function scripts.multibinds:init()
    self.handler = scripts.event_register:force_register_event_handler(self.handler, "amapNewLocation", function (_, loc)
        self:update_ui(loc)
    end)
    self.handler2 = scripts.event_register:force_register_event_handler(self.handler2, "amapLocationSteppedBack", function (_, _, loc)
        self:update_ui(loc)
    end)
end

function scripts.multibinds:create(room_id, index, action)
    if index > self.max_binds then
        scripts:print_log(string.format("Numer binda musi byc pomiedzy 1, a %d", self.max_binds))
        return
    end
    db:add(self.db.multibinds, {
        room_id = room_id,
        index = index,
        action = action,
        uniqness = string.format("%s-%s", room_id, index)
    })
    scripts:print_log(string.format("Utworzono bind %s-%s: %s", room_id, index, action))
    self:update_ui(amap.curr.id)
end

function scripts.multibinds:create_current(index, action)
    self:create(amap.curr.id, index, action)
    self:update_ui(amap.curr.id)
end

function scripts.multibinds:create_next(action)
    local binds = self:get_for_location(amap.curr.id)
    local slots = {}
    for i = 1, self.max_binds, 1 do
        table.insert(slots, i)
    end
    for k,v in pairs(binds) do
        table.remove(slots, table.index_of(slots, v.index))
    end
    if slots[1] then
        self:create(amap.curr.id, slots[1], action)
    else
        scripts:print_log(string.format("Lokacja ma juz maksymalna (%d) liczbe bindow.", self.max_binds))
    end
end

function scripts.multibinds:clear_location(room_id)
    db:delete(self.db.multibinds, db:eq(self.db.multibinds.room_id, room_id))
    self:update_ui(amap.curr.id)
end

function scripts.multibinds:clear_location_index(room_id, index)
    db:delete(self.db.multibinds, db:AND(db:eq(self.db.multibinds.room_id, room_id), db:eq(self.db.multibinds.index, index)))
    self:update_ui(amap.curr.id)
end

function scripts.multibinds:get_for_location(room_id)
    local result = db:fetch(self.db.multibinds, db:eq(self.db.multibinds.room_id, room_id), {self.db.multibinds.index})
    return result
end

function scripts.multibinds:run(room_id, index)
    local result = db:fetch(self.db.multibinds, { db:eq(self.db.multibinds.room_id, room_id), db:eq(self.db.multibinds.index, index) })
    if not table.is_empty(result) then
        misc:run_separeted_command(result[1].action)
    end
end

function scripts.multibinds:run_current(index)
    self:run(amap.curr.id, index)
 end

 function scripts.multibinds:update_ui(loc)
     local actions = self:get_for_location(loc)
     if actions and not table.is_empty(actions) then
        local action_binds = {}
        for _, props in pairs(actions) do
            table.insert(action_binds, string.format("[%s] %s", scripts.keybind:keybind_tostring("multibind" .. props.index), props.action))
        end
        scripts.ui.multibinds_label:echo(table.concat(action_binds, "&nbsp;&nbsp;&nbsp;&nbsp;"))
    else
        scripts.ui.multibinds_label:echo("Brak akcji")
    end
 end

 function scripts.multibinds:display(room_id)
    scripts:print_log(string.format("Multbindy dla lokacji %s: \n", room_id), true)
    local result = scripts.multibinds:get_for_location(room_id)
    if table.is_empty(result) then
        cecho("<tomato>Brak.<reset>")
    else
        for _, value in pairs(result) do
            cecho(string.format("<gray>[%s] - %s<reset>\n", scripts.keybind:keybind_tostring("multibind" .. value.index), value.action))
        end
    end
    echo("\n\n")
 end

 function scripts.multibinds:get_command_key(index)
    return self.command_keys[index]
 end

 scripts.multibinds:init()

function alias_func_mbind_create_current(index, action)
    scripts.multibinds:create_current(index, action)
 end

 function alias_func_mbind_create_next(action)
    scripts.multibinds:create_next(action)
 end

function alias_func_mbind_display_current()
    scripts.multibinds:display(amap.curr.id)
 end

function alias_func_mbind_display(room_id)
    scripts.multibinds:display(room_id)
 end

function alias_func_mbind_clear_location()
     scripts.multibinds:clear_location(amap.curr.id)
 end

function alias_func_mbind_clear_location_index(index)
    scripts.multibinds:clear_location_index(amap.curr.id, index)
end