misc.prompt_check = misc.prompt_check or {}

function misc.prompt_check:init()
    scripts.event_register:register_event_handler("loginSuccessful", function() self:check() end, true)
    if self.alias then
        killAlias(self.alias)
    end
end

function misc.prompt_check:check()
    if gmcp.char.options.no_prompt ~= 1 then
        echo("\n\n")
        scripts:print_log("Masz wlaczony w opcjach Arkadii znak zachety (>). Aby wszystkie skrypty dzialaly poprawnie wylacz go.")
        scripts:print_log("Aby to zrobic wpisz: /prompt")
        self.alias = tempAlias("^/prompt$", [[misc.prompt_check:turn_off()]])
    end
end

function misc.prompt_check:turn_off()
    send("opcje znak wylacz")
    killAlias(self.alias)
end

misc.prompt_check:init()