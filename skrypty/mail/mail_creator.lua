scripts.mail_creator = scripts.mail_creator or {
    window_name = "mail_creator",
    to = "mail_to",
    subject = "mail_subject",
    cc = "mail_cc",
    body = "mail_body",
    width = 55,
    templates = {
        plain = require("skrypty.mail.plain_mail_template"),
        plain_border = require("skrypty.mail.plain_border_template"),
        parchment = require("skrypty.mail.parchment_mail_template")
    },
    template = "plain",
    justify = true
}

scripts.mail_creator.width = 55

local function wrap(str, limit)
    if str:trim() == "" then
        return {""}
    end

    limit = limit or scripts.mail_creator.width
    local here = 1
    local buf = ""
    local t = {}
    str:gsub("(%s*)()(%S+)()",
    function(sp, st, word, fi)
        if fi-here > limit then
            here = st
            table.insert(t, buf)
            buf = word
        else
            buf = buf..sp..word
        end
    end)
    if(buf ~= "") then
        table.insert(t, buf)
    end
    return t
end

local function justify(line, limit)
    limit = limit or scripts.mail_creator.width
    if line:len() < limit / 2 then
        return line
    end
    local words = string.split(line, " ")
    local n_words = table.size(words) * 2 - 1
    local space = limit - line:len()
    local current_index = 2
    for i = 2, n_words, 2 do
      table.insert(words, i, " ")
    end
    while space > 0 do
      space = space - 1
      if words[current_index] then
        words[current_index] = words[current_index] .. " "
        current_index = current_index + 2
      end
      if current_index > n_words then
        current_index = 2
      end
    end
    return table.concat(words)
end

function scripts.mail_creator:start()
    openUserWindow(self.window_name, false, false)
    setFont(self.window_name, getFont())
    setUserWindowTitle(self.window_name, "Tworzenie wiadomosci")

    local x = 1
    resizeWindow(self.window_name, x, 680)
    while getColumnCount(self.window_name) - 40 < self.width do
        x = x + 50
        resizeWindow(self.window_name, x, 680)
    end

    moveWindow(self.window_name, 10,30)

    createMiniConsole(self.window_name, self.to, 10, 10, x, 20)
    clearUserWindow(self.to)
    echo(self.to, "Do: ")

    createMiniConsole(self.window_name, self.subject, 10, 30, x, 20)
    clearUserWindow(self.subject)

    createMiniConsole(self.window_name, self.cc, 10, 50, x, 20)
    clearUserWindow(self.cc)
    
    createMiniConsole(self.window_name, self.body, 10, 80, x, 500)
    clearUserWindow(self.body)

    enableCommandLine(self.window_name)
    setCmdLineAction(self.window_name, "mailCreatorAddLine")

    clearCmdLine(self.window_name)

    setCmdLineStyleSheet(self.window_name, [[
        QPlainTextEdit {
            border: 1px solid #333;
        }
    ]])

    self.mail = {
        to = nil,
        subject = nil,
        cc = nil,
        content = {}
    }
end

function mailCreatorAddLine(line)
    self = scripts.mail_creator

    if line:trim() == "**" then
        self:send()
        hideWindow(self.window_name)
        return
    end

    if line:trim() == "~q" then
        hideWindow(self.window_name)
        return
    end

    if not self.mail.to then
        if line:trim() == "" then
            scripts:print_log("Brak odbiorcy")
            hideWindow(self.window_name)
            return
        end
        self.mail.to = line
        clearUserWindow(self.to)
        echo(self.to, "Do: " .. self.mail.to)
        echo(self.subject, "Temat: ")
        return
    end

    if not self.mail.subject then
        if line:trim() == "" then
            scripts:print_log("Brak tematu")
            hideWindow(self.window_name)
            return
        end
        self.mail.subject = line
        clearUserWindow(self.subject)
        echo(self.subject, "Temat: " .. self.mail.subject)
        echo(self.cc, "CC: ")
        return
    end

    if not self.mail.cc then
        self.mail.cc = line
        clearUserWindow(self.cc)
        echo(self.cc, "CC: " .. (self.mail.cc:trim() == "" and "--" or self.mail.cc))
        cecho(self.body, "<light_slate_gray>Wpisz tresc wiadomosci...<reset>")
        return
    end

    local lines = wrap(line)
    if self.justify then
        for k, line in pairs(lines) do
            lines[k] = justify(line)
        end
    end
    for _, wrapped in pairs(lines) do
        scripts.mail_creator:append_input(wrapped)
    end
end

function scripts.mail_creator:append_input(line)
    table.insert(self.mail.content, line)
    self:print()
end

function scripts.mail_creator:print()
    clearUserWindow(self.body)
    for _, line in pairs(self:crate_content()) do
        echo(self.body, line .. "\n")
    end
end

function scripts.mail_creator:crate_content()
    return self.templates[scripts.mail_creator.template].init(self.width):crate_content(self.mail.content)
end

function scripts.mail_creator:send()
    if not self.mail.to or not self.mail.subject then
        return
    end

    if self.mail.to:trim() == "" or self.mail.subject:trim() == "" or table.is_empty(self.mail.content) then
        return
    end

    sendAll("napisz list", self.mail.to, self.mail.subject, self.mail.cc:trim() ~= "" and self.mail.cc or " ")
    local trigger = tempTrigger("Wpisz ~?, zeby uzyskac pomoc, lub **, by zakonczyc edycje.", function() 
        sendAll(unpack(self:crate_content()))
        send("**")
    end, 1)
    tempTimer(10, function() killTrigger(trigger) end)
end

function alias_func_list()
    scripts.mail_creator:start()
end