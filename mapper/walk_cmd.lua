function amap:walk_cmd_execute(cmd)
    local cmds = string.split(cmd, "#")
    for k, v in pairs(cmds) do
        expandAlias(v, true)
    end
end

function amap:add_walk_pre_cmd(cmd)
    if not cmd or cmd == "" then
        return
    end

    amap.using_pre_walk_cmd = cmd
    scripts.ui:info_compass_update(1)
    amap:print_log("ok, komendy przed ruchem: <LawnGreen>" .. cmd)
end

function amap:add_walk_post_cmd(cmd)
    if not cmd or cmd == "" then
        return
    end

    amap.using_post_walk_cmd = cmd
    scripts.ui:info_compass_update(2)
    amap:print_log("ok, komendy po ruchu: <LawnGreen>" .. cmd)
end

function amap:reset_walk_cmd()
    amap.using_pre_walk_cmd = nil
    amap.using_post_walk_cmd = nil
    scripts.ui:info_compass_update(nil)
    amap:print_log("ok, komendy po/przed skasowane")
end

function amap:add_walk_pre_cmd_permanent(cmd)
    setRoomUserData(amap.curr.id, "walk_pre_cmd", cmd)
    amap:print_log("ok")
end

function amap:add_walk_post_cmd_permanent(cmd)
    setRoomUserData(amap.curr.id, "walk_post_cmd", cmd)
    amap:print_log("ok")
end

function amap:reset_walk_cmd_permanent()
    setRoomUserData(amap.curr.id, "walk_post_cmd", "<reset>")
    setRoomUserData(amap.curr.id, "walk_pre_cmd", "<reset>")
    amap:print_log("ok")
end

function amap:delete_walk_cmd_permanent()
    setRoomUserData(amap.curr.id, "walk_post_cmd", "")
    setRoomUserData(amap.curr.id, "walk_pre_cmd", "")
    amap:print_log("ok")
end

function alias_func_mapper_walk_cmd_pre_cmd()
    amap:add_walk_pre_cmd(matches[2])
end

function alias_func_mapper_walk_cmd_pre_cmd()
    amap:add_walk_pre_cmd_permanent(matches[2])
end

function alias_func_mapper_walk_cmd_post_walk()
    amap:add_walk_post_cmd(matches[2])
end

function alias_func_mapper_walk_cmd_post_walk()
    amap:add_walk_post_cmd_permanent(matches[2])
end

function alias_func_mapper_walk_cmd_walk_()
    amap:reset_walk_cmd()
end

function alias_func_mapper_walk_cmd_walk_()
    amap:reset_walk_cmd_permanent()
end

function alias_func_mapper_walk_cmd_walk_()
    amap:delete_walk_cmd_permanent()
end

