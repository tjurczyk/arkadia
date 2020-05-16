amap.ui['location_marker'] = amap.ui['location_marker'] or {
    location_ids_marked = {},
    working = false,
    color = 'pale_violet_red',
    color2 = 'alice_blue',
    event_handlers = {}
}

function amap.ui.location_marker:toggle_location_marker()
    if amap.ui.location_marker.working then
        for _, event_id, _ in pairs(amap.ui.location_marker['event_handlers']) do
            scripts.event_register:kill_event_handler(event_id)
        end
        amap.ui.location_marker['event_handlers'] = {}
        amap.ui.location_marker.highlighter:off()
        amap.ui.location_marker.working = false
        amap:print_log('wylaczylem markowanie lokacji')
    else
        local rgb_color = color_table[amap.ui.location_marker.color]
        local rgb_color2 = color_table[amap.ui.location_marker.color2]
        amap.ui.location_marker['highlighter'] = Highlight:new({}, rgb_color, rgb_color2),
        table.insert(amap.ui.location_marker['event_handlers'], scripts.event_register:register_event_handler('amapNewLocation', [[ amap.ui.location_marker.mark_current_new_location ]]))
        table.insert(amap.ui.location_marker['event_handlers'], scripts.event_register:register_event_handler('amapBlockerFired', [[ amap.ui.location_marker.blocked_by_blocker ]]))
        table.insert(amap.ui.location_marker['event_handlers'], scripts.event_register:register_event_handler('amapLocationSteppedBack', [[ amap.ui.location_marker.player_stepped_back ]]))
        amap.ui.location_marker.working = true
        amap:print_log('wlaczylem markowanie lokacji')
    end

end

function amap.ui.location_marker:mark_current_new_location(...)
    local new_location_id = arg[1]
    amap.ui.location_marker.highlighter:add_location(new_location_id)
end

function amap.ui.location_marker:blocked_by_blocker(...)
    amap.ui.location_marker.highlighter:remove_location(amap.curr.id)
end

function amap.ui.location_marker:player_stepped_back(...)
    local location_id_stepped_back_from = arg[1]
    amap.ui.location_marker.highlighter:remove_location(location_id_stepped_back_from)
end
