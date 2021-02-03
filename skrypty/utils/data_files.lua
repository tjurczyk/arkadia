function scripts.utils:load_data_from_files()
    herbs["data"] = self:read_json(herbs.data_file_path)

    scripts.inv.magics_data = self:read_json(scripts.inv.magics_file_path)
    if scripts.inv.magics_data then
        scripts.inv:setup_magics_triggers()
    end
    scripts.inv["magic_keys_data"] = self:read_json(scripts.inv.magic_keys_file_path)
    if scripts.inv["magic_keys_data"] then
        scripts.inv:setup_magic_keys_triggers()
    end
end

function scripts.utils:read_json(file_path)
    local file_handle = io.open(file_path, "r")
    if file_handle then
        local file_content = file_handle:read("*all")
        local decoded_value = yajl.to_value(file_content)
        file_handle:close()
        return decoded_value
    end
end

scripts.utils:load_data_from_files()
