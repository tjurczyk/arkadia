amap.gps = amap.gps or {
    user_data_gps_key = "gps",
    gps_str_separator = "#",
    gps_regex_prefix = "re:",
    -- Entries bucketed by the first word of their last line, so a line only ever
    -- costs a lookup for the words it actually contains.
    entries_by_word = {},
    -- Entries that cannot be bucketed: their last line is a pattern, or has no words.
    scanned_entries = {},
    -- The last lines the game sent, oldest first, the current one last.
    recent = {},
    window_size = 1,
    line_counter = 0,
    synced_at_line = -1,
    line_trigger_id = nil,
    ready = false
}

local function trim5(s)
    return s:match '^%s*(.*%S)' or ''
end

-- The same separators the web client splits on, so a line breaks into the same words
-- in both clients.
local WORD_PATTERN = "[^ \t%.,!%?%*%(%)/%[%]]+"

local function words_of(text)
    local words = {}
    for word in string.gmatch(string.lower(text), WORD_PATTERN) do
        table.insert(words, word)
    end
    return words
end

function amap.gps:print_room_gps(room_id)
    if not room_id then
        error("wrong input in map_sync.gps:print_room_gps")
        return
    end

    local room_data_gps = getRoomUserData(room_id, amap.gps.user_data_gps_key)
    if not room_data_gps or room_data_gps == "" then
        cecho("\n <orange> Map Sync: nie ma zadnego gpsa dla tej lokacji\n")
        return
    end

    local gps_room_elements = yajl.to_value(room_data_gps)

    cecho("\n <orange> Map Sync: gps dla lokacji " .. tostring(room_id) .. "\n\n")
    for k, gps_room_element in pairs(gps_room_elements) do
        local room_gps_id = self:generate_room_gps_id(room_id, k)

        cecho(" <yellow>id<grey>:       " .. room_gps_id .. "\n")

        if gps_room_element.area_name and gps_room_element.area_name ~= "" then
            cecho(" <yellow>obszar<grey>:   " .. gps_room_element.area_name .. "\n")
        end

        if gps_room_element.within_room_ids and table.size(gps_room_element.within_room_ids) > 0 then
            cecho(" <yellow>lokacje<grey>:  " .. table.concat(gps_room_element.within_room_ids, ", ") .. "\n")
        end

        local modes = gps_room_element.gps_line_modes or {}
        for k, gps_string_line in pairs(gps_room_element.gps_string_lines) do
            -- A pattern line reads as a broken literal otherwise.
            local suffix = modes[k] == "regex" and " <grey>[regex]" or ""
            if k == 1 then
                cecho(" <yellow>trigger<grey>: \"" .. gps_string_line .. "\"" .. suffix .. "\n")
            else
                cecho("          \"" .. gps_string_line .. "\"" .. suffix .. "\n")
            end
        end

        cecho("\n")
    end
end

--- Split what the alias was given into lines and their modes.
---
--- Lines are separated by "#", and one prefixed with "re:" is a pattern rather than
--- plain text - so a single entry can pair a literal room name with a pattern for the
--- line that varies. `all_regex` marks every line instead, for an entry that is
--- patterns throughout. A line that really has to start with "re:" is the one thing this
--- cannot express; the map editor can.
function amap.gps:parse_gps_string(gps_str, all_regex)
    local raw_lines = string.split(gps_str, amap.gps.gps_str_separator)
    if table.size(raw_lines) == 0 then
        return nil, nil, "gps musi miec przynajmniej jedna linie"
    end

    local lines, modes, any_regex = {}, {}, false
    for _, raw in ipairs(raw_lines) do
        local text = trim5(raw)
        local is_regex = all_regex or false

        local without_prefix = string.match(text, "^" .. amap.gps.gps_regex_prefix .. "(.*)$")
        if without_prefix then
            text = trim5(without_prefix)
            is_regex = true
        end

        if text == "" then
            return nil, nil, "gps ma pusta linie"
        end
        if is_regex and not pcall(rex.find, "", text) then
            return nil, nil, "to nie jest poprawne wyrazenie regularne: " .. text
        end

        table.insert(lines, text)
        table.insert(modes, is_regex and "regex" or "literal")
        if is_regex then
            any_regex = true
        end
    end

    return lines, (any_regex and modes or nil)
end

function amap.gps:add_gps_to_room(room_id, gps_str, area_name, within_room_ids, all_regex)
    if not room_id or not gps_str then
        error("wrong input in map_sync.gps:add_gps_to_room")
        return
    end

    local gps_string_lines, gps_line_modes, err = self:parse_gps_string(gps_str, all_regex)
    if not gps_string_lines then
        cecho("\n<orange> Map Sync: " .. err .. ". Nie dodalem gpsa.\n")
        return
    end

    -- No room_id: an entry belongs to the room it is saved in, and both this script and
    -- the web client sync to that room rather than to anything stored beside the lines.
    -- No line_delta either: the lines of a sequence have to be consecutive, and no value
    -- stored here has ever changed that.
    local gps_dictionary = {}
    gps_dictionary.gps_string_lines = gps_string_lines
    gps_dictionary.gps_line_modes = gps_line_modes
    gps_dictionary.area_name = area_name
    gps_dictionary.within_room_ids = within_room_ids

    local room_data_gps = getRoomUserData(room_id, amap.gps.user_data_gps_key)
    local gps_room_elements = {}
    if room_data_gps and room_data_gps ~= "" then
        gps_room_elements = yajl.to_value(room_data_gps)
    end

    table.insert(gps_room_elements, gps_dictionary)
    local yajl_gps_room_elements = yajl.to_string(gps_room_elements)
    setRoomUserData(room_id, amap.gps.user_data_gps_key, yajl_gps_room_elements)

    local final_msg = "\n <orange> Map Sync: dodalem gps do lokacji " .. tostring(room_id)

    if area_name then
        final_msg = final_msg .. " w obszarze " .. area_name
    end

    final_msg = final_msg .. ". Pamietaj aby zapisac mape przed wrzuceniem na serwer\n"
    cecho(final_msg)

    amap.gps:init_triggers()
end

function amap.gps:remove_gps(room_gps_id)
    local room_gps_id_array = string.split(room_gps_id, "_")
    if room_gps_id_array == nil or table.size(room_gps_id_array) ~= 2 then
        error("map_sync.gps:remove_gps got wrong argument")
        return
    end

    local room_id = room_gps_id_array[1]
    local room_gps_idx = tonumber(room_gps_id_array[2])

    local room_data_gps = getRoomUserData(room_id, self.user_data_gps_key)
    if not room_data_gps or room_data_gps == "" then
        cecho("\n<orange> Map Sync: nie znalazlem gps o id: " .. room_gps_id .. "\n")
        return
    end

    local gps_room_elements = yajl.to_value(room_data_gps)

    local filtered_gps_room_elements = {}
    for k, gps_room_element in pairs(gps_room_elements) do
        if k ~= room_gps_idx then
            table.insert(filtered_gps_room_elements, gps_room_element)
        end
    end

    if table.size(filtered_gps_room_elements) == table.size(gps_room_elements) then
        cecho("\n<orange> Map Sync: nie znalazlem gps o id: " .. room_gps_id .. "\n")
        return
    end

    local yajl_filtered_gps_room_elements = yajl.to_string(filtered_gps_room_elements)
    setRoomUserData(room_id, amap.gps.user_data_gps_key, yajl_filtered_gps_room_elements)
    cecho("\n<orange> Map Sync: ok, gps usuniety. Pamietaj o zapisie mapy przed wrzuceniem na serwer.\n")

    amap.gps:init_triggers()
end

--- Resolve one stored entry into the form the matcher works with, or nil to drop it.
---
--- `gps_line_modes` runs parallel to `gps_string_lines`: the slot holding "regex" makes
--- that line a pattern, anything else leaves it a literal. Entries are typed and pasted
--- by hand, so a literal is trimmed - the whitespace around it was never part of what it
--- means.
function amap.gps:compile_entry(room_id, index, gps_room_element)
    local raw_lines = gps_room_element.gps_string_lines
    if not raw_lines or table.size(raw_lines) == 0 then
        return nil
    end

    local modes = gps_room_element.gps_line_modes or {}
    local lines = {}
    for k, text in ipairs(raw_lines) do
        if type(text) ~= "string" then
            return nil
        end
        if modes[k] == "regex" then
            -- A pattern that does not compile would otherwise raise on every line.
            if not pcall(rex.find, "", text) then
                return nil
            end
            table.insert(lines, { pattern = text })
        else
            local literal = trim5(text)
            if literal == "" then
                return nil
            end
            table.insert(lines, { literal = literal })
        end
    end

    local within_room_ids = nil
    if gps_room_element.within_room_ids and table.size(gps_room_element.within_room_ids) > 0 then
        within_room_ids = {}
        for _, id in pairs(gps_room_element.within_room_ids) do
            within_room_ids[tonumber(id)] = true
        end
    end

    local area_name = gps_room_element.area_name
    if area_name == "" then
        area_name = nil
    end

    return {
        id = self:generate_room_gps_id(room_id, index),
        room_id = tonumber(room_id),
        lines = lines,
        area_name = area_name,
        within_room_ids = within_room_ids
    }
end

function amap.gps:index_entry(entry)
    local last = entry.lines[#entry.lines]
    if last.literal then
        local key = words_of(last.literal)[1]
        if key then
            local bucket = self.entries_by_word[key]
            if not bucket then
                bucket = {}
                self.entries_by_word[key] = bucket
            end
            table.insert(bucket, entry)
            return
        end
    end
    table.insert(self.scanned_entries, entry)
end

function amap.gps:line_matches(gps_line, text)
    if gps_line.literal then
        return string.find(text, gps_line.literal, 1, true) ~= nil
    end
    local ok, result = pcall(rex.find, text, gps_line.pattern)
    return ok and result ~= nil
end

--- Walk the entry's lines backwards from the current one. They have to sit directly
--- behind each other, which is the sequence the per-entry cursor used to enforce.
function amap.gps:matches_window(entry)
    local idx = #self.recent
    for i = #entry.lines, 1, -1 do
        if idx < 1 or not self:line_matches(entry.lines[i], self.recent[idx]) then
            return false
        end
        idx = idx - 1
    end
    return true
end

function amap.gps:check_context(entry)
    if entry.area_name and entry.area_name ~= amap.curr.area then
        -- not in the area of the gps, ending
        return false
    end
    if entry.within_room_ids and not entry.within_room_ids[tonumber(amap.curr.id)] then
        -- not in the within room ids, ending
        return false
    end
    return true
end

function amap.gps:try_entry(entry)
    if self.synced_at_line == self.line_counter then
        return
    end
    if not self:check_context(entry) or not self:matches_window(entry) then
        return
    end
    -- Claim the line even when we are already standing there: a second entry sharing this
    -- line lost the race, and letting it move us would undo a good sync.
    self.synced_at_line = self.line_counter
    if tonumber(amap.curr.id) ~= entry.room_id then
        amap:set_position(entry.room_id, true)
        cecho("\n<orange> Map Sync: gps " .. entry.id)
    end
end

--- A sequence is recognised when its *final* line arrives and the ones before it are
--- still in the window, so no entry carries a cursor between lines: nothing can be left
--- half-open, and a line arriving out of turn cannot desynchronise anything.
function amap.gps:on_line(text)
    self.line_counter = self.line_counter + 1
    table.insert(self.recent, trim5(text))
    while #self.recent > self.window_size do
        table.remove(self.recent, 1)
    end

    for _, entry in ipairs(self.scanned_entries) do
        self:try_entry(entry)
    end

    local seen = {}
    for _, word in ipairs(words_of(self.recent[#self.recent])) do
        local bucket = self.entries_by_word[word]
        if bucket then
            for _, entry in ipairs(bucket) do
                if not seen[entry] then
                    seen[entry] = true
                    self:try_entry(entry)
                end
            end
        end
    end
end

function amap.gps:init_triggers()
    self.entries_by_word = {}
    self.scanned_entries = {}
    self.recent = {}
    self.window_size = 1
    self.synced_at_line = -1

    -- Sorted, so two entries claiming the same line always resolve the same way.
    local room_ids = {}
    for id in pairs(getRooms()) do
        table.insert(room_ids, id)
    end
    table.sort(room_ids, function(a, b) return tonumber(a) < tonumber(b) end)

    local gps_count = 0
    for _, id in ipairs(room_ids) do
        local room_data_gps = getRoomUserData(id, amap.gps.user_data_gps_key)
        if room_data_gps and room_data_gps ~= "" then
            local ok, gps_data = pcall(yajl.to_value, room_data_gps)
            if ok and type(gps_data) == "table" then
                for k, v in ipairs(gps_data) do
                    local entry = self:compile_entry(id, k, v)
                    if entry then
                        self:index_entry(entry)
                        if #entry.lines > self.window_size then
                            self.window_size = #entry.lines
                        end
                        gps_count = gps_count + 1
                    end
                end
            end
        end
    end

    -- One trigger for the whole map, kept across rebuilds. The per-entry triggers this
    -- replaced were never killed, so every rebuild used to leave the old ones running.
    if not self.line_trigger_id then
        self.line_trigger_id = tempRegexTrigger("^", function() amap.gps:on_line(line) end)
    end

    self.ready = true

    scripts:print_log("Zbudowalem " .. tostring(gps_count) .. " elementow gps\n", true)
end

function amap.gps:generate_room_gps_id(room_id, room_incremental_gps_number)
    if not room_id or not room_incremental_gps_number then
        error("wrong input in map_sync.gps:generate_room_gps_id()")
        return
    end

    local room_gps_id = tostring(room_id) .. "_" .. tostring(room_incremental_gps_number)
    return room_gps_id
end


function alias_func_map_sync_add_gps()
    if amap.curr.id then
        amap.gps:add_gps_to_room(amap.curr.id, matches[2], nil, nil)
    end
end

function alias_func_map_sync_add_gps_regex()
    if amap.curr.id then
        amap.gps:add_gps_to_room(amap.curr.id, matches[2], nil, nil, true)
    end
end

function alias_func_map_sync_add_gps_area()
    if amap.curr.id then
        amap.gps:add_gps_to_room(amap.curr.id, matches[2], amap.curr.area, nil)
    end
end

function alias_func_map_sync_add_gps_within_rooms()
    local within_room_ids = string.split(matches[2], ",")

    if amap.curr.id then
        amap.gps:add_gps_to_room(amap.curr.id, matches[3], nil, within_room_ids)
    end
end

function alias_func_map_sync_remove_gps()
    amap.gps:remove_gps(matches[2])
end


function alias_func_map_sync_show_gps()
    if amap.curr.id then
        amap.gps:print_room_gps(amap.curr.id)
    end
end

function alias_func_map_sync_show_gps_room()
    amap.gps:print_room_gps(tonumber(matches[2]))
end


scripts.event_register:register_event_handler("mapOpenEvent", function() amap.gps:init_triggers() end, true)
