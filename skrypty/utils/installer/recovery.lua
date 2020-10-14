scripts.recovery = scripts.recovery or {}

local recovery_script_name = "Arkadia Scripts Recovery"
local installer_file = getMudletHomeDir() .. "/arkadia/installer.lua"
local recovery_script_content_file = getMudletHomeDir() .. "/arkadia/skrypty/utils/installer/recovery_script_content.lua"

function scripts.recovery:ensure_recovery_script_existence()
    local rsc_file = io.open(recovery_script_content_file, "r")
    local recovery_code = rsc_file:read("*a")
    rsc_file:close()

    local i_file = io.open(installer_file)
    local installer_var = i_file:read("*a")
    i_file:close()

    local script_content = string.format('local recovery_code=[[%s]]\n\n%s', installer_var, recovery_code)

    if exists(recovery_script_name, "script") == 0 then
        permScript(recovery_script_name, "", script_content)
        enableScript(recovery_script_name)
    else
        setScript(recovery_script_name, script_content)
    end
    saveProfile()
end

scripts.recovery:ensure_recovery_script_existence()
