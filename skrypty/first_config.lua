scripts.first_time_config = scripts.first_time_config or {}

function scripts.first_time_config:init()
    local firsTimeConfig = PageWindow:new("first_time_config", "Arkadia Skrypty - wstepna konfiguracja", false, false, "f")
    firsTimeConfig:addPage(scripts.first_time_config.intro)
    firsTimeConfig:open()
end

function scripts.first_time_config.intro(windowPage, index)
    cecho(windowPage.name, "Jest to twoje pierwsze uruchomienie skryptow, jezeli zechcesz przeprowadzimy Cie przez poczatkowa konfiguracje.")
    echo(windowPage.name, "\n\n\n")
    cecho(windowPage.name, "1. Tak, konfigurujemy!\n\n")
    cecho(windowPage.name, "2. Nie teraz, przy nastepnym uruchomieniu.\n\n")
    cecho(windowPage.name, "3. Nie i nie potrzebuje konifugracji\n\n")
end

scripts.first_time_config:init()
