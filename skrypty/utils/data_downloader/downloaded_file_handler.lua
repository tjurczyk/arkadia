function scripts.utils.data_downloader:downloaded_file()
    if not scripts.utils.data_downloader["downloader_working"] then
        return
    end

    scripts.utils.data_downloader["downloader_working"] = false

    if not scripts.utils.data_downloader["current_download_details"] then
        scripts:print_log("Blad w trakcie pobierania pliku danych")
        error("unknown current download details")
    end

    if not scripts.utils.data_downloader["current_download_details"]["downloaded_handler"] then
        scripts:print_log("Blad w trakcie pobierania pliku danych")
        error("unknown current download downloaded handler")
    end

    scripts.utils.data_downloader["current_download_details"]["this_download_coroutine_id"] = coroutine.create(scripts.utils.data_downloader.process_downloaded_file)
    coroutine.resume(scripts.utils.data_downloader["current_download_details"]["this_download_coroutine_id"])
end

function scripts.utils.data_downloader:process_downloaded_file()
    local file_handle = assert(io.open(scripts.utils.data_downloader["current_download_details"]["file_path"], "r"))
    local file_content = file_handle:read("*all")
    local decoded_value = nil

    if scripts.utils.data_downloader["current_download_details"]["decoder"] == "json" then
        decoded_value = yajl.to_value(file_content)
    end

    scripts.utils.data_downloader["current_download_details"]["downloaded_handler"](scripts.utils.data_downloader["current_download_details"]["this_download_coroutine_id"], decoded_value)
    coroutine.yield()
    scripts.utils.data_downloader["current_download_details"] = {}
    scripts.utils.data_downloader.current_download_details["this_download_coroutine_id"] = nil
end

if not scripts.utils.data_downloader["downloaded_handler_id"] then
    scripts.utils.data_downloader["downloaded_handler_id"] = registerAnonymousEventHandler("sysDownloadDone", scripts.utils.data_downloader.downloaded_file)
else
    killAnonymousEventHandler(scripts.utils.data_downloader["downloaded_handler_id"])
    scripts.utils.data_downloader["downloaded_handler_id"] = registerAnonymousEventHandler("sysDownloadDone", scripts.utils.data_downloader.downloaded_file)
end

