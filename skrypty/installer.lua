function alias_func_skrypty_installer_aktualizuj_skrypty()
    scripts.installer:update_scripts_to_latest_release()
end

function alias_func_skrypty_installer_instaluj_skrypty()
    scripts.installer:update_scripts(matches[2], matches[3])
end

function alias_func_skrypty_installer_download_map()
    scripts.installer:download_mapper()
end

function alias_func_skrypty_installer_download_map_key()
    scripts.installer:download_mapper()
end

function alias_func_skrypty_installer_load_map()
    scripts.installer:load_map()
end

function alias_func_skrypty_installer_save_map()
    scripts.installer:save_map()
end

function alias_func_skrypty_installer_download_people_db()
    scripts.installer:download_people_db()
end

