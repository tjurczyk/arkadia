function scripts.people:build_bind_table()
    scripts.people.bind_attack_objs = {}
    for idx, key in pairs(scripts.keybind.configuration.attack_bind_objs.keys) do
        table.insert(scripts.people.bind_attack_objs, -1)
    end
end

tempTimer(5.351, function() scripts.people:build_bind_table() end)

