scripts.inv.containers = scripts.inv.containers or {
    filter = false
}

function scripts.inv.containers:display_contents(content)
    local str = scripts.utils:extract_string_list(content)
    if self.filter then
        str = self.filter(str)
        self.filter = false
    end
    scripts.utils:print_string_list(str)
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