function scripts.utils:download_all_data()
    scripts.utils.download_all_data_coroutine_id = nil

    if not mudlet.supports.coroutines then
        return
    end

    scripts.utils.download_all_data_coroutine_id = coroutine.create(scripts.utils.process_download_all_data)
    coroutine.resume(scripts.utils.download_all_data_coroutine_id)
end

function scripts.utils:process_download_all_data()
    scripts.utils.data_downloader:start_file_downloader(herbs.data_url, herbs.data_file_path, herbs_data_downloaded, "json")
    coroutine.yield()
    scripts.utils.data_downloader:start_file_downloader(scripts.inv.magics_url, scripts.inv.magics_file_path, magics_data_downloaded, "json")
    coroutine.yield()
    scripts.utils.data_downloader:start_file_downloader(scripts.inv.magic_keys_url, scripts.inv.magic_keys_file_path, magic_keys_data_downloaded, "json")
    coroutine.yield()
    scripts.utils.download_all_data_coroutine_id = nil
end

function herbs_data_downloaded(resume_coroutine_id, decoded_data)
    herbs["data"] = decoded_data
    herbs:v2_init_herbs()
    coroutine.resume(resume_coroutine_id)
    coroutine.resume(scripts.utils.download_all_data_coroutine_id)
end

function magics_data_downloaded(resume_coroutine_id, decoded_data)
    scripts.inv.magics_data = decoded_data
    scripts.inv:setup_magics_triggers()
    coroutine.resume(resume_coroutine_id)
    coroutine.resume(scripts.utils.download_all_data_coroutine_id)
end

function magic_keys_data_downloaded(resume_coroutine_id, decoded_data)
    scripts.inv["magic_keys_data"] = decoded_data
    scripts.inv:setup_magic_keys_triggers()
    coroutine.resume(resume_coroutine_id)
    coroutine.resume(scripts.utils.download_all_data_coroutine_id)
end

tempTimer(0.7, function() scripts.utils:download_all_data() end)

