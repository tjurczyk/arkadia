function scripts.misc.knowledge:setup_libraries_data()
    for _, library_details in pairs(misc.knowledge.raw_data.libraries) do
        scripts.misc.knowledge.library_to_location[library_details.name] = library_details.location_id
        scripts.misc.knowledge.location_to_library[library_details.location_id] = library_details.name
        for _, category in pairs(library_details.categories) do
            if scripts.misc.knowledge.category_to_libraries[category] == nil then
                scripts.misc.knowledge.category_to_libraries[category] = {}
            end
            scripts.misc.knowledge.category_to_libraries[category][library_details.name] = true
        end
    end
end

function scripts.misc.knowledge:start_reading_library(about)
    if scripts.misc.knowledge.location_to_library[amap.curr.internal_id] == nil then
        scripts:print_log("Nierozpoznana biblioteka, zglos na discordzie")
        return
    end

    local library_name = scripts.misc.knowledge.location_to_library[amap.curr.internal_id]
    local about_proper = misc.knowledge.declension_category[about]

    local library_row = scripts.misc.knowledge:get_or_create_library_about(
        library_name,
        about_proper,
        amap.curr.internal_id,
        0.5
    )
    scripts.misc.knowledge["library_current_row"] = library_row
end

function scripts.misc.knowledge:cant_get_more_from_library()
    if scripts.misc.knowledge.library_current_row == nil then
        return
    end
    scripts.misc.knowledge.library_current_row.progress = 1
    db:update(scripts.misc.knowledge.db.library_progress, scripts.misc.knowledge.library_current_row)
end

function scripts.misc.knowledge:stop_reading_library()
    scripts.misc.knowledge.library_current_row = nil
end

function scripts.misc.knowledge:get_or_create_library_about(library, about, location_id, progress_on_create)
    local library_about_fetch = db:fetch(scripts.misc.knowledge.db.library_progress,
        { db:eq(scripts.misc.knowledge.db.library_progress.character, scripts.character_name),
            db:eq(scripts.misc.knowledge.db.library_progress.library, library),
            db:eq(scripts.misc.knowledge.db.library_progress.location_id, location_id),
            db:eq(scripts.misc.knowledge.db.library_progress.about, about) })

    if #library_about_fetch == 0 then
        db:add(scripts.misc.knowledge.db.library_progress,
            {
                character = scripts.character_name,
                library = library,
                about = about,
                location_id = location_id,
                progress = progress_on_create
            })
        library_about_fetch = db:fetch(scripts.misc.knowledge.db.library_progress,
            { db:eq(scripts.misc.knowledge.db.library_progress.character, scripts.character_name),
                db:eq(scripts.misc.knowledge.db.library_progress.library, library),
                db:eq(scripts.misc.knowledge.db.library_progress.location_id, location_id),
                db:eq(scripts.misc.knowledge.db.library_progress.about, about) })[1]
    else
        library_about_fetch = library_about_fetch[1]
    end

    return library_about_fetch
end
