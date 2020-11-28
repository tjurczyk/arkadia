scripts.ui.notification_center = scripts.ui.notification_center or {
    enabled = true,
    width = 550,
    height = 70,
    gap = 10,
    containers = {},
    timers = {},
    nextIndex = 1,
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

    local notification = { id = self.nextIndex, text = text, duration = duration or self.duration}
    table.insert(self.notifications, notification)
    self.nextIndex = self.nextIndex + 1
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
    for i = notification_size, 1, -1 do
        local element = self.notifications[i]
        if not element.timer and element.duration > 0 then
            element.timer = tempTimer(element.duration, function()
                element.hidden = true
                self:print_notifications()
            end)
        end
        self:print_single_notification(notification_size - i + 1, element)
    end
end

function scripts.ui.notification_center:print_single_notification(index, notification)
    local window_name = "notification_" .. notification.id

    local container = Geyser.Container:new({
        name = window_name,
        x = - 30 - self.width, y = (index - 1) * (self.height + self.gap) + 10,
        width = self.width, height = self.height
    })

    local label = Geyser.Label:new({
        name = "notification_console_" .. notification.id,
        x = 0, y = 0,
        width = "100%", height = "100%",
        fgColor = "black",
        fontSize = getFontSize() * 0.8
    }, container)
    label:echo(notification.text)
    label:setStyleSheet([[
        padding: 5px;
        border: 1px solid #fff;
        border-radius: 5px;
        background: rgba(255, 255, 255, 0.8);
        qproperty-wordWrap: true;
    ]])
    label:setFont(getFont())

    local close_label =  Geyser.Label:new({
        name = "close_" .. notification.id,
        x = -25, y = 5,
        width = 20, height = 20,
        message = "<center>X</center>",
        fgColor = "black"
    }, container)
    close_label:setStyleSheet([[
        background: rgba(0, 0, 0, 0);
        color: #000000;
    ]])

    table.insert(self.containers, container)

    for _, element in pairs({label, close_label}) do       
        setLabelClickCallback(element.name, "notification_center_close_notification", notification)
        setLabelCursor(element.name, "PointingHand")
    end
end

function notification_center_close_notification(notification)
    notification.hidden = true
    scripts.ui.notification_center:print_notifications()
end

scripts.ui.notification_center:print_notifications()
