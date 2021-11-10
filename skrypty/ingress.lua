scripts.ingress = scripts.ingress or {
    prompt = false,
    handler = function() end
}

local prompt_sequence = "> "

function scripts.ingress:init()
    self.options_handler = scripts.event_register:force_register_event_handler(self.options_handler, "gmcp.char.options", function() self:set_prompt() end)
    self.msg_handler = scripts.event_register:force_register_event_handler(self.msg_handler, "gmcp.gmcp_msgs", function()
        self:handle_message()
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
    local msg = dec(gmcp.gmcp_msgs.text)
    feedTriggers(msg)
    return msg
end

function scripts.ingress:prompt_handler()
    local msg = dec(gmcp.gmcp_msgs.text)
    local plain = ansi2string(msg)
    local feed_msg = msg
    while plain:sub(1,2) == prompt_sequence and plain:len() > 2 do
        local separator_point = msg:find(prompt_sequence)
        feed_msg = feed_msg:sub(separator_point + 2)
        plain = ansi2string(feed_msg)
    end
    feedTriggers(feed_msg)
    return msg
end


function scripts.ingress:handle_message()
    local msg = self:handler()
    self:post_process_message(msg)
end


function scripts.ingress:post_process_message(msg)
    if scripts.ui.separate_talk_window and scripts.ui.separate_talk_window_msg_types[gmcp.gmcp_msgs.type] then
        local timestamp = ""
        if scripts.ui.separate_talk_window_timestamp and string.trim(scripts.ui.separate_talk_window_timestamp) ~= "" then
            timestamp = string.format("[%s] ", os.date(scripts.ui.separate_talk_window_timestamp))
        end
        decho("talk_window", timestamp .. scripts.ui.separate_talk_window_prefix .. ansi2decho(dec(gmcp.gmcp_msgs.text)))
    end
    if gmcp.gmcp_msgs.type == "comm" then
        scripts.ui.talk_history:add(msg)
    end
    if gmcp.gmcp_msgs.type == "comm" then
        scripts.ui.talk_history:add(msg)
    end
    if gmcp.gmcp_msgs.type == "room.short" then
        amap.localization.current_short = ansi2string(msg):gsub("\n", "")
    end
    if gmcp.gmcp_msgs.type == "room.exits" then
        amap.localization.current_exit = ansi2string(msg):gsub("\n", "")
    end
end

scripts.ingress:init()