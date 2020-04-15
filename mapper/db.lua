function alias_func_mapper_db_loc_name()
    amap.db:set_name(nil, matches[2])
end

function alias_func_mapper_db_loc_name_id()
    amap.db:set_name(tonumber(matches[2]), matches[3])
end

function alias_func_mapper_db_loc_desc()
    amap.db:set_desc(nil, matches[2])
end

function alias_func_mapper_db_loc_desc_id()
    amap.db:set_desc(tonumber(matches[2]), matches[3])
end

function alias_func_mapper_db_loc_note()
    amap.db:set_note(nil, matches[2])
end

function alias_func_mapper_db_loc_note_id()
    amap.db:set_note(tonumber(matches[2]), matches[3])
end

function alias_func_mapper_db_loc_note__()
    amap.db:set_note(tonumber(matches[3]), "")
end

function alias_func_mapper_db_search_map()
    amap.db:search_rooms(matches[3], true)
end

function alias_func_mapper_db_search_map_all()
    amap.db:search_rooms(matches[3], false)
end

function alias_func_mapper_db_switch_notes()
    amap.db:switch_show_notes()
end

function alias_func_mapper_db_print_db_help()
    amap:print_db()
end

function alias_func_mapper_db_lok_bind()
    amap.db:set_bind(nil, matches[2])
end

function alias_func_mapper_db_loc_bind_id()
    amap.db:set_bind(tonumber(matches[2]), matches[3])
end

function alias_func_mapper_db_loc_bind__()
    amap.db:reset_bind(tonumber(matches[3]))
end

function alias_func_mapper_db_switch_binds()
    amap.db:switch_show_binds()
end

function alias_func_mapper_db_loc_team_follow()
    amap.db:add_follow_link(nil, matches[2], matches[3])
end

function alias_func_mapper_db_lock_team_follow_id()
    amap.db:add_follow_link(tonumber(matches[2]), matches[3], matches[4])
end

function alias_func_mapper_db_lok_team_follow__()
    amap.db:reset_follow_link(tonumber(matches[3]))
end

