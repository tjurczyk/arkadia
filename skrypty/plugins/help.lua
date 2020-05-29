scripts.plugin_support = scripts.plugin_support or {}

function scripts.plugin_support:print_help()
    cecho("+----------------------- <green>Arkadia skrypty, ver " .. string.sub(scripts.ver .. " ", 0, 5) .. "<grey> -----------------------+\n")
    cecho("|                                                                          |\n")
    cecho("| Wsparcie dla pluginow                                                    |\n")
    cecho("|                                                                          |\n")
    cecho("| Zainstalowane pluginy:                                                   |\n")
    for _, plugin_name in pairs(scripts.plugins) do
        cecho("| - <green>" .. string.sub(plugin_name .. "                                                                       ", 0, 70) .. "<gray> |\n")
    end
    cecho("|                                                                          |\n")
    cecho("|                                                                          |\n")
    cecho("| <yellow>Dostepne KOMENDY:<grey>                                                        |\n")
    cecho("|                                                                          |\n")
    cecho("| <light_slate_blue>/zainstaluj_plugin [url]<grey> - Instaluje paczke z pluginem z danego adresu<grey>.  |\n")
    cecho("| <light_slate_blue>/odinstaluj_plugin [nazwa]<grey> - Odinstalowuje paczke o danej nazwie<grey>.        |\n")
    cecho("|                                                                          |\n")
    cecho("+--------------------------------------------------------------------------+\n")
end

function alias_func_plugin_help()
    scripts.plugin_support:print_help()
end

