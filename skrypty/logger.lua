function scripts:print_log(msg, new_line)
    if msg then
        if new_line then
            cecho("\n<CadetBlue>(skrypty)<tomato>: " .. msg .. "\n")
        else
            cecho("<CadetBlue>(skrypty)<tomato>: " .. msg .. "\n")
        end
    end
end



function scripts:print_url(formatted_msg, func_name, tooltip)
    -- prints a clickable 'formatted_msg' that will execute 'func_name' when clicked and is 'tooltip'
    cechoLink(formatted_msg, func_name .. "()", tooltip, true)
end

