scripts.transports = scripts.transports or {triggers = {}, temp_triggers = {}, active_rides = {}}

local enter_commands = {
    "wsiadz na statek",
    "wsiadz do dylizansu"
}


local definitions = {}

local definitions_dir = getMudletHomeDir() .. "/arkadia/skrypty/transport/definitions"
for dir in lfs.dir(definitions_dir) do
    if dir ~= "." and dir ~= ".." then
        local sub_dir = definitions_dir .. "/" .. dir
        for entry in lfs.dir(sub_dir) do
            if entry ~= "." and entry ~= ".." then
                local definition_file = io.open(sub_dir .. "/" .. entry, "r")
                definitions[entry:sub(1, -6)] = yajl.to_value(definition_file:read("*a"))
                definition_file:close()
            end
        end
    end
end

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
                        local hasRide = false
                        if #self.active_rides > 0 then
                            for _,ride in pairs(self.active_rides) do
                                if ride.id == definition and ride.index == index then
                                    local ride = self:create_ride(definition, index)
                                    self:remove_invalid_rides(ride)
                                    hasRide = true
                                    break
                                end
                            end
                        end
                        if not hasRide then
                            self:create_ride(definition, index)
                        end
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

function scripts.transports:remove_all_rides()
    for _, ride in pairs(self.active_rides) do
        ride:cleanup()
    end
    self.active_rides = {}
end

scripts.transports:init()