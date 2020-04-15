function db:add(sheet, ...)
    local db_name = sheet._db_name
    local s_name = sheet._sht_name
    assert(s_name, "First argument to db:add must be a proper Sheet object.")

    local conn = db.__conn[db_name]
    local sql_insert = "INSERT OR %s INTO %s %s VALUES %s"

    for _, t in ipairs({ ... }) do
        if t._row_id then
            -- You are not permitted to change a _row_id
            t._row_id = nil
        end

        local sql = sql_insert:format(db.__schema[db_name][s_name].options._violations, s_name, db:_sql_fields(t), db:_sql_values(t))
        db:echo_sql(sql)

        local result, msg = conn:execute(sql)
        if not result then return nil, msg end
    end
    if db.__autocommit[db_name] then
        conn:commit()
    end
    return true
end

function db:update(sheet, tbl)
    assert(tbl._row_id, "Can only update a table with a _row_id")
    assert(not table.is_empty(tbl), "An empty table was passed to db:update")

    local db_name = sheet._db_name
    local s_name = sheet._sht_name

    local conn = db.__conn[db_name]

    local sql_chunks = { "UPDATE OR", db.__schema[db_name][s_name].options._violations, s_name, "SET" }

    local set_chunks = {}
    local set_block = [["%s" = %s]]

    for k, v in pairs(db.__schema[db_name][s_name]['columns']) do
        if tbl[k] then
            local field = sheet[k]
            set_chunks[#set_chunks + 1] = set_block:format(k, db:_coerce(field, tbl[k]))
        end
    end

    sql_chunks[#sql_chunks + 1] = table.concat(set_chunks, ",")
    sql_chunks[#sql_chunks + 1] = "WHERE _row_id = " .. tbl._row_id

    local sql = table.concat(sql_chunks, " ")
    db:echo_sql(sql)
    assert(conn:execute(sql))
    if db.__autocommit[db_name] then
        conn:commit()
    end

    return true
end

function db:delete(sheet, query)
    local db_name = sheet._db_name
    local s_name = sheet._sht_name

    local conn = db.__conn[db_name]

    assert(query, "must pass a query argument to db:delete()")
    if type(query) == "number" then
        query = "_row_id = " .. tostring(query)
    elseif type(query) == "table" then
        assert(query._row_id, "Passed a non-result table to db:delete, need a _row_id field to continue.")
        query = "_row_id = " .. tostring(query._row_id)
    end

    local sql = "DELETE FROM " .. s_name

    if query ~= true then
        sql = sql .. " WHERE " .. query
    end

    db:echo_sql(sql)
    assert(conn:execute(sql))
    if db.__autocommit[db_name] then
        conn:commit()
    end
    return true
end

function db:_coerce_sheet(sheet, tbl)
    if tbl then
        tbl._row_id = tonumber(tbl._row_id)

        for k, v in pairs(tbl) do
            if k ~= "_row_id" then
                local field = sheet[k]
                if field.type == "number" then
                    tbl[k] = tonumber(tbl[k]) or tbl[k]
                elseif field.type == "datetime" then
                    if tonumber(tbl[k]) then
                        tbl[k] = db:Timestamp(tonumber(tbl[k]), nil, true)
                    else
                        tbl[k] = db:Timestamp(datetime:parse(tbl[k], nil, true))
                    end
                end
            end
        end
        return tbl
    end
end

