scripts.ui.talk_history = scripts.ui.talk_history or {
    content = {},
    size = 20
}

function scripts.ui.talk_history:add(message)
    table.insert(self.content, 1, {message, os.time()})
    for i = 20, table.size(self.content), 1 do
        table.remove(self.content, i)
    end
end

function scripts.ui.talk_history:print()
    scripts:print_log("Historia komunikacji:", true)
    for i = table.size(self.content), 1, -1 do
        decho(string.format("[%s] %s", os.date(scripts.ui.separate_talk_window_timestamp, self.content[i][2]), ansi2decho(self.content[i][1])))
    end
    echo("\n\n")
end

function alias_func_print_talk_history()
    scripts.ui.talk_history:print()
end