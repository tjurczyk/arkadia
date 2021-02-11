scripts.ui.inline_compass_rose = scripts.ui.inline_compass_rose or {}

function scripts.ui.inline_compass_rose:init()
    self.cfg_handler = scripts.event_register:force_register_event_handler(self.cfg_handler, "setVar", function (_, var, val)
        if var == "scripts.ui.inline_compass_rose.enabled" then
            if val then
                self.handler = scripts.event_register:force_register_event_handler(self.handler, "gmcp.gmcp_msgs", function()
                    if gmcp.gmcp_msgs.type == "room.exits" then
                        self:show_compass_rose()
                    end
                end)
            else
                scripts.event_register:kill_event_handler(self.handler)
            end
        end
    end)
end

function scripts.ui.inline_compass_rose:show_compass_rose()
    echo("\n")
    echo("       ") self:print_exit("nw") echo("  ") self:print_exit("n") echo("  ") self:print_exit("ne") echo("       ") self:print_exit("u")
    echo("\n")
    echo("       ") echo("  ") cecho(self:has_exit("nw") and "\\" or " ") echo(" ") cecho(self:has_exit("n") and "|" or " ") echo(" ") cecho(self:has_exit("ne") and "/" or " ") echo("         ") cecho(self:has_exit("u") and "|" or "" )
    echo("\n")
    echo("       ") self:print_exit("w") cecho(self:has_exit("w") and "---" or "   ") cecho("<dim_gray>X<reset>") cecho(self:has_exit("e") and "---" or "   ") self:print_exit("e") echo("       ") cecho((self:has_exit("d") or self:has_exit("u")) and "o" or "")
    echo("\n")
    echo("       ") echo("  ") cecho(self:has_exit("sw") and "/" or " ") cecho(" ") cecho(self:has_exit("s") and "|" or " ") cecho(" ") cecho(self:has_exit("se") and "\\" or " ") echo("         ") cecho(self:has_exit("d") and "|" or "" )
    echo("\n")
    echo("       ") self:print_exit("sw") echo("  ") self:print_exit("s") echo("  ") self:print_exit("se") echo("       ") self:print_exit("d")
    echo("\n\n")
end

function scripts.ui.inline_compass_rose:print_exit(short)
    cecho("<spring_green>".. (self:has_exit(short) and short:upper() or string.rep(" ", string.len(short))) .. "<reset>")
end

function scripts.ui.inline_compass_rose:has_exit(short)
    return table.contains(gmcp.room.info.exits, amap.english_to_polish[amap.short_to_long[short]])
end

scripts.ui.inline_compass_rose:init()