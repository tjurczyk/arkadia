scripts.misc = scripts.misc or {}
scripts.misc.knowledge = scripts.misc.knowledge or
    {
        ["db"] = nil,
        ["book_declension_map"] = {},
        ["category_to_books"] = {},
        ["category_to_libraries"] = {},
        ["library_to_location"] = {},
        ["location_to_library"] = {},
        ["book_hint_trigger_ids"] = {},
        ["book_to_about_to_progress"] = {}
    }

scripts.misc.knowledge.db = db:create("knowledge", {
    book_progress = {
        character = "",
        book = "",
        about = "",
        progress = 0,
        changed = db:Timestamp("CURRENT_TIMESTAMP"),
        _index = { "character", "book", "about" },
        _violations = "IGNORE"
    },
    library_progress = {
        character = "",
        library = "",
        location_id = "",
        about = "",
        progress = 0,
        changed = db:Timestamp("CURRENT_TIMESTAMP"),
        _index = { "character", "book", "about" },
        _violations = "IGNORE"
    }
}
)

function scripts.misc.knowledge:show_help()
    cecho(" +------------------------------------------+\n")
    cecho(" |                                          |\n")
    cecho(" |             > ")
    cechoLink("<light_slate_blue>/ksiazki", function() scripts.misc.knowledge:show_book_stats() end, "/ksiazki", true)
    cecho("  <                |\n")

    cecho(" |             > ")
    cechoLink("<light_slate_blue>/ksiazki!", function() scripts.misc.knowledge:show_book_stats(true) end, "/ksiazki!",
        true)
    cecho(" <                |\n")
    cecho(" |           >  ")
    cechoLink("<light_slate_blue>/biblioteki", function() scripts.misc.knowledge:show_library_stats() end, "/biblioteki",
        true)
    cecho("  <              |\n")
    cecho(" |           >  ")
    cechoLink("<light_slate_blue>/biblioteki!", function() scripts.misc.knowledge:show_library_stats(true) end,
        "/biblioteki!",
        true)
    cecho(" <              |\n")
    cecho(" |                                          |\n")
    cecho(" +------------------------------------------|\n")
end

function scripts.misc.knowledge:setup_books_data()
    for _, book_details in pairs(misc.knowledge.raw_data.books) do
        scripts.misc.knowledge.book_declension_map[book_details.dopelniacz] = book_details.mianownik
        scripts.misc.knowledge.book_declension_map[book_details.biernik] = book_details.mianownik
        for _, category in pairs(book_details.categories) do
            if scripts.misc.knowledge.category_to_books[category] == nil then
                scripts.misc.knowledge.category_to_books[category] = {}
            end
            scripts.misc.knowledge.category_to_books[category][book_details.mianownik] = true
        end
    end

    scripts.misc.knowledge.init_book_triggers()
end

function scripts.misc.knowledge:start_reading_book(book, about)
    scripts.misc.knowledge["book_current_row"] = nil
    local book_proper = scripts.misc.knowledge.book_declension_map[book]
    local about_proper = misc.knowledge.declension_category[string.lower(about)]

    if book == "tutejsze zasoby" then
        return
    end

    if not book_proper then
        scripts:print_log("Nierozpoznana ksiega: " .. book .. ", zglos na discordzie")
        return
    end

    local book_row = scripts.misc.knowledge:get_or_create_book_about(book_proper, about_proper, 0.5)
    scripts.misc.knowledge["book_current_row"] = book_row
end

function scripts.misc.knowledge:get_or_create_book_about(book, about, progress_on_create)
    local book_about_fetch = db:fetch(scripts.misc.knowledge.db.book_progress,
        { db:eq(scripts.misc.knowledge.db.book_progress.character, scripts.character_name),
            db:eq(scripts.misc.knowledge.db.book_progress.book, book),
            db:eq(scripts.misc.knowledge.db.book_progress.about, about) })

    if #book_about_fetch == 0 then
        db:add(scripts.misc.knowledge.db.book_progress,
            {
                character = scripts.character_name,
                book = book,
                about = about,
                progress = progress_on_create
            })
        book_about_fetch = db:fetch(scripts.misc.knowledge.db.book_progress,
            { db:eq(scripts.misc.knowledge.db.book_progress.character, scripts.character_name),
                db:eq(scripts.misc.knowledge.db.book_progress.book, book),
                db:eq(scripts.misc.knowledge.db.book_progress.about, about) })[1]
    else
        book_about_fetch = book_about_fetch[1]
    end

    return book_about_fetch
end

function scripts.misc.knowledge:cant_get_more_from_book()
    if scripts.misc.knowledge.book_current_row == nil then
        return
    end
    scripts.misc.knowledge.book_current_row.progress = 1
    db:update(scripts.misc.knowledge.db.book_progress, scripts.misc.knowledge.book_current_row)
end

function scripts.misc.knowledge:stop_reading_book()
    scripts.misc.knowledge.book_current_row = nil
end

function scripts.misc.knowledge:show_book_stats(full)
    local books_read = db:fetch(scripts.misc.knowledge.db.book_progress,
        { db:eq(scripts.misc.knowledge.db.book_progress.character, scripts.character_name) })

    local books_per_category = {}
    local books_started_reading = {}
    for _, row in pairs(books_read) do
        if books_per_category[row.about] == nil then
            books_per_category[row.about] = {}
        end

        if row.progress > 0 then
            table.insert(books_per_category[row.about],
                { ["book"] = row.book, ["progress"] = row.progress })
            books_started_reading[row.book .. row.about] = true
        end
    end

    for _, category in pairs(misc.knowledge.categories) do
        if books_per_category[category] == nil then
            books_per_category[category] = {}
        end
    end

    if full == true then
        for category, books in pairs(scripts.misc.knowledge.category_to_books) do
            for book, _ in pairs(books) do
                if books_started_reading[book .. category] == nil then
                    table.insert(books_per_category[category],
                        { ["book"] = book, ["progress"] = 0 })
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
    cecho(" |  kliknij prawym na ksiazce zeby zmienic  |\n")
    cecho(" |  jej status.                             |\n")
    cecho(" |                                          |\n")
    cecho(" +------------------------------------------+\n")

    for _, category in pairs(misc.knowledge.categories) do
        if #books_per_category[category] > 0 then
            local header_str = ""
            local first_half = string.rep(" ", 21 - #category / 2)
            header_str = first_half .. "COLOR1" .. category .. "COLOR2"
            local second_half = string.rep(" ", 42 - #header_str + 12)
            header_str = header_str .. second_half
            header_str = header_str:gsub("COLOR1", "<light_slate_blue>")
            header_str = header_str:gsub("COLOR2", "<grey>")
            cecho(" |" .. header_str .. "|\n")
            cecho(" +------------------------------------------+\n")

            table.sort(books_per_category[category], function(a, b) return a.book < b.book end)
            for _, book_di in pairs(books_per_category[category]) do
                scripts.misc.knowledge:print_book_row(book_di.book, category, book_di.progress)
            end
            cecho(" +------------------------------------------+\n")
        end
    end
end

function scripts.misc.knowledge:print_book_row(book, about, progress)
    local first_half = string.rep(" ", 21 - #book / 2)
    cecho(" |" .. first_half)
    if progress == 1 then
        cechoPopup("<ansiLightGreen>" .. book,
            {
                function() scripts.misc.knowledge.mark_book_with_status(book, about, 0) end,
                function() scripts.misc.knowledge.mark_book_with_status(book, about, 0.5) end
            },
            {
                "oznacz jako nieprzeczytana",
                "oznacz jako w trakcie"
            }, true)
    elseif progress == 0.5 then
        cechoPopup("<yellow>" .. book,
            {
                function() scripts.misc.knowledge.mark_book_with_status(book, about, 0) end,
                function() scripts.misc.knowledge.mark_book_with_status(book, about, 1) end
            },
            {
                "oznacz jako nieprzeczytana",
                "oznacz jako przeczytana"
            }, true)
    else
        cechoPopup("<red>" .. book,
            {
                function() scripts.misc.knowledge.mark_book_with_status(book, about, 0.5) end,
                function() scripts.misc.knowledge.mark_book_with_status(book, about, 1) end
            },
            {
                "oznacz jako w trakcie",
                "oznacz jako przeczytana"
            }, true)
    end
    local second_half = string.rep(" ", 48 - #first_half - #book - 6)
    cecho("<grey>" .. second_half .. "|\n")
end

function scripts.misc.knowledge.mark_book_with_status(book, about, progress)
    local book_row = scripts.misc.knowledge:get_or_create_book_about(book, about, 0)
    book_row.progress = progress
    db:update(scripts.misc.knowledge.db.book_progress, book_row)
    local msg = "ok, ustawilem ksiazke '" .. book .. "' o '" .. about .. "' jako "
    if progress == 0 then
        msg = msg .. "nieprzeczytana"
    elseif progress == 0.5 then
        msg = msg .. "w trakcie"
    else
        msg = msg .. "przeczytana"
    end
    scripts:print_log(msg)
end

function scripts.misc.knowledge.init_book_triggers()
    scripts.misc.knowledge.book_to_about_to_progress = {}
    books_with_progress = db:fetch(scripts.misc.knowledge.db.book_progress,
        { db:eq(scripts.misc.knowledge.db.book_progress.character, scripts.character_name),
        })

    for _, trig_id in pairs(scripts.misc.knowledge.book_hint_trigger_ids) do
        killTrigger(trig_id)
    end

    for _, book_di in pairs(books_with_progress) do
        if not scripts.misc.knowledge.book_to_about_to_progress[book_di.book] then
            scripts.misc.knowledge.book_to_about_to_progress[book_di.book] = {}
        end
        scripts.misc.knowledge.book_to_about_to_progress[book_di.book][book_di.about] = book_di.progress
    end

    for book, book_di in pairs(misc.knowledge.raw_data.books) do
        if not scripts.misc.knowledge.book_to_about_to_progress[book] then
            scripts.misc.knowledge.book_to_about_to_progress[book] = {}
        end

        for _, category in pairs(book_di.categories) do
            if not scripts.misc.knowledge.book_to_about_to_progress[book][category] then
                scripts.misc.knowledge.book_to_about_to_progress[book][category] = 0
            end
        end
    end

    for _, book_di in pairs(misc.knowledge.raw_data.books) do
        -- display(book_di)
        local trig_id = tempRegexTrigger("(" .. book_di.biernik .. ")",
            function()
                scripts.misc.knowledge.process_book_trigger(matches[2], book_di)
            end)
        table.insert(scripts.misc.knowledge.book_hint_trigger_ids, trig_id)
    end
end

function scripts.misc.knowledge.process_book_trigger(text, book_di)
    local book_to_about_progress = scripts.misc.knowledge.book_to_about_to_progress[book_di.mianownik]
    selectString(text, 1)
    fg("CornflowerBlue")
    setUnderline(true)

    local popup_f_calls = {}
    local popup_f_hints = {}

    for category, about_progress in pairs(book_to_about_progress or {}) do
        table.insert(popup_f_calls,
            function()
                sendAll("otworz " .. book_di.biernik,
                    "zglebiaj wiedze o " ..
                    misc.knowledge.knowledge_category_mianownik_to_celownik[category] .. " z " .. book_di.dopelniacz)
            end)
        local hint = "czytaj o " .. misc.knowledge.knowledge_category_mianownik_to_celownik[category] .. " ("
        if progress == 0 then
            hint = hint .. "nieczytana"
        elseif progress == 0.5 then
            hint = hint .. "w trakcie"
        else
            hint = hint .. "przeczytana"
        end
        hint = hint .. ")"
        table.insert(popup_f_hints, hint)
    end


    if #popup_f_calls > 0 then
        setPopup("main", popup_f_calls, popup_f_hints)
    end
    resetFormat()
end
