scripts.packages = scripts.packages or {
    db_name = "packages",
    current_offer = {},
    handlers = {}
}

function scripts.packages:init()
    scripts.event_register:register_event_handler("footerInfoCreators", function(event, creators)
        creators["package"] = function()
            self:setup_display()
        end
    end)

    self.db = db:create(self.db_name, {
        packages = {
            room_id = "",
            name = "",
            city = "",
            hash = "",
            _index = { "room_id" },
            _unique = { "hash" },
            _violations = "REPLACE"
        }
    })
end

function scripts.packages:start()
    if not self.picked_offer then
        self:clear()
        self.current_offer = {}
        self.handlers.send_command = scripts.event_register:force_register_event_handler(self.handlers.send_command, "sysDataSendRequest", function(_, command) return self:pickup(command) end)
        self.handlers.location = scripts.event_register:force_register_event_handler(self.handlers.location, "amapNewLocation", function() self:clear() end, true)
        self.picked_offer = nil
        self.view_time = os.time()
    end
end

function scripts.packages:add(index, name, city, time)
    local assistant_match, multiple = self:get_from_db(name)
    local location
    if assistant_match then
        selectString(name, 1)
        fg("spring_green")
        resetFormat()
        location = assistant_match.room_id
        if getPath(amap.curr.id, location) and selectString("               |", 1) then
            local distance = table.size(speedWalkPath)
            replace(scripts.utils.str_pad(tostring(distance), 8, "right") .. "       |")
        end
    else
        location = scripts.people.mail:check_table(name)
    end

    selectString(name, 1)
    local command = "wybierz paczke " .. index
    setLink(function() send(command) end, command)

    self.current_offer[index] = { name = name, location = location }
    if city and city ~= "" then
        self.current_offer[index].city = city
    end
    if time and time ~= "" then
        self.current_offer[index].time = time
    end
end

function scripts.packages:pickup(command)
    local index = rex.match(command, "^\\s*wybierz paczke (\\d+)")
    if index then
        self.trigger = tempRegexTrigger("^.* przekazuje ci jakas paczke\\.", function()
            self:package_given(index)
        end, 1)
        self.trigger_fail = tempRegexTrigger("Ty juz dla nas dostatecznie ciezko zapracowales|Nie ufam ci na tyle, aby powierzyc ci dostarczenie tej przesylki|Cos ci sie chyba pomylilo, nie ma takiej oferty|Niestety, nie widzisz tu nikogo, od kogo mozna by wziac zlecenie", function()
            if self.trigger then
                killTrigger(self.trigger)
                self.trigger = nil
            end
        end)
        self.trigger_refresh = tempRegexTrigger("Lista przesylek zmienila sie i ta, ktora chcesz podjac byc moze nie jest juz ta, ktora widziales w spisie\\.", function()
            self.current_offer = {}
            if self.trigger then
                killTrigger(self.trigger)
                self.trigger = nil
            end
        end)
    end
end

function scripts.packages:package_given(index)
    if self.trigger_fail then
        killTrigger(self.trigger_fail)
    end
    self.delivery_trigger = tempRegexTrigger("^(Oddajesz|Zwracasz) pocztowa paczke", function() self:package_delivered(matches[2] == "Oddajesz") end, 1)
    self.picked_offer = self.current_offer[index]
    raiseEvent("assistantPackageDestination", self.picked_offer.location)
    if scripts.people.mail.show_automatically and self.picked_offer.location then
        amap.path_display:start(self.picked_offer.location)
    end
    if self.picked_offer.time then
        self.picked_offer.pickup_time = self.view_time
    end
    if self.footer_info then
        self:update_display()
    end
    self:clear()
    self.current_offer = {}
end

function scripts.packages:package_delivered(success)
    if success then
        db:add(self.db.packages, {
            room_id = amap.curr.id,
            name = self.picked_offer.name,
            city = self.picked_offer.city,
            hash = amap.curr.id .. "#" .. self.picked_offer.name
        })
    end
    self.picked_offer = nil
    if self.timer then
        killTimer(self.timer)
        self.timer = nil
    end
    self:update_display()
end

function scripts.packages:clear()
    for _, id in pairs(self.handlers) do
        scripts.event_register:kill_event_handler(self.handlers)
    end
    if self.trigger then
        killTrigger(self.trigger)
        self.trigger = nil
    end
end

function scripts.packages:setup_display()
    self.footer_info = Geyser.Label:new({
        name = "scripts.ui.footer_info.package",
        fontSize = scripts.ui.footer_font_size,
    })
    self.footer_info:setStyleSheet(scripts.ui.footer_info_core_base_css:getCSS())
    self:update_display()
    scripts.ui:add_footer_element(self.footer_info)
end

function scripts.packages:update_display()
    if self.picked_offer then
        local time_to_deliver = ""
        if self.picked_offer.pickup_time then
            local elapsed = (os.time() - self.picked_offer.pickup_time)
            local total = self.picked_offer.time * 120
            time_to_deliver = " " .. misc.improve:seconds_to_formatted_string(math.max(0, total - elapsed))
            if not self.timer then
                self.timer = tempTimer(1, function() self:update_display() end, true)
            end
        end
        if self.footer_info then
            self.footer_info:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Paczka:</font> <font color='" .. scripts.ui["footer_info_neutral"] .. "'>" .. time_to_deliver .. " " .. self.picked_offer.name .. "</font>")
            setLabelToolTip(self.footer_info.name, time_to_deliver)
        end
    else
        if self.footer_info then
            self.footer_info:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Paczka: -</font>")
            resetLabelToolTip(self.footer_info.name)
        end
    end
end

function scripts.packages:get_from_db(name)
    local result = db:fetch_sql(self.db.packages, "SELECT * FROM packages WHERE name = \"" .. name .. "\" COLLATE NOCASE")
    if result and table.size(result) >= 1 then
        return result[1], table.size(result) > 0 and table.size(result) > 1
    end
end

function scripts.packages:remove_all_by_name(name)
    db:delete(self.db.packages, "name = \"" .. name .. "\" COLLATE NOCASE")
end

function trigger_packages_assistant_open()
    scripts.packages:start()
end

function trigger_packages_assistant_package(index, name, city, time)
    scripts.packages:add(index, name, city, time)
end

function trigger_packages_assistant_close()
    setTriggerStayOpen("tablice-open", 0)
end

function trigger_packages_assistant_replace_terminals()
    selectCaptureGroup(1)
    if matches[1] == "==o" then
        replace("====================o", true)
    elseif matches[1] == "  |" then
        replace("                    |", true)
    elseif matches[1] == "- o" then
        replace("------------------- o", true)
    end

    local cursor = selectString("dostarczenie              ", 1)
    if cursor > -1 then
        moveCursor(cursor + 18, getLineNumber())
        replace("dostarczenie       Dystans", true)
    end
end


scripts.packages:init()
