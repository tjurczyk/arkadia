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
    local assistant_match = self:get_from_db(name)
    local location
    if assistant_match then
        selectString(name, 1)
        fg("spring_green")
        resetFormat()
        location = assistant_match.room_id
    else
        location = scripts.people.mail:check_table(name)
    end
    self.current_offer[index] = { name = name, location = location }
    if city and city ~= "" then
        self.current_offer[index].city = city
    end
    if time and time ~= "" then
        self.current_offer[index].time = time
    end
end

function scripts.packages:pickup(command)
    local _, _, index = command:find("wybierz paczke (%d+)")
    if index then
        self.trigger = tempRegexTrigger("^.* przekazuje ci jakas paczke\\.", function ()
            self:package_given(index)
        end, 1)
        self.trigger_fail = tempRegexTrigger("Ty juz dla nas dostatecznie ciezko zapracowales|Nie ufam ci na tyle, aby powierzyc ci dostarczenie tej przesylki|Cos ci sie chyba pomylilo, nie ma takiej oferty|Niestety, nie widzisz tu nikogo, od kogo mozna by wziac zlecenie", function() 
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
        self.footer_info:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Paczka:</font> <font color='" .. scripts.ui["footer_info_neutral"] .. "'>" .. self.picked_offer.name .. time_to_deliver .. "</font>")
        setLabelToolTip(self.footer_info.name, time_to_deliver)
    else
        self.footer_info:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Paczka: -</font>")
        resetLabelToolTip(self.footer_info.name)
    end
end

function scripts.packages:get_from_db(name)
    local result = db:fetch(self.db.packages, db:eq(self.db.packages.name, name))
    if result and table.size(result) == 1 then
        return result[1]
    end
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

scripts.packages:init()