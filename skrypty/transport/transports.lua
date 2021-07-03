scripts.transports = scripts.transports or {triggers = {}, temp_triggers = {}, active_rides = {}}

local enter_commands = {
    "wsiadz na statek"
}


local definitions = {
    ["Haming"] = {
        enter = "^Wchodzisz na rzeczny transportowy statek\\.",
        exit = "^Schodzisz ze statku\\.",
        start = "^Statek odbija od brzegu\\.",
        stops = {
            {
                start = 2616,
                destination = 10018,
                time = 42,
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
                time = 56,
                stop_pattern = "^(?:Haming|Stary zgorzknialy mezczyzna) krzyczy: Doplynelismy do przystani w Hagge! Mozna wysiadac!$"
            },
            {
                start = 10018,
                destination = 2616,
                time = 63,
                stop_pattern = "^(?:Haming|Stary zgorzknialy mezczyzna) krzyczy: Doplynelismy do drugiego pomostu w Pianie! Mozna wysiadac!$",
                set_pattern = "^(?:Haming|Stary zgorzknialy mezczyzna) krzyczy: Nastepnym portem bedzie drugi pomost w Pianie!$"
            }
        }
    },
    ["Malacius"] = {
        enter = "^Wchodzisz na stara szkute\\.$",
        exit = "^Schodzisz ze szkuty\\.$",
        start = "^Szkuta odbija od brzegu\\.$",
        stops = {
            {
                start = 2574,
                destination = 4059,
                time = 58,
                stop_pattern = "^(?:Malacius|Starszy spokojny mezczyzna krzyczy): Doplynelismy do przystani w Blaviken! Mozna wysiadac!$"
            },
            {
                start = 4059,
                destination = 2574,
                time = 58,
                stop_pattern = "^(?:Malacius|Starszy spokojny mezczyzna krzyczy): Doplynelismy do czwartego pomostu w Oxenfurcie! Mozna wysiadac!$"
            }
        }
    },
    ["Jacob"] = {
        enter = "Wchodzisz na smukly drakkar\\.$",
        exit = "Schodzisz z drakkara\\.$",
        start = "Drakkar odbija od brzegu\\.$",
        stops = {
            {
                start = 4060,
                destination = 6428,
                time = 174,
                stop_pattern = "^(?:Sniady spokojny mezczyzna|Jacob) krzyczy: Doplynelismy do przystani na Blekitnej Wstedze! Mozna wysiadac!"
            },
            {
                start = 6428,
                destination = 4060,
                time = 174,
                stop_pattern = "^(?:Sniady spokojny mezczyzna|Jacob) krzyczy: Doplynelismy do przystani w Blaviken! Mozna wysiadac!"
            }
        }
    },
    ["Ancelmus"] = {
        enter = "Wchodzisz na wielka galere.",
        exit = "Schodzisz z galery.",
        start = "Galera odbija od brzegu.",
        stops = {
            {
                start = 6429,
                destination = 6621,
                time = 47,
                stop_pattern = "^(?:Czarnowlosy barczysty mezczyzna|Ancelmus) krzyczy: Doplynelismy do przystani w Krainie Zgromadzenia! Mozna wysiadac!$",
            },
            {
                start = 6621,
                destination = 7233,
                time = 44,
                stop_pattern = "^(?:Czarnowlosy barczysty mezczyzna|Ancelmus) krzyczy: Doplynelismy do wschodniego nabrzeza w Nuln! Mozna wysiadac!$",
                set_pattern = "^(?:Czarnowlosy barczysty mezczyzna|Ancelmus) krzyczy: Nastepnym portem bedzie wschodnie nabrzeze w Nuln!$",
            },
            {
                start = 7233,
                destination = 5207,
                time = 43,
                stop_pattern = "^(?:Czarnowlosy barczysty mezczyzna|Ancelmus) krzyczy: Doplynelismy do przystani w Kreutzhoffen! Mozna wysiadac!$",
                set_pattern = "^(?:Czarnowlosy barczysty mezczyzna|Ancelmus) krzyczy: Nastepnym portem bedzie przystan w Kreutzhoffen!$"
            },
            {
                start = 5207,
                destination = 7233,
                time = 40,
                stop_pattern = "^(?:Czarnowlosy barczysty mezczyzna|Ancelmus) krzyczy: Doplynelismy do wschodniego nabrzeza w Nuln! Mozna wysiadac!$",
            },
            {
                start = 7233,
                destination = 6621,
                time = 45,
                stop_pattern = "^(?:Czarnowlosy barczysty mezczyzna|Ancelmus) krzyczy: Doplynelismy do przystani w Krainie Zgromadzenia! Mozna wysiadac!$",
                set_pattern = "^(?:Czarnowlosy barczysty mezczyzna|Ancelmus) krzyczy: Nastepnym portem bedzie przystan w Krainie Zgromadzenia!$"
            },
            {
                start = 6621,
                destination = 6429,
                time = 42,
                stop_pattern = "^(?:Czarnowlosy barczysty mezczyzna|Ancelmus) krzyczy: Doplynelismy do przystani na Blekitnej Wstedze! Mozna wysiadac!$",
                set_pattern = "^(?:Czarnowlosy barczysty mezczyzna|Ancelmus) krzyczy: Nastepnym portem bedzie przystan na Blekitnej Wstedze!$",
            },
        }
    },
    ["Louis"] = {
        enter = "Wchodzisz na rzeczna tratwe.",
        start = "Tratwa odbija od brzegu.",
        exit = "Schodzisz z tratwy.",
        stops = {
            {
                start = 7732,
                destination = 7733,
                time = 25,
                stop_pattern = "^(?:Smagly przygarbiony mezczyzna|Louis) krzyczy: Doplynelismy do przystani na poludniowym brzegu Grismerie! Mozna wysiadac!"
            },
            {
                start = 7733,
                destination = 7732,
                time = 25,
                stop_pattern = "^(?:Smagly przygarbiony mezczyzna|Louis) krzyczy: Doplynelismy do przystani na polnocnym brzegu Grismerie! Mozna wysiadac!"
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
                table.insert(self.triggers, tempRegexTrigger(stop.set_pattern, function()
                    if amap.curr.id == stop.start then
                        self:create_ride(definition, index)
                    end
                end))
            end
        end
    end
    if self.enter_alias then
        killAlias(self.enter_alias)
    end
    local alias_cmd = string.format("^%s$", table.concat(enter_commands, "|"))
    self.enter_alias = tempAlias(alias_cmd, "_find_ride()")
end

function _find_ride()
    scripts.transports:find_ride()
    send(matches[1])
end

function scripts.transports:get(location) 
    return location_to_definition[location]
end

function scripts.transports:find_ride()
    if #self.active_rides > 0 then
        return
    end
    local candidate_key = location_to_definition[amap.curr.id]
    if not candidate_key then
        scripts:print_log("No ride here!")
    else 
        local candidate = definitions[candidate_key]
        for index, stop in pairs(candidate.stops) do
            if stop.start == amap.curr.id then
                self:create_ride(candidate_key, index)
            end
        end
    end
end

function scripts.transports:create_ride(definition_key, index)
    scripts:print_log("Create ride " .. definition_key .. " " .. index)
    local ride = self.ride:new(definition_key, definitions[definition_key], index, function(ride) self:remove_ride(ride) end)
    table.insert(self.active_rides, ride)
    return ride
end

function scripts.transports:remove_ride(ride)
    table.remove(self.active_rides, table.index_of(self.active_rides, ride))
end

function scripts.transports:remove_invalid_rides(valid_ride)
    local to_clean = table.n_filter(self.active_rides, function(ride) return ride ~= valid_ride end)
    for _, ride in pairs(to_clean) do
        ride:cleanup()
    end
end

scripts.transports:init()