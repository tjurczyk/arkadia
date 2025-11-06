scripts.character.profession = scripts.character.profession or {}

local state_store_key = "character.profession"
local full_profession_points = 240
local weekly_points = 10
local plus_point = 3
local one_week_in_seconds = 604800

function scripts.character.profession:init()
    self.state = scripts.state_store:get(self:get_char_key()) or {}
    scripts.event_register:register_event_handler("profileLoaded", function() self:init() end, true)
end

function scripts.character.profession:init_training(plus_points)
    self.state = {
        start_time = os.time(),
        plus_points = plus_points
    }
    scripts.state_store:set(self:get_char_key(), self.state)
    scripts:print_log("Rozpoczeto trening zawodu")
    self:show_percentage()
end

function scripts.character.profession:get_time_points(time)
    return weekly_points * self:get_number_of_weeks(time)
end

function scripts.character.profession:get_number_of_weeks(time)
    local first_break_point = self:get_next_break_point(self.state.start_time)
    local time_diff = (time - first_break_point) / one_week_in_seconds
    return math.floor(time_diff) + 1
end

function scripts.character.profession:get_next_break_point(time)
    local date = os.date("*t", time)
    local date_diff = (9 - date.wday) % 7
    date.day = date.day + date_diff
    date.hour = 2
    date.min = 0
    date.sec = 0
    local next_breakpoint = os.time(date)
    if next_breakpoint < time then
        next_breakpoint = next_breakpoint + one_week_in_seconds
    end
    return next_breakpoint
end

function scripts.character.profession:add_plus_point()
    self.state.plus_points = self.state.plus_points + plus_point
    scripts.state_store:set(self:get_char_key(), self.state)
    self:show_percentage()
end

function scripts.character.profession:show_percentage()
    if not self.state.start_time then
        scripts:print_log("Zliczanie stazu w zawodzie nie zostalo zainicjalizowane")
        return
    end
    local total = self:get_time_points(os.time()) + self.state.plus_points
    scripts:print_log(string.format("Zawod ukonczony w %02.2f%% (%d/%d)", (total / full_profession_points) * 100, total, full_profession_points))
end

function scripts.character.profession:get_char_key()
    return scripts.character_name and state_store_key .. "." .. scripts.character_name or state_store_key
end

scripts.character.profession:init()

function reset_profession()
    scripts.character.profession:init_training(0)
end

function alias_func_staz(value)
    local value = tonumber(value)
    if value ~= nil then
        scripts.character.profession:init_training(value)
    else
        scripts.character.profession:show_percentage()
    end
end

function trigger_func_staz_plus()
    print("\n")
    scripts.character.profession:add_plus_point()
end

function trigger_func_show_reset_prompt()
    cecho("\n<CadetBlue>(skrypty)<tomato>: Jezeli rozpoczynasz trenowanie nowego zawodu nacisnij ")
    cechoLink("tutaj", function() reset_profession() end, "/staz 0")
    scripts:print_log("Jezeli znasz wartosc stazu (240 pelny staz, 10 punktow za tydzien, 3 punkt za +staz) wpisz /staz [liczba]", true)
end
