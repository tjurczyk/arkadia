local latest_release = "https://api.github.com/repos/tjurczyk/arkadia/releases/latest"
local latest_file = getMudletHomeDir() .. "/latest.json"
local url = "https://codeload.github.com/tjurczyk/arkadia-skrypty/zip/"
local scriptsZip = getMudletHomeDir() .. "/scripts.zip"
local unzipDirectory = ""
local scriptsDirectory = getMudletHomeDir() .. "/arkadia/"

function installScripts()
    downloadFile(latest_file, latest_release)
    registerAnonymousEventHandler("sysDownloadDone", "handleVersionDownload", true)
end

function handleVersionDownload(_, filename, callback)
    if filename ~= latest_file then
        return true
    end

    local file = io.open(latest_file, "rb")
    if file then
        local response = yajl.to_value(file:read("*a"))
        file:close()
        os.remove(latest_file)
        unzipDirectory = getMudletHomeDir() .. "/arkadia-".. response.name .."/"
        tempTimer(0.1, function() downloadScripts(response.name) end)
    end
end

function downloadScripts(version)
    pcall(deleteDir, scriptsDirectory)
    registerAnonymousEventHandler("sysDownloadDone", "handleDownload", true)
    downloadFile(scriptsZip, url .. version)
    cecho("\n<CadetBlue>(skrypty)<tomato>: Pobieram aktualna paczke skryptow (".. version ..")\n")
end

function handleDownload(_, filename)
    if filename ~= scriptsZip then
        return true
    end
    registerAnonymousEventHandler("sysUnzipDone", "handleUnzipEvents", true)
    registerAnonymousEventHandler("sysUnzipError", "handleUnzipEvents", true)
    unzipAsync(scriptsZip, getMudletHomeDir())
end

function handleUnzipEvents(event, ...)
    if event == "sysUnzipDone" then
        cecho("\n<CadetBlue>(skrypty)<tomato>: Skrypty rozpakowane\n")
        os.remove(scriptsZip)
        os.rename(unzipDirectory, scriptsDirectory)
        installPackage(scriptsDirectory .. "Arkadia.xml")
        uninstallPackage("generic_mapper")
        uninstallPackage("skrypty_master3")
    elseif event == "sysUnzipError" then
        cecho("\n<CadetBlue>(skrypty)<tomato>: Blad podczas rozpakowywania skryptow\n")
    end
end

function deleteDir(dir)
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

installScripts()
clearCmdLine()
