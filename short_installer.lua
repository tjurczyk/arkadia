local installer_url = "https://github.com/tjurczyk/arkadia/releases/latest/download/ArkadiaScriptsInstaller.xml"
local file = getMudletHomeDir() .. "ArkadiaScriptsInstaller.xml"
downloadFile(file, installer_url)
cecho("\n<CadetBlue>(skrypty)<tomato>: Rozpoczynam instalacje skryptow\n")
registerAnonymousEventHandler("sysDownloadDone", function(_, filename)
    if filename ~= file then
        return true
    end
    installPackage(file)
end, true)
clearCmdLine()

-- lua local a="https://github.com/tjurczyk/arkadia/releases/latest/download/ArkadiaScriptsInstaller.xml"local b=getMudletHomeDir().."ArkadiaScriptsInstaller.xml"downloadFile(b,a)cecho("\n<CadetBlue>(skrypty)<tomato>: Rozpoczynam instalacje skryptow\n")registerAnonymousEventHandler("sysDownloadDone",function(c,d)if d~=b then return true end;installPackage(b)end,true)clearCmdLine()