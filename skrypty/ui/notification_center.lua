scripts.ui.notification_center = scripts.ui.notification_center or {
    enabled = true,
    width = 550,
    height = 60,
    gap = 10,
    containers = {},
    timers = {},
    next_index = 1,
    duration = 10,
    notifications = {}
}


--- Add notification with optional duration
---
--- Args:
--- * `text` - notificaiton text, can contain html tags
--- * `duration` - duration in seconds of notification, 0 for never dissapearing
---
--- Example:
--- ```lua
--- scripts.ui.notification_center:add_notification([[<p style="color: red">Warning!</p>]])
--- ```
function scripts.ui.notification_center:add_notification(text, duration)
    if not self.enabled then
        return
    end

    local notification = { id = self.next_index, text = text, duration = duration or self.duration}
    table.insert(self.notifications, notification)
    self.next_index = self.next_index + 1
    self:print_notifications()
end

function scripts.ui.notification_center:print_notifications()
    self.notifications = table.n_filter(self.notifications, function (item)
        return not item.hidden
    end)
    for _, container in pairs(self.containers) do
        container:hide()
    end
    local notification_size = table.size(self.notifications)
    local last_y = 10
    for i = notification_size, 1, -1 do
        local element = self.notifications[i]
        if not element.timer and element.duration > 0 then
            element.timer = tempTimer(element.duration, function()
                element.hidden = true
                self:print_notifications()
            end)
        end
        last_y = self:print_single_notification(last_y, element)
    end
end

function scripts.ui.notification_center:print_single_notification(last_y, notification)
    local window_name = "notification_" .. notification.id

    local lines = string.split(notification.text, "<br>")
    local height = self.height + #lines * getFontSize() * 1.3

    local container = Geyser.Container:new({
        name = window_name,
        x = - 30 - self.width, y = last_y + self.gap,
        width = self.width, height = height
    })

    deleteLabel("notification_console_" .. notification.id)
    local label = Geyser.Label:new({
        name = "notification_console_" .. notification.id,
        x = 0, y = 0,
        width = "100%", height = "100%",
        fontSize = getFontSize() * 0.8
    }, container)
    label:echo(notification.text)
    label:setStyleSheet(scripts.ui.current_theme:get_notification_stylesheet())
    label:setFgColor(scripts.ui.current_theme:get_notification_color())
    label:setFont(getFont())
    deleteLabel("close_" .. notification.id)
    local close_label =  Geyser.Label:new({
        name = "close_" .. notification.id,
        x = -25, y = 5,
        width = 27, height = 27,
        message = "<center>X</center>",
        fgColor = "black"
    }, container)
    close_label:setStyleSheet(scripts.ui.current_theme:get_notification_close_stylesheet())

    table.insert(self.containers, container)

    for _, element in pairs({label, close_label}) do       
        setLabelClickCallback(element.name, "notification_center_close_notification", notification)
        setLabelCursor(element.name, "PointingHand")
    end

    return container:get_y() + container:get_height()
end

function notification_center_close_notification(notification)
    notification.hidden = true
    scripts.ui.notification_center:print_notifications()
end

scripts.ui.notification_center:print_notifications()
