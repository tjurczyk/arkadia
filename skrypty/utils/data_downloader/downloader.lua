function scripts.utils.data_downloader:start_file_downloader(url, file_path, downloaded_handler, decoder)
    if not mudlet.supports.coroutines then
        return
    end

    scripts.utils.data_downloader["downloader_working"] = true
    scripts.utils.data_downloader["current_download_details"]["url"] = url
    scripts.utils.data_downloader["current_download_details"]["file_path"] = file_path
    scripts.utils.data_downloader["current_download_details"]["downloaded_handler"] = downloaded_handler
    if not scripts.utils.data_downloader["supported_decoders"] then
        error("unknown decoder")
    end

    scripts.utils.data_downloader["current_download_details"]["decoder"] = decoder
    downloadFile(scripts.utils.data_downloader["current_download_details"]["file_path"], url)
end



