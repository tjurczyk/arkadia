function scripts:print_log(msg, new_line, color)
    if msg then
        if new_line then
            echo("\n")
        end
        for _, line in pairs(string.split(msg, "\n")) do
            cecho(string.format("<CadetBlue>(skrypty)<%s>: " .. line .. "\n", color or "tomato"))
        end
    end
    resetFormat()
end



function scripts:print_url(formatted_msg, func, tooltip)
    -- prints a clickable 'formatted_msg' that will execute 'func_name' when clicked and is 'tooltip'
    cechoLink(formatted_msg, type(func) == "function" and func or func .. "()", tooltip, true)
end

function scripts:debug_log(msg, new_line)
    if scripts.debug then
        self:print_log(msg, new_line)
    end
end
