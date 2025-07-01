scripts.ingress = scripts.ingress or {
    prompt = false,
    handler = function() end,
    interceptors = {}
}

if not _originalDeleteLine then
    _originalDeleteLine = deleteLine
    function deleteLine(window)
        if window == "main" or window == nil then
            scripts.ingress.deleteLineCalled = true
        end
        _originalDeleteLine(window)
    end
end

local prompt_sequence = "> "

function scripts.ingress:init()
    self.options_handler = scripts.event_register:force_register_event_handler(self.options_handler, "gmcp.char.options", function() self:set_prompt() end)
    self.msg_handler = scripts.event_register:force_register_event_handler(self.msg_handler, "gmcp.gmcp_msgs", function()
        gmcp.gmcp_msgs.decoded = dec(gmcp.gmcp_msgs.text)
        local handled = false
        for _, callback in pairs(self.interceptors[gmcp.gmcp_msgs.type] or {}) do
            handled = handled or callback(gmcp.gmcp_msgs.decoded)
        end
        if not handled then
            self:handle_message()
        end
    end)
    self:set_handler()
end

function scripts.ingress:set_prompt()
    if gmcp.char.options and gmcp.char.options.no_prompt ~= nil then
        self.prompt = gmcp.char.options.no_prompt == 0
    end
    if gmcp.char.options.info and gmcp.char.options.info.no_prompt then
        -- wymagane, poniewaz arkadia nieprawidlowo wysyla no_prompt
        tempRegexTrigger("^ZNAK zachety:\\s+(Wlaczony|Wylaczony)", function()
            self.prompt = matches[2] == "Wlaczony"
            self:set_handler()
        end, 1)
    end
end

function scripts.ingress:set_handler()
    if not self.prompt then
        self.handler = self.no_prompt_handler
    else
        self.handler = self.prompt_handler
    end
end

function scripts.ingress:no_prompt_handler()
    feedTriggers(gmcp.gmcp_msgs.decoded)
    return gmcp.gmcp_msgs.decoded
end

function scripts.ingress:prompt_handler()
    local msg = gmcp.gmcp_msgs.decoded
    local plain = ansi2string(msg)
    local feed_msg = msg
    if plain == prompt_sequence then
        decho(ansi2decho(plain))
    else
        feedTriggers(feed_msg)
    end
    return msg
end


function scripts.ingress:handle_message()
    scripts.ingress.deleteLineCalled = false
    local msg = self:handler()
    self:post_process_message(msg)
end


function scripts.ingress:post_process_message(msg)
    if scripts.ui.separate_talk_window and scripts.ui.separate_talk_window_msg_types[gmcp.gmcp_msgs.type] then
        local timestamp = ""
        if scripts.ui.separate_talk_window_timestamp and string.trim(scripts.ui.separate_talk_window_timestamp) ~= "" then
            timestamp = string.format("[%s] ", os.date(scripts.ui.separate_talk_window_timestamp))
        end
        decho("talk_window", timestamp .. scripts.ui.separate_talk_window_prefix .. ansi2decho(gmcp.gmcp_msgs.decoded))
    end
    if scripts.ui.separate_team_talk_window and scripts.ui.separate_talk_window_msg_types[gmcp.gmcp_msgs.type] then
        local team = false
        local plain = ansi2string(gmcp.gmcp_msgs.decoded):lower()
        if plain:starts("mowisz") or plain:starts("krzyczysz") or plain:starts("szepczesz") then
            team = true
        end
        if not team and ateam and ateam.team_names then
            for name, _ in pairs(ateam.team_names) do
                if plain:starts(name:lower()) or plain:starts("[" .. name:lower()) then
                    team = true
                    break
                end
            end
        end
        if team then
            local timestamp = ""
            if scripts.ui.separate_talk_window_timestamp and string.trim(scripts.ui.separate_talk_window_timestamp) ~= "" then
                timestamp = string.format("[%s] ", os.date(scripts.ui.separate_talk_window_timestamp))
            end
            decho("team_talk_window", timestamp .. scripts.ui.separate_talk_window_prefix .. ansi2decho(gmcp.gmcp_msgs.decoded))
        end
    end
    if gmcp.gmcp_msgs.type == "comm" then
        scripts.ui.talk_history:add(msg)
    end
    if gmcp.gmcp_msgs.type == "room.short" then
        amap.localization.current_short = ansi2string(msg):gsub("\n", "")
        amap.localization.current_exit = ""
    end
    if gmcp.gmcp_msgs.type == "room.exits" then
        amap.localization.current_exit = ansi2string(msg):gsub("\n", "")
    end
    if scripts.ui.combat_window.enabled then
        if not self.deleteLineCalled then
            scripts.ui.combat_window:process(msg)
        end
    end
    raiseEvent("incomingMessage", gmcp.gmcp_msgs.type, msg)
end

function scripts.ingress:register_interceptor(type, callback)
    self.interceptors[type] = self.interceptors[type] or {}
    table.insert(self.interceptors[type], callback)
    return callback
end

function scripts.ingress:remove_interceptor(type, callback)
    table.remove(self.interceptors[type], table.index_of(self.interceptors[type], callback))
end

scripts.ingress:init()

function is_msg_type(...)
    return gmcp.gmcp_msgs and table.contains(arg, gmcp.gmcp_msgs.type)
end

function is_combat_msg()
    return is_msg_type("combat.avatar", "combat.team", "combat.others")
end
