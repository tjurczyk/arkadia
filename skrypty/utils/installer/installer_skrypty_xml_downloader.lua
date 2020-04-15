function installer_skrypty_xml_downloader()
    if scripts.installer.mode ~= "scripts" then
        return
    end

    uninstallPackage("skrypty_master3")
    installPackage(getMudletHomeDir() .. "/skrypty_master3.xml")
    scripts:print_log("Ok, zrestartuj Mudleta")
    scripts.installer.mode = nil
end

if scripts.event_handlers["skrypty/utils/installer/installer_skrypty_xml_downloader.sysDownloadDone.installer_skrypty_xml_downloader"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/utils/installer/installer_skrypty_xml_downloader.sysDownloadDone.installer_skrypty_xml_downloader"])
end

scripts.event_handlers["skrypty/utils/installer/installer_skrypty_xml_downloader.sysDownloadDone.installer_skrypty_xml_downloader"] = registerAnonymousEventHandler("sysDownloadDone", installer_skrypty_xml_downloader)

