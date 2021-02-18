function installer_people_db_downloader()
    if scripts.installer.mode ~= "people" then
        return
    end

    scripts:print_log("Baza pobrana. Triggery zostana przeladowane.")
    scripts.people:load_db()
    scripts.people:starter()
    scripts.installer.mode = nil
end

if scripts.event_handlers["skrypty/utils/installer/installer_people_db_downloader.sysDownloadDone.installer_people_db_downloader"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/utils/installer/installer_people_db_downloader.sysDownloadDone.installer_people_db_downloader"])
end

scripts.event_handlers["skrypty/utils/installer/installer_people_db_downloader.sysDownloadDone.installer_people_db_downloader"] = registerAnonymousEventHandler("sysDownloadDone", installer_people_db_downloader)

