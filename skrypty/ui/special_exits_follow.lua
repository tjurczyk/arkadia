function trigger_func_skrypty_ui_special_exits_follow(follow)
    if line:match("podchodzi do cedru na skraju urwiska") then
        follow = "zejdz po linie"
    end
    if amap and amap.curr and amap.curr.id == 17944 then
        if not string.match(follow, "wejdz na gore") then
            follow = "wejdz na gore"
        end
    end

    scripts.utils.bind_functional_team_follow(follow)
end