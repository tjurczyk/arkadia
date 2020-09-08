ScriptsConfig = {}

function ScriptsConfig:init(file_name, create_config_file)
    if scripts.config_schema == nil then
        error("config schema isn't loaded in ScriptsConfig:init")
        scripts:print_log("config nie zostal zainicjowany prawidlowo, to nie powinno sie zdarzyc, zglos na discordzie")
        return nil
    end

    local o = {}
    setmetatable(o, self)
    self.__index = self

    self._lua_type_to_type_match = {"string", "boolean", "number"}
    self._config_name = file_name
    self._config_file_path = getMudletHomeDir() .. "/" .. file_name .. ".json"
    if not create_config_file and not io.exists(self._config_file_path) then
        scripts:print_log("plik konfiguracyjny ('" .. self._config_file_path .. "') nie istnieje")
        return nil
    elseif create_config_file and not io.exists(self._config_file_path) then
        scripts:print_log("tworze plik konfiguracyjny: '" .. self._config_file_path .. "'")
        local f = io.open(self._config_file_path, "w")
        f:close()
    end

    self._var_to_config = {}
    for k, field in pairs(scripts.config_schema.fields) do
        self._var_to_config[field.name] = field
    end
    self._sorted_var_keys = table.keys(self._var_to_config)
    table.sort(self._sorted_var_keys)
    self._macro_to_reload_elements = scripts.config_schema.macro_to_reload_elements
    self._config = {}
    if create_config_file then
        self:save_config(true)
    end
    return self
end

function ScriptsConfig:load_config(silent)
    file = io.open(self._config_file_path)
    local config = yajl.to_value(file:read("*a"))
    for var, value in pairs(config) do
        self:set_var(var, value, false, true, true)
    end
    if not silent then
        scripts:print_log("zaladowalem config dla profilu '" .. self._config_name .. "'")
    end
end

function ScriptsConfig:save_config(silent)
    file = io.open(self._config_file_path, "w")
    io.output(file)
    io.write("{\n")
    local user_var_names = {}
    for var, value in pairs(self._config) do
        if not table.contains(self._sorted_var_keys, var) then
            user_var_names[var] = value
        end
    end
    -- copy var keys from the config
    for _, var in pairs(self._sorted_var_keys) do
        local str_to_write = nil
        if self._config[var] ~= nil then
            str_to_write = yajl.to_string(self._config[var])
        else
            if self._var_to_config[var].field_type == "string" then
                str_to_write = "\"" .. self._var_to_config[var].default_value .. "\""
            elseif self._var_to_config[var].field_type == "list" or self._var_to_config[var].field_type == "map" then
                str_to_write = yajl.to_string(self._var_to_config[var].default_value)
            else
                str_to_write = tostring(self._var_to_config[var].default_value)
            end
        end
        io.write("    \"", tostring(var), "\": ", str_to_write)
        if _ < table.size(self._sorted_var_keys) or table.size(user_var_names) > 0 then
            io.write(",")
        end
        io.write("\n")
    end
    -- copy any extras that user can have
    local idx = 1
    for var, value in pairs(user_var_names) do
        local str_to_write = nil
        if type(value) == "string" then
            str_to_write = "\"" .. value .. "\""
        elseif type(value) == "table" then
            str_to_write = yajl.to_string(value)
        else
            str_to_write = tostring(value)
        end
        io.write("    \"", tostring(var), "\": ", str_to_write)
        if idx < table.size(user_var_names) then
            io.write(",")
        end
        io.write("\n")
        idx = idx + 1
    end
    io.write("}")
    io.close(file)
    if not silent then
        scripts:print_log("zapisalem config dla profilu '" .. self._config_name .. "'")
    end
end

function ScriptsConfig:print_var(var_pattern)
    local var_matching_pattern = {}
    for _, var in pairs(self._sorted_var_keys) do
        if string.find(var, var_pattern) then
            table.insert(var_matching_pattern, var)
        end
    end
    if table.size(var_matching_pattern) == 0 then
        scripts:print_log("brak jakiejkolwiek zmiennej")
    else
        scripts:print_log("konfiguracja: \n")
        for _, var in pairs(var_matching_pattern) do
            cecho("  <CornflowerBlue>" .. var .. "<grey>: <gold>" .. yajl.to_string(self._config[var]) .. "<grey>\n")
        end
    end
    cecho("\n")
end

function ScriptsConfig:remove_indexed_var(var, value_key, value_value, skip_var_existence_check, silent)
    if not skip_var_existence_check and self._config[var] == nil then
        scripts:print_log("zmienna '" .. var .. "' nie istnieje")
        return false
    end

    local var_config = self._var_to_config[var]
    if var_config.field_type ~= "list" and var_config.field_type ~= "map" then
        scripts:print_log("usuwac mozna tylko z listy lub z mapy, nie z '" .. tostring(var_config.field_type))
        return
    end

    local removed = false
    local success = true
    local message = ""
    if var_config.field_type == "list" then
        if value_key ~= nil and type(value_key) == 'number' then
            -- removing by key
            if not (value_key > 0 and value_key <= table.size(self._config[var])) then
                message = "lista nie ma indeksu " .. tostring(value_key)
                success = false
            else
                local removed_value = table.remove(self._config[var], value_key)
                message = "ok, usunalem '" .. removed_value .. "' (" .. type(removed_value) .. ") z listy"
            end
        elseif value_value ~= nil then
            -- removing by value
            local removed_value = nil
            for k, v in pairs(self._config[var]) do
                if tostring(v) == tostring(value_value) then
                    removed_value = table.remove(self._config[var], k)
                    break
                end
            end
            if removed_value then
                message = "ok, usunalem '" .. removed_value .. "' (" .. type(removed_value) .. ") z listy"
            else
                message = "nie usunalem '" .. value_value .. "' (" .. type(value_value) .. ") z listy, bo tego tam nie znalazlem"
                success = false
            end
        else
            message = "nieprawidlowy klucz/wartosc w usuwaniu z listy"
            success = false
        end
    else
        if value_key ~= nil then
            -- removing by key
            local old_value = self._config[var][value_key]
            self._config[var][value_key] = nil

            if old_value ~= nil then
                message = "ok, usunalem klucz '" .. value_key .. "' (" .. type(value_key) .. ") z mapy (mial wartosc '" .. tostring(old_value) .. "' (" .. type(old_value) .. "))"
            else
                message = "nie usunalem nic, bo mapa nie ma klucza '" .. tostring(value_key) .. "' (" .. type(value_key) .. ")"
                success = false
            end
        else
            message = "usuwanie z mapy po wartosci nie jest wspierane"
        end
    end

    if success then
        self:_set_mudlet_var(var, self._config[var], run_macros)
    end
    if not silent then
        scripts:print_log(message)
    end
    return success
end

function ScriptsConfig:set_indexed_var(var, value_key, value_value, run_macros, skip_var_existence_check, silent)
    if not skip_var_existence_check and self._config[var] == nil then
        scripts:print_log("zmienna '" .. var .. "' nie istnieje")
        return false
    end

    local var_config = self._var_to_config[var]
    if var_config.field_type ~= "list" and var_config.field_type ~= "map" then
        scripts:print_log("indeksowane dodanie dziala tylko dla typow 'list' i 'map', nie do '" .. tostring(var_config.field_type) .. "'")
        return
    end

    local message = ""
    local success = true
    if var_config.field_type == "list" then
        if value_key == nil then
            table.insert(self._config[var], value_value)
            message = "ok, dodalem '" .. value_value .. "' (" .. type(value_value) .. ") do listy"
        elseif value_key > table.size(self._config[var]) + 1 then
            message = "probujesz ustawic " .. value_key ..  " element listy, kiedy lista ma ich tylko " .. tostring(table.size(self._config[var]))
            success = false
        elseif value_key <= 0 then
            message = "probujesz negatywny badz zerowy element listy, taki nie istnieje, lista indeksowana od 1"
            success = false
        else
            self._config[var][value_key] = value_value
            message = "ok, ustawilem '" .. tostring(value_value) .. "' ("  .. type(value_value) .. ") jako " .. tostring(value_key) .. " element listy"
        end

    else
        if value_key == nil then
            message = "brak indeksu dla mapy"
            success = false
        else
            old_value = self._config[var][value_key]
            self._config[var][value_key] = value_value
            message = "ok, ustawilem '" .. tostring(value_value) .. "' ("  .. type(value_value) .. ") jako klucz '" .. tostring(value_key) .. "' ("  .. type(value_key) .. ")"
            if old_value then
                message = message .. ", poprzednio bylo '" .. old_value .. "' (" .. type(old_value) .. ")"
            else
                message = message .. ", poprzednio pusty indeks"
            end
        end
    end
    if success then
        self:_set_mudlet_var(var, self._config[var], run_macros)
    end
    if not silent then
        scripts:print_log(message)
    end
    return success
end

function ScriptsConfig:set_var(var, value, run_macros, skip_var_existence_check, silent)
    if not skip_var_existence_check and self._config[var] == nil then
        scripts:print_log("zmienna '" .. var .. "' nie istnieje")
        return false
    end
    local validation_test = self:_validate_var(var, value)
    if not validation_test[1] then
        scripts:print_log("ustawienie dla '" .. var .. "' ma niepoprawna wartosc. Oczekiwany typ: '" .. validation_test[2] .. "', otrzymany: '" .. validation_test[3] .. "'")
        return false
    else
        self._config[var] = value
        self:_set_mudlet_var(var, value, run_macros)
    end
    if not silent then
        scripts:print_log("ustawilem " .. var .. "=" .. yajl.to_string(value))
    end
    return true
end

function ScriptsConfig:run_macro(macro_name)
    self:_execute_macro(macro_name)
end

function ScriptsConfig:_set_mudlet_var(var, value, run_macros)
    local var_partials = string.split(var, "%.")
    local parent = _G[var_partials[1]]
    table.remove(var_partials, 1)
    for k, v in ipairs(var_partials) do
        if k == #var_partials then
            break
        end
        parent = parent[v]
    end
    parent[var_partials[#var_partials]] = value

    if not run_macros then
        return
    end

    -- execute macros
    local var_config = self._var_to_config[var]
    for k, macro_name in pairs(var_config.macros_on_modify) do
        self:_execute_macro(macro_name)
    end
end

function ScriptsConfig:_get_mudlet_var(var)
    local var_partials = string.split(var, "%.")
    local parent = _G[var_partials[1]]
    table.remove(var_partials, 1)
    for k, v in ipairs(var_partials) do
        if k == #var_partials then
            break
        end
        parent = parent[v]
    end
    return parent[var_partials[#var_partials]]
end

function ScriptsConfig:_execute_macro(macro_name)
    local macro_config = self._macro_to_reload_elements[macro_name]
    if not macro_config then
        error("unknown macro name in _execute_macro: " .. tostring(macro_name))
    end

    for k, item in pairs(macro_config) do
        if item.macro_type == "macro" then
            self:_execute_macro(item.macro_name)
        elseif item.macro_type == "func_call" then
            local func_name = item.func_name
            local func_args = item.func_args
            local func_partials = string.split(func_name, "%.")
            local parent = _G[func_partials[1]]
            if item.func_module_call then
                table.insert(func_args, 1, parent)
            end
            table.remove(func_partials, 1)
            for k, v in ipairs(func_partials) do
                parent = parent[v]
            end
            parent(unpack(func_args))
        end
    end
end

function ScriptsConfig:_validate_var(var, value)
    local var_config = self._var_to_config[var]
    if not var_config then
        return {true, nil, nil}
    end
    value_type = self:_get_value_type(value)
    local test_result = false
    -- special case when 'empty_table', it can be either a map or a list, so validate it
    if value_type == 'empty_table' and (var_config.field_type == "list" or var_config.field_type == "map") then
        return {true, var_config.field_type, var_config.field_type}
    end
    if var_config.field_type == value_type then
        test_result = true
    end
    return {test_result, var_config.field_type, value_type}
end

function ScriptsConfig:_get_value_type(value)
    if table.contains(self._lua_type_to_type_match, type(value)) then
        return type(value)
    end
    if type(value) ~= "table" then
        error("wrong value type in ScriptsConfig:_get_value_type")
    end
    if table.size(value) == 0 then
        return "empty_table"
    end
    local i = 0
    for _ in pairs(value) do
        i = i + 1
        if value[i] == nil then return "map" end
    end
    return "list"

end


