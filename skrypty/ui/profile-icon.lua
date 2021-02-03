scripts.profile_icon = scripts.profile_icon or {
    url = "https://res.cloudinary.com/arkadia-skrypty/image/upload/l_text:Roboto_34:%s,co_rgb:000000,x_10,w_70/bo_1px_solid_black/v1590440599/arkadia-wide-black_gsb7hz.png"
}
function scripts.profile_icon:set_icon(name)
    local url = self.url:format(name:upper())
    self.icon_file = string.format("%s/profile-icon-%s-%s.png", getMudletHomeDir(), name:lower(), os.time())
    self.handler = scripts.event_register:force_register_event_handler("profile-icon", "sysDownloadDone", function(_, filename) self:handle_icon_download(_, filename) end)
    downloadFile(self.icon_file, url)
end

function scripts.profile_icon:handle_icon_download(_, filename)
    if filename ~= self.icon_file then
        return true
    end
    scripts.event_register:kill_event_handler(self.handler)
    scripts:print_log("Ustawiono ikone profilu")
    setProfileIcon(self.icon_file)
    os.remove(self.icon_file)
end

function alias_func_set_profile_icon()
    scripts.profile_icon:set_icon(matches[2])
end
