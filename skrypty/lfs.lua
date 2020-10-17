function lfs.isdir(dir)
    local current = lfs.currentdir()
    local exists = lfs.chdir(dir)
    lfs.chdir(current)
    return exists
end