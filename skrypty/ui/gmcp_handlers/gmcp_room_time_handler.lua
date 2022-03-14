
scripts.ui.gmcp_room_time_handler = scripts.ui.gmcp_room_time_handler or {}

function scripts.ui.gmcp_room_time_handler:update_ui()
    if not gmcp.room or not gmcp.room.time then
        return
    end 
    scripts.ui:info_daylight_update(gmcp.room.time.daylight)
    scripts.ui:info_season_update(gmcp.room.time.season)
end

function scripts.ui.gmcp_room_time_handler:init()
	self.ui_ready_handler = scripts.event_register:register_singleton_event_handler(self.ui_ready_handler, "uiReady", function () self:update_ui() end)
    if scripts.event_handlers["skrypty/ui/gmcp_handlers/gmcp_room_time_handler.gmcp.room.time.gmcp_room_time_handler"] then
        killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/gmcp_handlers/gmcp_room_time_handler.gmcp.room.time.gmcp_room_time_handler"])
    end
    
    scripts.event_handlers["skrypty/ui/gmcp_handlers/gmcp_room_time_handler.gmcp.room.time.gmcp_room_time_handler"] = registerAnonymousEventHandler("gmcp.room.time", function () self:update_ui() end)
end

scripts.ui.gmcp_room_time_handler:init()