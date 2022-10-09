scripts.utils.downloader = scripts.utils.downloader or {}

function scripts.utils.downloader:downloadFile(fileName, fileUrl, onDone, label)
    label = label or "Pobieram plik"
    local progressHandler = registerAnonymousEventHandler("sysDownloadFileProgress", function(_, url, bytes, total)
        if fileUrl ~= url then
            return
        end
        if total ~= 0 then
        self:report_progress(bytes, total, label)
        end
    end)
    registerAnonymousEventHandler("sysDownloadDone", function(_, file)
        if fileName ~= file then
            return
        end
        onDone()
        killAnonymousEventHandler(progressHandler)
    end, true)
    downloadFile(fileName, fileUrl)
end

function scripts.utils.downloader:report_progress(bytes, total, label)
    local lines = 0
    while selectString(label .. ":", 1) == -1 and lines < 10 do
        moveCursor(0, getLastLineNumber() - lines)
        lines = lines + 1
    end
    if selectString(label .. ":", 1) > -1 then
        deleteLine()
    end
    moveCursorEnd()
    local progress_bar = "["
    for i = 0, 10, 1 do
        local char = (bytes / total) * 10 >= i and "#" or " "
        progress_bar = progress_bar .. char
    end
    progress_bar = progress_bar .. "]"
    scripts:print_log(string.format(label ..": %sKB/%sKB %s", scripts.utils.str_pad(tostring(math.floor(bytes / 1024)), string.len(total), "right"), math.floor(total / 1024), progress_bar))
end


