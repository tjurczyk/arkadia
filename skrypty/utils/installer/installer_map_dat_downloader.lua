function installer_map_dat_downloader()
    if scripts.installer.mode ~= "map" then
        return
    end

    local full_name = "map_master3.dat"

    if loadMap(getMudletHomeDir() .. "/" .. full_name) then
        scripts:print_log("Mapa zaladowana")
    else
        scripts:print_log("Problem z zaladowaniem mapy")
    end
    scripts.installer.mode = nil
end

if scripts.event_handlers["skrypty/utils/installer/installer_map_dat_downloader.sysDownloadDone.installer_map_dat_downloader"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/utils/installer/installer_map_dat_downloader.sysDownloadDone.installer_map_dat_downloader"])
end

scripts.event_handlers["skrypty/utils/installer/installer_map_dat_downloader.sysDownloadDone.installer_map_dat_downloader"] = registerAnonymousEventHandler("sysDownloadDone", installer_map_dat_downloader)

