scripts.inv.containers = scripts.inv.containers or {
    filter = false,
    disable_grouped_containers = false,
    column_count = 1
}

function scripts.inv.containers:display_contents(content, container)
    if container == "depozyt" and scripts.boxes.valid_banks[amap.curr.id] then
	scripts.boxes.update_box = scripts.boxes.valid_banks[amap.curr.id]
        scripts.boxes:update_box(content)
    end
    if not scripts.inv.containers.disable_grouped_containers then
        scripts.inv.pretty_containers:print(content, scripts.inv.containers.column_count, self.filter, container)
    else
        local container_elements = scripts.utils:extract_string_list(content)
        if self.filter then
            container_elements = self.filter(container_elements)
        end
        scripts.utils:print_string_list(container_elements)
    end
    self.filter = false
end

function scripts.inv.containers:set_magics_and_keys_filter()
    self.filter = self.magics_and_keys_filter
end

scripts.inv.containers.magics_and_keys_filter = function(contents)
    local magics = {}
    local keys = {}
    for k, v in pairs(contents) do
        if table.contains(scripts.inv.magic_keys_data.magic_keys, string.lower(v["name"])) then
            table.insert(magics, v)
        end
        if table.contains(scripts.inv.magics_data.magics, string.lower(v["name"])) then
            table.insert(keys, v)
        end
    end

    return table_concat(keys, magics)
end

function alias_func_przejrzyj_magie()
    scripts.inv.containers:set_magics_and_keys_filter()
    local container = matches[3] or "skrzynie"
    send("ob " .. container)
end