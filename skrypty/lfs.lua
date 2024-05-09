function lfs.isdir(dir)
    local current = lfs.currentdir()
    local exists = lfs.chdir(dir)
    lfs.chdir(current)
    return exists
end

function lfs.is_absolute_path(dir)
    if getOS() == "windows" then
        return string.sub(dir, 2, 2) == ":"
    end
    local first_char = string.sub(dir, 1,1)
    return first_char == "/" or first_char == "\\"
end

function lfs.list_files(dir)
    local files = {}
    for file in lfs.dir(dir) do
        if file ~= "." and file ~= ".." then
            table.insert(files, file)
        end
    end
    return files
end