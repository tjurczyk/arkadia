scripts.people.introduced = scripts.people.introduced or {
    triggers = {},
    key = "introduced"
}

function scripts.people.introduced:capture()
    table.insert(self.triggers, tempRegexTrigger("^Osoby, ktore zostaly ci ostatnio przedstawione, to (.*)\\.", function() self:process_introduced(matches) end))
    table.insert(self.triggers, tempRegexTrigger("^Zapamietane przez ciebie imiona to (.*)\\.", function() self:process(matches) end))
    send("zapamietani")
    send("przedstawieni")
end

function scripts.people.introduced:process(matches)
    self.introduced = string.split(matches[2]:gsub(" i ", ", "), ", ")
    self.previous = scripts.state_store:get(self.key)
    scripts.state_store:set(self.key, self.introduced)
    if selectString("Zapamietane", 1) > - 1 then
        creplace(string.format("<spring_green>[%d]<reset> Zapamietane", table.size(self.introduced)))
    end
    if self.previous then
        local deleted = table.n_complement(self.previous, self.introduced)
        if not table.is_empty(deleted) then
            echo("\n\n")
            cecho("<slate_blue>Osoby usuniete z zapamietanych: <yellow>" .. table.concat(deleted, ", "))
            resetFormat()
        end
    end
    echo("\n\n")
end

function scripts.people.introduced:process_introduced(matches)
    local people = string.split(matches[2]:gsub(" i ", ", "), ", ")
    for k, name in pairs(people) do
        if not table.contains(self.introduced, name) then
            if selectString(name, 1) > -1 then
                local command = [[send("zapamietaj imie ]].. name .. [[")]]
                setUnderline(true)
                setLink(command, command)
                resetFormat()
            end
        end
    end
    if selectString("Osoby", 1) > - 1 then
        creplace(string.format("<spring_green>[%d]<reset> Osoby", table.size(people)))
    end
    for _, trigger in pairs(self.triggers) do
        killTrigger(trigger)
    end
end

function alias_func_introduced_capture()
    scripts.people.introduced:capture()
end