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
    local about_proper = misc.knowledge.declension_category[string.lower(about)]

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

---------------

function scripts.misc.knowledge:show_library_stats(full)
    local libraries_read = db:fetch(scripts.misc.knowledge.db.library_progress,
        { db:eq(scripts.misc.knowledge.db.library_progress.character, scripts.character_name) })

    local libraries_per_category = {}
    local libraries_started_reading = {}
    for _, row in pairs(libraries_read) do
        if libraries_per_category[row.about] == nil then
            libraries_per_category[row.about] = {}
        end

        if row.progress > 0 then
            table.insert(libraries_per_category[row.about],
                { ["library"] = row.library, ["progress"] = row.progress })
            libraries_started_reading[row.library .. row.about] = true
        end
    end

    for _, category in pairs(misc.knowledge.categories) do
        if libraries_per_category[category] == nil then
            libraries_per_category[category] = {}
        end
    end

    if full == true then
        for category, libraries in pairs(scripts.misc.knowledge.category_to_libraries) do
            for library, _ in pairs(libraries) do
                if libraries_started_reading[library .. category] == nil then
                    table.insert(libraries_per_category[category],
                        { ["library"] = library, ["progress"] = 0 })
                end
            end
        end
    end

    cecho(" +------------------------------------------+\n")
    cecho(" |                                          |\n")
    cecho(" |               <ansiLightGreen>przeczytane<grey>                |\n")
    cecho(" |                <yellow>w trakcie<grey>                 |\n")
    cecho(" |              <red>nieprzeczytane<grey>              |\n")
    cecho(" |                                          |\n")
    cecho(" |  kliknij prawym na bibliotece zeby       |\n")
    cecho(" |  zmienic jej status.                     |\n")
    cecho(" |                                          |\n")
    cecho(" +------------------------------------------+\n")

    for _, category in pairs(misc.knowledge.categories) do
        if #libraries_per_category[category] > 0 then
            local header_str = ""
            local first_half = string.rep(" ", 21 - #category / 2)
            header_str = first_half .. "COLOR1" .. category .. "COLOR2"
            local second_half = string.rep(" ", 42 - #header_str + 12)
            header_str = header_str .. second_half
            header_str = header_str:gsub("COLOR1", "<light_slate_blue>")
            header_str = header_str:gsub("COLOR2", "<grey>")
            cecho(" |" .. header_str .. "|\n")
            cecho(" +------------------------------------------+\n")

            table.sort(libraries_per_category[category], function(a, b) return a.library < b.library end)
            for _, library_di in pairs(libraries_per_category[category]) do
                scripts.misc.knowledge:print_library_row(library_di.library, category, library_di.progress)
            end
            cecho(" +------------------------------------------+\n")
        end
    end
end

function scripts.misc.knowledge:print_library_row(library, about, progress)
    local first_half = string.rep(" ", 21 - #library / 2)
    cecho(" |" .. first_half)
    if progress == 1 then
        cechoPopup("<ansiLightGreen>" .. library,
            {
                function() scripts.misc.knowledge.mark_library_with_status(library, about, 0) end,
                function() scripts.misc.knowledge.mark_library_with_status(library, about, 0.5) end
            },
            {
                "oznacz jako nieprzeczytana",
                "oznacz jako w trakcie"
            }, true)
    elseif progress == 0.5 then
        cechoPopup("<yellow>" .. library,
            {
                function() scripts.misc.knowledge.mark_library_with_status(library, about, 0) end,
                function() scripts.misc.knowledge.mark_library_with_status(library, about, 1) end
            },
            {
                "oznacz jako nieprzeczytana",
                "oznacz jako przeczytana"
            }, true)
    else
        cechoPopup("<red>" .. library,
            {
                function() scripts.misc.knowledge.mark_library_with_status(library, about, 0.5) end,
                function() scripts.misc.knowledge.mark_library_with_status(library, about, 1) end
            },
            {
                "oznacz jako w trakcie",
                "oznacz jako przeczytana"
            }, true)
    end
    local second_half = string.rep(" ", 48 - #first_half - #library - 6)
    cecho("<grey>" .. second_half .. "|\n")
end

function scripts.misc.knowledge.mark_library_with_status(library, about, progress)
    local library_row = scripts.misc.knowledge:get_or_create_library_about(library, about,
        scripts.misc.knowledge.library_to_location[library], 0)
    library_row.progress = progress
    db:update(scripts.misc.knowledge.db.library_progress, library_row)
    local msg = "ok, ustawilem biblioteke '" .. library .. "' o '" .. about .. "' jako "
    if progress == 0 then
        msg = msg .. "nieprzeczytana"
    elseif progress == 0.5 then
        msg = msg .. "w trakcie"
    else
        msg = msg .. "przeczytana"
    end
    scripts:print_log(msg)
end
