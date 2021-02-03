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