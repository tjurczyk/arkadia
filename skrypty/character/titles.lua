scripts.character.titles = scripts.character.titles or {}

function scripts.character.titles:make_clickable(title)
    if selectString(title, 1) > -1 then
        setUnderline(true)
        setLink(function()
            send("opcje wyroznienie " .. title)
        end, "Ustaw " .. title)
        resetFormat()
    end
end

function trigger_func_set_title(title)
    scripts.character.titles:make_clickable(title)
end