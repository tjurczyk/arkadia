scripts.misc = scripts.misc or {}
scripts.misc.knowledge = scripts.misc.knowledge or { ["db"] = nil, ["book_declension_map"] = {} }

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

function scripts.misc.knowledge:show_book_stats()
    local books_read = db:fetch(scripts.misc.knowledge.db.book_progress,
        { db:eq(scripts.misc.knowledge.db.book_progress.character, scripts.character_name) })
    -- display(books_read)

    local books_per_category = {}
    for _, row in pairs(books_read) do
        if books_per_category[row.about] == nil then
            books_per_category[row.about] = {}
        end

        table.insert(books_per_category[row.about],
            { ["book"] = row.book, ["progress"] = row.progress })
    end

    display(books_per_category)
    for category, books in pairs(books_per_category) do
        cecho("  ++ <light_slate_blue>" .. category .. "<grey>++\n")
        for _, book_di in pairs(books) do
            if book_di.progress == 1 then
                cecho(" <ansiLightGreen>+ " .. book_di.book .. "\n")
            else
                cecho(" <gold>- " .. book_di.book .. "\n")
            end
        end
        cecho("\n")
    end
end
