scripts.inv.bag_setup = scripts.inv.bag_setup or {}

local bags_biernik = {}
for _,biernik in pairs(scripts.inv["bag_in_biernik"]) do
    table.insert(bags_biernik, biernik)
end

function scripts.inv.bag_setup:start()
    local containers = {}
    self.coroutine = coroutine.create(function()
        local triggers = {
            tempBeginOfLineTrigger("Masz przy sobie", function() coroutine.resume(self.coroutine) end),
            tempRegexTrigger(string.format("(?:\\w+) (?:\\w+) (%s)", table.concat(bags_biernik, "|")), function() table.insert(containers, matches[2]) end)
        }
        send("i")
        coroutine.yield()
        for _, id in pairs(triggers) do
            killTrigger(id)
        end
        if #containers == 0 then
            scripts:print_log("Nie udalo sie wykryc pojemnika.")
        elseif #containers == 1 then
            echo("\n\n")
            cechoLink("<orange>Kliknij <u>tutaj<reset><orange>, aby ustawic <SpringGreen>" .. containers[1] .. "<orange> jako domyslny i jedyny pojemnik<reset>    ", function() self:set_all(containers[1]) end, "", true)
            echo("\n")
        else
            echo("\n\n")
            for _, bag in pairs(containers) do
                cecho(scripts.utils.str_pad("<orange>Ustaw <SpringGreen>" .. bag .. "<orange> jako:  ", 25))
                for bag_type, _ in pairs(scripts.inv.available_types) do
                    echo("  ")
                    cechoLink(string.format("[ <yellow>%s<reset> ]", bag_type), function() self:set(bag_type, bag) end, "", true)
                    echo("  ")
                end
                echo("  ")
                cechoLink(string.format("[ <yellow>%s<reset> ]", "wszystkie"), function() self:set_all(bag) end, "", true)
                echo("  ")
                echo("\n")
            end
        end
    end)
    local result, message = coroutine.resume(self.coroutine)
    if not result then
        error(message)
    end
end

function scripts.inv.bag_setup:set_all(bag)
    for bag_type, _ in pairs(scripts.inv.available_types) do
        self:set(bag_type, bag)
    end
    scripts:print_log("Ustawilem <SpringGreen>" .. bag .. "<tomato> jako domyslny pojemnik.")
end

function scripts.inv.bag_setup:set(bag_type, bag)
    for mianownik, biernik in pairs(scripts.inv.bag_in_biernik) do
        if biernik == bag then
            scripts.config:set_var{
                var=string.format("scripts.inv.biernik_%s_bag_1", bag_type),
                value="",
                silent=true
            }
            scripts.config:set_var{
                var=string.format("scripts.inv.dopelniacz_%s_bag_1", bag_type),
                value="",
                silent=true
            }
            scripts.config:set_var{
                var=string.format("scripts.inv.%s_bag_1", bag_type),
                value=mianownik,
                silent=true
            }
            scripts.config:save_config{silent=true}
        end
    end
    scripts:print_log(string.format("Ustawilem <SpringGreen>" .. bag .. "<tomato> jako %s_bag_1.", bag_type))
end

function alias_func_setup_bag()
    scripts.inv.bag_setup:start()
end