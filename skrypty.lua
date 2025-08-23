scripts = scripts or { ver = "4.104" }
scripts.event_handlers = scripts.event_handlers or {}

function alias_func_skrypty_help()
    scripts:print_help()
end

function alias_func_skrypty_aliasy_help()
    scripts:alias_print_help()
end

function alias_func_skrypty_bindy_help()
    scripts.keybind:print_help()
end

function alias_func_skrypty_fake()
    local s = matches[2]

    s = string.gsub(s, "%$", "\n")
    feedTriggers("\n" .. s .. "\n")
    echo("\n")
end

function alias_func_skrypty_fake_combat(s)
    s = string.gsub(s, "%$", "\n")
    gmcp = {
        gmcp_msgs = {
            text = enc(s .. "\n"),
            type = "combat.avatar"
        }
    }
    raiseEvent("gmcp.gmcp_msgs", gmcp)
    echo("\n")
end

function alias_func_skrypty_lua_code()
    local f, e = loadstring("return " .. matches[2])
    if not f then
        f, e = assert(loadstring(matches[2]))
    end

    local r = f()
    if r ~= nil then display(r) end
end

function timer_func_skrypty_lamp_info_timer()
    scripts.inv.lamp:process_lamp_counter()
end
