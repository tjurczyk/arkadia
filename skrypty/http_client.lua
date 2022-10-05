HttpClient = HttpClient or {
    handlers = {}
}

local successHandlerCallback = function(url, callback, handlers)
    return function(_, rurl, response)
        if rurl ~= url then
            return true
        end
        killAnonymousEventHandler(handlers.errorHandler)
        if callback then
            callback(yajl.to_value(response))
        end
    end
end

local errorHandlerCallback = function(url, errorCallback, handlers)
    return function(_, response, rurl)
        if rurl ~= url then
            return true
        end
        local msg = string.format("Error while calling %s - %s", url, response)
        killAnonymousEventHandler(handlers.successHandler)
        if errorCallback then
            errorCallback(response, msg)
        end
    end
end

function HttpClient:registerHandlers(method, url, callback, errorCallback)
    local handlers = {}
    handlers.successHandler = registerAnonymousEventHandler(string.format("sys%sHttpDone", method), successHandlerCallback(url, callback, handlers), true)
    handlers.errorHandler = registerAnonymousEventHandler(string.format("sys%sHttpError", method), errorHandlerCallback(url, errorCallback,  handlers), true)
end

function HttpClient:post(url, payload, headers, callback, errorCallback)
    self:registerHandlers("Post", url, callback, errorCallback)
    postHTTP(yajl.to_string(payload), url, headers)
end

function HttpClient:put(url, payload, headers, callback, errorCallback)
    self:registerHandlers("Put", url, callback, errorCallback)
    putHTTP(yajl.to_string(payload), url, headers)
end

function HttpClient:get(url, headers, callback, errorCallback)
    self:registerHandlers("Get", url, callback, errorCallback)
    getHTTP(url, headers)
end

function HttpClient:delete(url, headers, callback, errorCallback)
    self:registerHandlers("Delete", url, callback, errorCallback)
    deleteHTTP(url, headers)
end