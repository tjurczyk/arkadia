function gmcp_msgs()
    local msg = dec(gmcp.gmcp_msgs.text)
    feedTriggers(msg)
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
end

if scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"])
end

scripts.event_handlers["skrypty/ui/talk_window/gmcp_msgs.gmcp.gmcp_msgs.gmcp_msgs"] = registerAnonymousEventHandler("gmcp.gmcp_msgs", gmcp_msgs)


function check_msg(msg)
    local tokens = ansi2string(msg):gsub("%.", ""):gsub("[,!?-]", ""):gsub("\t", ""):gsub("\n", ""):split("[ /]")
    for i = 1, #tokens, 1 do
        if scripts.people.tokens_table[tokens[i]:lower()] and scripts.people.tokens_table[tokens[i]:lower()][tokens[i+1]] and scripts.people.tokens_table[tokens[i]:lower()][tokens[i+1]][tokens[i+2]]
            and tokens[i+3] ~= "chaosu" and (tokens[i+3] ~= "to" and tokens[i+4] ~= "chyba") then
            for k,v in pairs(scripts.people.tokens_table[tokens[i]:lower()][tokens[i+1]][tokens[i+2]]) do
                scripts.people:process_person_color(string.format("%s %s %s", tokens[i], tokens[i+1], tokens[i+2]), v.name,  v.guild, v.suffix, v.color, v.suffix_only)
            end
        end
        if scripts.people.tokens_table[tokens[i]] and scripts.people.tokens_table[tokens[i]].name then
            local item = scripts.people.tokens_table[tokens[i]]
            scripts.people:process_person_color(tokens[i], item.name, item.guild, item.suffix, item.color, item.suffix_only)
        end
    end
end
