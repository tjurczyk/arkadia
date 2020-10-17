scripts.installer = scripts.installer or {}
scripts.installer.main_repo = "tjurczyk/arkadia"

function scripts.installer:update_scripts_to_latest_release()
    scripts.latest:get_latest_version(function(release_info) scripts.installer:on_scripts_version(release_info.tag_name) end)
end

function scripts.installer:on_scripts_version(version)
    scripts.installer:update_scripts(version)
end

function scripts.installer:update_scripts(branch, repo)

    local tag = branch ~= "" and branch and branch or "master"
    local repo = repo ~= "" and repo and repo or scripts.installer.main_repo
    local short_repo_name = repo:gsub("(.*)/", "")
    local url = "https://codeload.github.com/" .. repo .. "/zip/" .. tag

    if (mudletOlderThan(4, 6)) then
        scripts:print_log("Zaktualizuj mudlet do wersji 4.6+ lub pobierz paczke recznie z adresu: " .. url)
        return
    end

    scripts.installer.scripts_zip = getMudletHomeDir() .. "/scripts.zip"
    scripts.installer.unzip_directory = getMudletHomeDir() .. "/".. short_repo_name .."-" .. tag .. "/"
    scripts.installer.scripts_directory = getMudletHomeDir() .. "/arkadia/"

    if lfs.isdir(scripts.installer.scripts_directory .. "/.git/") then
        scripts:print_log("Chyba nie chcesz aktualizowac repozytorium w ten sposob? :)")
        return
    end

    scripts.installer.version_tag = nil
    if repo == scripts.installer.main_repo and (tag:match("%d+%.%d+%.%d+") or tag:match("%d+%.%d+")) then
        scripts.installer.version_tag = tag
    end

    scripts.installer.scripts_download_handler = scripts.event_register:force_register_event_handler(scripts.installer.scripts_download_handler, "sysDownloadDone", function(_, filename) scripts.installer:handle_scripts_download(_, filename) end)
    downloadFile(scripts.installer.scripts_zip, url)
    scripts:print_log("Pobieram paczke skryptow " .. branch .. " z repozytorium " .. repo)
end

function scripts.installer:handle_scripts_download(_, filename)
    if filename ~= scripts.installer.scripts_zip then
        return true
    end
    scripts.event_register:kill_event_handler(scripts.installer.scripts_download_handler)
    scripts:print_log("Paczka pobrana. Rozpakowuje")
    scripts.event_register:register_event_handler("sysUnzipDone", function(event, ...) scripts.installer:handle_unzip_scripts(event, ...) end, true)
    scripts.event_register:register_event_handler("sysUnzipError", function(event, ...) scripts.installer:handle_unzip_scripts(event, ...) end, true)
    unzipAsync(scripts.installer.scripts_zip, getMudletHomeDir())
end

function scripts.installer:handle_unzip_scripts(event, ...)
    if event == "sysUnzipDone" then
        os.remove(scripts.installer.scripts_zip)
        pcall(scripts.installer.delete_dir, scripts.installer.scripts_directory)
        uninstallPackage("Arkadia")
        tempTimer(1, function()
            scripts.installer:put_version_to_file()
            os.rename(scripts.installer.unzip_directory, scripts.installer.scripts_directory)
            installPackage(scripts.installer.scripts_directory .. "Arkadia.xml")
            scripts:print_log("Ok, zrestartuj Mudleta")
        end)
    elseif event == "sysUnzipError" then
        scripts:print_log("Blad podczas rozpakowywania skryptow")
    end
end

function scripts.installer:put_version_to_file()
    if scripts.installer.version_tag then
        local file = io.open(getMudletHomeDir() .. "/version_tag", 'w')
        file:write(scripts.installer.version_tag)
        file:close()
        scripts.installer.version_tag = nil
    end
end

function scripts.installer:get_version_from_file()
    local file = io.open(getMudletHomeDir() .. "/version_tag", 'r')
    if file then
        local version = file:read("*a")
        file:close()
        return version
    end
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

function scripts.installer.delete_dir(dir)
    for file in lfs.dir(dir) do
        local file_path = dir .. '/' .. file
        if file ~= "." and file ~= ".." then
            if lfs.attributes(file_path, 'mode') == 'file' then
                os.remove(file_path)
            elseif lfs.attributes(file_path, 'mode') == 'directory' then
                scripts.installer.delete_dir(file_path)
            end
        end
    end
    lfs.rmdir(dir)
end
