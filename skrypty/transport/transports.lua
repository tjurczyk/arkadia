scripts.transports = scripts.transports or {triggers = {}, temp_triggers = {}, active_rides = {}}

local definitions = {
    ["haming"] = {
        enter = "^Wchodzisz na rzeczny transportowy statek\\.",
        exit = "^Schodzisz ze statku\\.",
        start = "^Statek odbija od brzegu\\.",
        stops = {
            {
                start = 2616,
                destination = 10018,
                time = 45,
                stop_pattern = "^(?:Haming|Stary zgorzknialy mezczyzna) krzyczy: Doplynelismy do przystani w Hagge! Mozna wysiadac!$"
            },
            {
                start = 10018,
                destination = 8087,
                time = 45,
                stop_pattern = "^(?:Haming|Stary zgorzknialy mezczyzna) krzyczy: Doplynelismy do przystani w Starych Bukach! Mozna wysiadac!$",
                set_pattern = "^(?:Haming|Stary zgorzknialy mezczyzna) krzyczy: Nastepnym portem bedzie przystan w Starych Bukach!$"
            },
            {
                start = 8087,
                destination = 10018,
                time = 57,
                stop_pattern = "^(?:Haming|Stary zgorzknialy mezczyzna) krzyczy: Doplynelismy do przystani w Hagge! Mozna wysiadac!$"
            },
            {
                start = 10018,
                destination = 2616,
                time = 65,
                stop_pattern = "^(?:Haming|Stary zgorzknialy mezczyzna) krzyczy: Doplynelismy do drugiego pomostu w Pianie! Mozna wysiadac!$",
                set_pattern = "^(?:Haming|Stary zgorzknialy mezczyzna) krzyczy: Nastepnym portem bedzie drugi pomost w Pianie!$"
            }
        }
    }
}

local location_to_definition = {}



function scripts.transports:init()
    for _, triggerId in pairs(self.triggers) do
        killTrigger(triggerId)
    end
    for definition, props in pairs(definitions) do
        for index, stop in pairs(props.stops) do
            location_to_definition[stop.start] = definition
            if stop.set_pattern then
                table.insert(self.triggers, tempRegexTrigger(props.set_pattern, function()
                    if amap.curr.id == stop.start then
                        self:create_ride(definition, index)
                    end
                end))
            end
        end
    end
end

function scripts.transports:enter()
    self.current_ride = self:get(amap.curr.id)
    if definitions[self.current_ride].kill_timer then
        killTimer(definitions[self.current_ride].kill_timer)
        definitions[self.current_ride].kill_timer = nil
    end
    if self.potential_timer then
        killTimer(self.potential_timer)
        self.potential_timer = nil
    end
end

function scripts.transports:exit()
    if definitions[self.current_ride].kill_timer then
        killTimer(definitions[self.current_ride].kill_timer)
        definitions[self.current_ride].kill_timer = nil
    end
    definitions.kill_timer = tempTimer(30, function() self:clean_up() end)
end

function scripts.transports:get(location) return
    location_to_definition[location]
end

function scripts.transports:set_potential_travel_node(definition, index)
    self:set_travel_node(definition, index)
    if self.potential_timer then
        killTimer(self.potential_timer)
        self.potential_timer = nil
    end
    self.potential_timer = tempTimer(30, function() self:exit() end)
end

function scripts.transports:create_ride(definition_key, index)
    table.insert(self.active_rides, self.ride:new(definitions[definition_key], index))
end

scripts.transports:init()
