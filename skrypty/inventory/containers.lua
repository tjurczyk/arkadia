scripts.inv.containers = scripts.inv.containers or {
    filter = false
}

function scripts.inv.containers:display_contents(content)
    local container_elements = scripts.utils:extract_string_list(content)
    if self.filter then
        container_elements = self.filter(container_elements)
        self.filter = false
    end
    scripts.utils:print_string_list(container_elements)
end

function scripts.inv.containers:set_magics_and_keys_filter()
    self.filter = self.magics_and_keys_filter
end

scripts.inv.containers.magics_and_keys_filter = function(contents)
    local magics = {}
    local keys = {}
    for k,v in pairs(contents) do
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
    send("ob " ..container)
end