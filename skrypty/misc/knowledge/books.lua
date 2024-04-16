scripts.misc = scripts.misc or {}
scripts.misc.knowledge = scripts.misc.knowledge or
    { ["db"] = nil, ["book_declension_map"] = {}, ["category_to_books"] = {} }

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
end

function scripts.misc.knowledge:start_reading_book(book, about)
    scripts.misc.knowledge["current_row"] = nil
    local book_proper = scripts.misc.knowledge.book_declension_map[book]
    local about_proper = misc.knowledge.declension_category[about]

    if not book_proper then
        scripts:print_log("Nierozpoznana ksiega: " .. book .. ", zglos na discordzie")
        return
    end

    local book_about_fetch = db:fetch(scripts.misc.knowledge.db.book_progress,
        { db:eq(scripts.misc.knowledge.db.book_progress.character, scripts.character_name),
            db:eq(scripts.misc.knowledge.db.book_progress.book, book_proper),
            db:eq(scripts.misc.knowledge.db.book_progress.about, about_proper) })

    if #book_about_fetch == 0 then
        db:add(scripts.misc.knowledge.db.book_progress,
            {
                character = scripts.character_name,
                book = book_proper,
                about = about_proper,
                progress = 0.5
            })
        book_about_fetch = db:fetch(scripts.misc.knowledge.db.book_progress,
            { db:eq(scripts.misc.knowledge.db.book_progress.character, scripts.character_name),
                db:eq(scripts.misc.knowledge.db.book_progress.book, book_proper),
                db:eq(scripts.misc.knowledge.db.book_progress.about, about_proper) })[1]
    else
        book_about_fetch = book_about_fetch[1]
    end

    scripts.misc.knowledge["current_row"] = book_about_fetch
end

function scripts.misc.knowledge:cant_get_more_from_book()
    if scripts.misc.knowledge.current_row == nil then
        return
    end
    scripts.misc.knowledge.current_row.progress = 1
    db:update(scripts.misc.knowledge.db.book_progress, scripts.misc.knowledge.current_row)
end

function scripts.misc.knowledge:stop_reading_book()
    if scripts.misc.knowledge.current_row == nil then
        return
    end
    scripts.misc.knowledge.current_row = nil
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

        table.insert(books_per_category[row.about],
            { ["book"] = row.book, ["progress"] = row.progress })
        books_started_reading[row.book] = true
    end

    for _, category in pairs(misc.knowledge.categories) do
        if books_per_category[category] == nil then
            books_per_category[category] = {}
        end
    end

    if full == true then
        for category, books in pairs(scripts.misc.knowledge.category_to_books) do
            for book, _ in pairs(books) do
                if books_started_reading[book] == nil then
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

            for _, book_di in pairs(books_per_category[category]) do
                local book_str = ""
                first_half = string.rep(" ", 21 - #book_di.book / 2)
                book_str = first_half .. "COLOR1" .. book_di.book .. "COLOR2"
                second_half = string.rep(" ", 42 - #book_str + 12)
                book_str = book_str .. second_half
                if book_di.progress == 1 then
                    book_str = book_str:gsub("COLOR1", "<ansiLightGreen>")
                elseif book_di.progress == 0.5 then
                    book_str = book_str:gsub("COLOR1", "<yellow>")
                else
                    book_str = book_str:gsub("COLOR1", "<red>")
                end
                book_str = book_str:gsub("COLOR2", "<grey>")
                cecho(" |" .. book_str .. "|\n")
            end
            cecho(" +------------------------------------------+\n")
        end
    end
end
