scripts.installer = scripts.installer or {}

function scripts.installer:update_scripts(branch)
    scripts.installer.tree = "master3"
    scripts.installer.mode = "scripts"
    if branch then
        scripts.installer.tree = branch
    end

    local full_name = "skrypty_master3.xml"

    downloadFile(getMudletHomeDir() .. "/" .. full_name, "http://arkadia.kamerdyner.net/" .. scripts.installer.tree .. "/" .. full_name)
end

function scripts.installer:download_mapper(branch, key)
    scripts.installer.tree = "master3"
    scripts.installer.mode = "map"
    if branch then
        scripts.installer.tree = branch
    end

    local full_name = "map_master3.dat"

    if key then
        downloadFile(getMudletHomeDir() .. "/" .. full_name, "http://arkadia.kamerdyner.net/" .. key .. "/" .. full_name)
    else
        downloadFile(getMudletHomeDir() .. "/" .. full_name, "http://arkadia.kamerdyner.net/" .. scripts.installer.tree .. "/" .. full_name)
    end
end

function scripts.installer:download_people_db()
    scripts.installer.mode = "people"

    downloadFile(getMudletHomeDir() .. "/Database_people.db", "http://arkadia.kamerdyner.net/master3/Database_people.db")
end

function scripts.installer:load_map(branch)
    local tree = "master3"
    if branch then
        tree = branch
    end

    local full_name = "/map_" .. tree .. ".dat"

    if loadMap(getMudletHomeDir() .. full_name) then
        scripts:print_log("Mapa zaladowana")
    else
        scripts:print_log("Problem z zaladowaniem mapy")
    end
end

function scripts.installer:save_map(branch)
    local tree = "master3"
    if branch then
        tree = branch
    end

    local full_name = "/map_master3.dat"

    if saveMap(getMudletHomeDir() .. full_name) then
        scripts:print_log("Mapa zapisana")
    else
        scripts:print_log("Problem z zapisaniem mapy")
    end
end

