scripts.config_loader = {}

function scripts.config_loader:init_name_file(name, wolacz)
    if self:has_config_file(name) then
        scripts:print_log("Konfiguracja dla " .. name .. " juz istnieje")
    else
        self:copy_initial_config(name, wolacz)
        self:add_trigger(name, wolacz)
        scripts:print_log("Utworzona konfiguracja dla " .. name .. " w pliku " .. self:get_config_path(name))
    end
end

function scripts.config_loader:copy_initial_config(name, wolacz)
    local config_path = self:get_config_path(name)
    pcall(os.remove, config_path)
    local source = io.open(getMudletHomeDir() .. "/arkadia/imie.txt", "r")
    local content = source:read("*a")
    content = content:gsub("scripts\.character_name = nil", "scripts.character_name = \"" .. name .. "\"")
    content = content:gsub("amap\.locating\.name = \"Adremenie\"", "amap.locating.name = \"" .. wolacz .. "\"")
    local destination = io.open(self:get_config_path(name), "w")
    destination:write(content)
    destination:close()
end

function scripts.config_loader:add_trigger(name, wolacz)
    local trigger_name = name .. "-login"
    if exists(trigger_name, "trigger") == 0 then
        local code = "scripts_load_config(\"" .. wolacz .. "\")"
        permRegexTrigger(trigger_name, "", { "Witaj, " .. wolacz .. ". Podaj swe haslo" }, code)
    end
end

function scripts.config_loader:has_config_file(name)
    return io.exists(self:get_config_path(name))
end

function scripts.config_loader:get_config_path(name)
    return getMudletHomeDir() .. "/" .. name .. ".txt"
end

function scripts.config_loader:reload_last_config()
    if self.last_config then
        scripts_load_config(self.last_config)
    end
end

function scripts_load_config(name)
    scripts.config_loader.last_config = name
    dofile(scripts.config_loader:get_config_path(name))
end

function alias_func_init_config(name, wolacz)
    scripts.config_loader:init_name_file(name, wolacz)
end
