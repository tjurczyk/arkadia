scripts.installer = scripts.installer or {}

function scripts.installer:update_scripts(branch)
    local tag = branch or "master"
    local url = "https://codeload.github.com/tjurczyk/arkadia-skrypty/zip/" .. tag

    scripts.installer.scripts_zip = getMudletHomeDir() .. "/scripts.zip"
    scripts.installer.unzip_directory = getMudletHomeDir() .. "/arkadia-".. tag .."/"
    scripts.installer.scripts_directory = getMudletHomeDir() .. "/arkadia/"

    pcall(scripts.installer.deleteDir, scripts_directory)
    registerAnonymousEventHandler("sysDownloadDone", function(_, filename) scripts.installer:handle_scripts_download(_, filename) end, true)
    downloadFile(scripts.installer.scripts_zip, url)
    cecho("\n<CadetBlue>(skrypty)<tomato>: Pobieram aktualna paczke skryptow\n")
end

function scripts.installer:handle_scripts_download(_, filename)
    if filename ~= scripts.installer.scripts_zip then
        return true
    end
    registerAnonymousEventHandler("sysUnzipDone", function(event, ...) scripts.installer:handle_unzip(event, ...) end, true)
    registerAnonymousEventHandler("sysUnzipError", function(event, ...) scripts.installer:handle_unzip(event, ...) end, true)
    unzipAsync(scripts.installer.scripts_zip, getMudletHomeDir())
end

function scripts.installer:handle_unzip(event, ...)
    if event == "sysUnzipDone" then
        cecho("\n<CadetBlue>(skrypty)<tomato>: Skrypty rozpakowane\n")
        os.remove(scripts.installer.scripts_zip)
        os.rename(scripts.installer.unzip_directory, scripts.installer.scripts_directory)
        installPackage(scripts.installer.scripts_directory .. "Arkadia.xml")
    elseif event == "sysUnzipError" then
        cecho("\n<CadetBlue>(skrypty)<tomato>: Blad podczas rozpakowywania skryptow\n")
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
                deleteDir(file_path)
            end
        end
    end
    lfs.rmdir(dir)
end

