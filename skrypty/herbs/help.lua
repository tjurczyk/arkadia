function herbs:print_help()
    cecho("+------------------------ <green>Arkadia skrypty, ver " .. string.sub(scripts.ver .. "   ", 0, 4) .. "<grey> -------------------------+\n")
    cecho("|                                                                            |\n")
    cecho("| <yellow>Aby zobaczyc pomoc ")
    --cechoLink("<deep_sky_blue>kliknij tutaj", "http://arkadia.kamerdyner.net/ziola.html", "http://arkadia.kamerdyner.net/ziola.html", true)
    scripts:print_url("<deep_sky_blue>kliknij tutaj", "herbs:show_help_url", "klik")
    cecho("                                           |\n")
    cecho("|                                                                            |\n")
    cecho("+----------------------------------------------------------------------------+\n")
end

function herbs:show_help_url()
    openUrl("http://arkadia.kamerdyner.net/ziola.html")
end


