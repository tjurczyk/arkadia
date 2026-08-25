scripts.recovery = scripts.recovery or {}

local recovery_script_name = "Arkadia Scripts Recovery"
local installer_file = getMudletHomeDir() .. "/arkadia/installer.lua"
local recovery_script_content_file = getMudletHomeDir() .. "/arkadia/skrypty/utils/installer/recovery_script_content.lua"

local function read_file(path)
    local file = io.open(path, "r")
    if not file then
        return nil
    end
    local content = file:read("*a")
    file:close()
    return content
end

function scripts.recovery:ensure_recovery_script_existence()
    -- installer.lua sits in the zip the installer unpacks, but is kept out of the
    -- .mpackage - there installing and updating is the package manager's job and
    -- there is nothing for us to recover from. A recovery script left behind by an
    -- earlier installer-route install would cry wolf on every load (the package is
    -- named "arkadia", not "Arkadia"), so empty it out rather than leave it armed.
    local installer_code = read_file(installer_file)
    if not installer_code then
        if exists(recovery_script_name, "script") ~= 0 then
            setScript(recovery_script_name, "")
            disableScript(recovery_script_name)
            saveProfile()
        end
        return
    end

    local recovery_code = read_file(recovery_script_content_file)
    if not recovery_code then
        return
    end

    local script_content = string.format('local recovery_code=[[%s]]\n\n%s', installer_code, recovery_code)

    if exists(recovery_script_name, "script") == 0 then
        permScript(recovery_script_name, "", script_content)
        enableScript(recovery_script_name)
    else
        setScript(recovery_script_name, script_content)
    end
    saveProfile()
end

scripts.recovery:ensure_recovery_script_existence()
