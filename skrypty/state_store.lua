---
--- Easy way to persist some date between sessions
---
scripts.state_store = scripts.state_store or {
    file = getMudletHomeDir() .. "/state_store.json",
    data = {},
}

function scripts.state_store:save()
    local file = io.open(self.file, "w")
    file:write(yajl.to_string(self.data))
    file:close()
end

function scripts.state_store:load()
    local file = io.open(self.file, "r")
    if file then
        local contents = file:read("*a")
        self.data = yajl.to_value(contents)
        file:close()
    end
end


--- Set value under key and save
---
--- Args:
--- * `key`: key used to store, retrieve and delete data
--- * `value`: any value
function scripts.state_store:set(key, value)
    self.data[key] = value
    self:save()
end

---
--- Remove data stored under key
---
--- Args:
--- * `key`: key used to store, retrieve and delete data
---
function scripts.state_store:delete(key)
    self:set(key, nil)
end

--- Get value stored under key
---
--- Args:
--- * `key`: key used to store, retrieve and delete data
---
function scripts.state_store:get(key)
    return self.data[key]
end

scripts.state_store:load()

