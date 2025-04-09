herbs = herbs or {
    db = {},
    data_file_path = getMudletHomeDir() .. "/herbs_data",
    data_url = "https://raw.githubusercontent.com/tjurczyk/arkadia-data/master/herbs_data.json",
    settings = { get_herb_counts = { 1, 3 }, use_herb_counts = { 1, 3 } },
    pre_actions = "",
    post_actions = "",
    pre_use = "",
    post_use = ""
}

herbs["full_bag_amount"] = 44
herbs["many_to_int"] = 25

herbs["pre_herb_actions"] = ""
herbs["post_herb_actions"] = ""

herbs["use_herb_triggers"] = false
herbs["herb_trigg_ids"] = {}

function trigger_func_skrypty_herbs_rozwiaz_rzemyk()
    if herbs.current_bag_looking then
        if matches[2] then
            -- this is actually hit. segregate and add to the db
            local segregated = herbs:check_single_bag(matches[2])
            herbs:add_to_db(segregated, herbs.current_bag_looking)
        end

        coroutine.resume(herbs["build_db_coroutine_id"])
    else
        local segregated = herbs:check_single_bag(matches[2])
        herbs:v2_print_single(segregated)
    end
end

function trigger_func_skrypty_herbs_rozwiaz_rzemyk_pusty()
    if herbs.current_bag_looking then
        coroutine.resume(herbs["build_db_coroutine_id"])
    end
    local event_data = { ["total_herbs_count"] = 0, ["herbs"] = {} }
    raiseEvent("herbBagParsed", event_data)
end

function alias_func_skrypty_herbs_buduj()
    herbs:do_pre_actions()
    herbs:coroutine_build_db()
end

function alias_func_skrypty_herbs_wezz()
    herbs:do_pre_actions()
    herbs:get_herbs(matches[2], tonumber(matches[3]))
    herbs:do_post_actions()
end

function alias_func_skrypty_herbs_wezz_single()
    herbs:do_pre_actions()
    herbs:get_herbs(matches[2], 1)
    herbs:do_post_actions()
end

function alias_func_skrypty_herbs_v1_pokaz_ziola()
    herbs:print_db()
end

function alias_func_skrypty_herbs_pokaz_ziola()
    herbs:v2_print_db()
end

function alias_func_skrypty_herbs_pokaz_ziola_per_worek()
    herbs:v2_print_db_per_bag(true)
end

function alias_func_skrypty_herbs_pokaz_ziola_per_worek_short()
    herbs:v2_print_db_per_bag(false)
end

function alias_func_skrypty_herbs_help()
    herbs:print_help()
end

function alias_func_skrypty_herbs_pakuj()
    herbs:pack_herb_with_herb(tonumber(matches[2]), matches[3])
end

function alias_func_skrypty_herbs_przeszukaj_ziola()
    herbs:search_herbs(matches[2])
end

function alias_func_skrypty_herbs_zazyj_ziolo()
    herbs:do_pre_actions()
    herbs:use_herb(matches[3], matches[2], tonumber(matches[4]) or 1)
    herbs:do_post_actions()
end

function alias_func_skrypty_herbs_move_from_to_bag()
    herbs:do_pre_actions()
    herbs:repack_from_to_bag(matches[2], matches[3])
    herbs:do_post_actions()
end

function alias_func_skrypty_herbs_woreczki_buduj()
    herbs:do_pre_actions()
    herbs:collect_herb_bag_condition(true)
end

function alias_func_skrypty_herbs_daj_ziola_druzynie()
    herbs:do_pre_actions()
    herbs:give_herbs_teammate(matches[2], matches[3], tonumber(matches[4]))
    herbs:do_post_actions()
end

function alias_func_skrypty_herbs_daj_ziola_druzynie_single()
    herbs:do_pre_actions()
    herbs:give_herbs_teammate(matches[2], matches[3], 1)
    herbs:do_post_actions()
end

function alias_func_skrypty_herbs_ziola_odloz_woreczek()
    herbs:do_pre_actions()
    herbs:put_herb_bag_down(matches[2])
    herbs:do_post_actions()
end

function alias_func_skrypty_herbs_show_herbs(full, one_category)
    herbs:show_summary(full, one_category)
end
