function scripts.people.mail:check_table(name)
    if not name then
        return nil
    end

    local lowered_name = string.lower(name)

    local results = db:fetch_sql(scripts.people.db.people, "select * from people WHERE title GLOB '*".. name .."*'")

    if amap and table.size(results) == 1 and results[1]["room_id"] ~= -1 then
        -- it has a location in the db, color with green
        if selectString(name, 1) > -1 then
            fg("green")
            resetFormat()
        end
        return results[1]["room_id"]
    elseif table.size(results) > 1 then
        if selectString(name, 1) > -1 then
            fg("orange")
            resetFormat()
        end
    elseif scripts.people.mail.known_people[lowered_name] then
        -- we have a hint, so color with yellow and add the line with the description
        local name_padded = scripts.people.mail.known_people[lowered_name] .. "                                                                     "
        if selectString(name, 1) > -1 then
            fg("yellow")
            resetFormat()
        end
        cecho("\n |      <yellow>" .. string.sub(name_padded, 0, 70) .. "<grey>|")
    end
end

function scripts.people.mail:check_package_person(name)
    local lowered_name = string.lower(name)
    local color
   
    if string.sub(lowered_name, #lowered_name) == " " then
        -- if it has a space at the end, get rid of it
        lowered_name = string.sub(lowered_name, 0, #lowered_name - 1)
    end

    local results = db:fetch(scripts.people.db.people, db:like(scripts.people.db.people.title, "%" .. lowered_name .. "%"))
    local is_single = table.size(results) == 1
    local room =  is_single and results[1]["room_id"] or -1
    if not is_single then
        local assistant_match, multiple = scripts.packages:get_from_db(lowered_name)
        if assistant_match and not multiple then
            room = assistant_match.room_id
            is_single = true
            color = "spring_green"
        end
    end

    if amap and room ~= -1 then
        if selectString(name, 1) > -1 then
            fg(color or "green")
            resetFormat()
        end
        if scripts.people.mail.show_automatically then
            amap.path_display:start(room)
        else
            scripts:print_url("\n<orange>Kilknij tutaj, zeby pokazac sciezke.", function() amap.path_display:start(room) end, "Prowadz do " .. room)
        end
        return true
    end

    return nil
end

scripts.people.mail["known_people"] =
{
    ["henry schmidt"] = "Kartograf",
    ["albrecht duerer"] = "Trener walki w Szkole Gladiatorow",
    ["artur aberdin"] = "Gospoda w Szkole Gladiatorow",
    ["berta leibentropp"] = "Zamtuz 'Czerwony Sandalek'",
    ["deluvian"] = "Mroczny elf w wiezy",
    ["ernst hoffer"] = "Wlasciciel Domu Aukcyjnego",
    ["etzel brackmann"] = "Ratusz przy placu, na gorze",
    ["franz verkaufer"] = "Sklep z ekwipunkiem",
    ["fryderik glossenbauer"] = "Sklep z broniami",
    ["ghorbar"] = "Trener walki w Szkole Gladiatorow",
    ["gorian friest"] = "Emerytowany oficer wojsk Imperium, trener zaslaniania, okolice karczmy startowej",
    ["hafas muerling"] = "Plackarnia",
    ["hanes hailkraut"] = "Zielarz",
    ["herman zeglarz"] = "Karczma na przeciwko burdelu",
    ["hurlin"] = "Zeglarz w Karczmie Rzezniczej",
    ["joachim eisenberg"] = "Sklep ze zbrojami",
    ["joanna aberdin"] = "Gospoda w Szkole Gladiatorow",
    ["khurn"] = "Kowal",
    ["ludwig"] = "Gobiarz",
    ["moro dwral"] = "Moro Dwral, Mistrz Kusnierski, krasnolud.",
    ["olaf hubner"] = "Zlotnik",
    ["olaff meier"] = "Garbarz",
    ["ottho keinbrot"] = "Piekarnia",
    ["raul schied"] = "Karczma startowa",
    ["reinhard fleischer"] = "Rzeznik",
    ["rolph ederson"] = "Glowny Kaplan Swiatyni Vereny",
    ["vaclav gourm"] = "Pietro karczmy startowej",
    ["wielebny johann grau"] = "Swiatynia Sigmara",
    ["akun"] = "Kowal",
    ["belgor steinbrecher"] = "Karczma 'Pod swiszczacym Toporem'",
    ["dregin brotmacher"] = "Piekarnia",
    ["franz eisen"] = "Burmistrz",
    ["harnad schmirz"] = "Pomocnik Mistrza Kowalskiego",
    ["helmut koch"] = "Karczma 'Pod Kotwica'",
    ["johann"] = "Poczty",
    ["lohtar schmirz"] = "Starszy Pomocnik Mistrza Kowalskiego ",
    ["mehlor baadsten"] = "Karczma 'Pod swiszczacym Toporem'",
    ["randal schmirz"] = "Mistrz Kowalski",
    ["robro thravar"] = "Karczma 'Pod swiszczacym Toporem'",
    ["stefan"] = "Zielarz",
    ["terden hanseld"] = "Karczma 'Pod swiszczacym Toporem'",
    ["therdo thravar"] = "Sklep, NW",
    ["wolfgang bechter"] = "Sklep, SW kolo banku",
    ["zentrim hanseld"] = "Karczma 'Pod swiszczacym Toporem'",
    ["andre saufer"] = "Browar",
    ["armand boulangier"] = "Piekarnia",
    ["benito sangiovesi"] = "Restaurator, Karczma po poludniowej stronie mostu",
    ["bruno rottel"] = "Kapitan Garnizonu Wojsk Imperialnych, patrol",
    ["claudia eberhauer"] = "Zielarka",
    ["erl verder"] = "Karczma przy porcie",
    ["guido scacci"] = "Gospoda 'Pod Czarnym Orlem'",
    ["hals rotter"] = "Adiutant Kapitana, patrol",
    ["hans bernauer"] = "Sklep z przyprawami",
    ["helmut diesedorff"] = "Sklep",
    ["johanes treumann"] = "Kowal",
    ["johannes silber"] = "Gospoda 'Pod Czarnym Orlem'",
    ["kristoffer von risenbohn"] = "Karczma w Weilerbergu ",
    ["luleck"] = "Czeladnik",
    ["nikolaus schmidt"] = "Ciesla",
    ["thomas schutz"] = "Operator Mostu Zwodzonego",
    ["asav"] = "Browar",
    ["euzebiusz"] = "Rybak, NW",
    ["adam fischhaendler"] = "Sprzedawca Ryb",
    ["athelstan shergison"] = "Szeryf",
    ["bandobras proudfoot"] = "swiatynia",
    ["davi lebenstein furryfoot"] = "swiatynia",
    ["dropho rotherwood"] = "Smakosz w Gospodzie 'Pod Wrzesniowym Piwem'",
    ["elmer"] = "Golebiarz",
    ["friederich furryfoot"] = "Straznik przy Zgromadzeniu Halflingow ",
    ["ilon"] = "Polelf w Gospodzie 'Pod Wrzesniowym Piwem'",
    ["johan kornwalz"] = "Sklep",
    ["lavinia livett"] = "swiatynia",
    ["mortimer blatterburn"] = "Wlasciciel Gospody Pod Wrzesniowym Piwem'",
    ["tolman oliveheart"] = "Sklep z przyprawami",
    ["vermund shergison"] = "swiatynia",
    ["vernhold"] = "Kowal",
    ["conmar"] = "Tkacz",
    ["dorthieliriel"] = "Zajazd 'Pod Debami'",
    ["elonil"] = "Sklep",
    ["erinisar"] = "Nauczyciel zawodu Tropiciela",
    ["finaedril"] = "Kowal",
    ["imerien"] = "Zielarz",
    ["natiel"] = "Golebiarz",
    ["tathmor"] = "Karczma",
    ["airalion iludeal"] = "Golebiarz",
    ["alaric  vaillancourt"] = "Kaplan zakonu Myrmidii",
    ["angelle meunier"] = "Mlynarzowna",
    ["claire meunier"] = "Mlynarzowna",
    ["engelbert meunier"] = "Mlynarz",
    ["florent confiseur"] = "Cukiernik",
    ["hercule vignon"] = "Winiarnia",
    ["lucie meunier"] = "Mlynarzowa",
    ["philip marchand"] = "Sklep",
    ["thibault gagnon"] = "Wojt",
    ["aribert d'aquitaine"] = "Karczma 'Pelen kielich'",
    ["armand brasseur"] = "Nauczyciel walki w szyku",
    ["aude"] = "Kaplanka w swiatyni Pani Jeziora",
    ["aymar varennes"] = "Dowodca Gwardii Ksiazecej",
    ["bonard kreis"] = "Naczelnik Wiezienia",
    ["brigitte le courageux"] = "Ksiezna Quenelles",
    ["chouchoute aimable"] = "Piekarnia",
    ["corinne rivette"] = "Kobieta",
    ["euvrard trintignaut"] = "Mezczyzna",
    ["francois derateu"] = "Piekarnia",
    ["gaston rosay"] = "Kowal",
    ["gautier boulanger"] = "Cukiernia",
    ["godfrey le courageux"] = "Diuk d'Quenelles",
    ["guy tussand"] = "Sklep",
    ["harwig de verco"] = "Mistrz Kupiectwa, Nauczyciel znajomosci jezykow",
    ["jean thevenet"] = "Mezczyzna",
    ["laurent noiret"] = "Winiarnia",
    ["maurice de gisoreux"] = "Sekretarz w ratuszu",
    ["neville de montalban"] = "Sklep",
    ["paul le vigan"] = "Mezczyzna",
    ["pernette"] = "Byla opiekunka szpitala",
    ["pierrick faure"] = "Nadworny kucharz",
    ["raoul darget"] = "Dowodca Strazy Palacowej",
    ["savinien moreau"] = "lowca Czarownic",
    ["simone"] = "Opiekunka szpitala",
    ["suzon dussollier"] = "Kobieta",
    ["vorster main"] = "Podroznik i Mysliwy, Nauczyciel tropienia i lowiectwa",
    ["bernardo de villeneux"] = "Mezczyzna",
    ["marcus licherties"] = "Gospoda 'Pod bobrzym ogonem'",
    ["pierre tisseneux"] = "Kowal",
    ["roseanna radnigues"] = "Zielarka",
    ["virginia gildanoisse"] = "Kobieta",
    ["yvette"] = "Kaplanka Shallyi",
    ["ergart"] = "Wojt",
    ["kraad"] = "Sklep",
    ["kzarh"] = "Tawerna",
    ["tarrin"] = "Poczta",
    ["zagda"] = "Golebiarz",
    ["bertin chaquilett"] = "Mer",
    ["charles tribiane"] = "Tawerna",
    ["michel detilleux"] = "Bretonski Wedrowiec",
    ["philippe"] = "Sklep",
    ["rene aurac"] = "Piekarz",
    ["rotruda alinion"] = "Zielarka",
    ["borin"] = "Zlotnik",
    ["khadin khaman"] = "Przywodca",
    ["kharrn"] = "Kowal",
    ["norgrim kareth"] = "Tawerna",
    ["rolf gunderbauer"] = "Kupiec z mulem",
    ["barthen hortz"] = "Sklep",
    ["degh kadrag"] = "Kuznia broni",
    ["hegd kerdthrall"] = "Gospoda 'Pekata Barylka'",
    ["runwar krigarson"] = "Skup skor",
    ["saragh madrak"] = "Karczma 'Kamienny Bar'",
    ["ungrim zelazna piesc"] = "Wladca Karak Kadrin",
    ["werk madren"] = "Kuznia zbroi",
    ["zarg hardelson"] = "Jubiler",
    ["andolf"] = "Sekretarz Gildii Kupieckiej",
    ["caspar von reinitz"] = "Dowodca Gwardii Celnej",
    ["gumr"] = "Kowal",
    ["joachim kriger"] = "Klub 'Zloty Pstrag'",
    ["karls teugen"] = "Ratusz",
    ["luter"] = "Sekretarz Gildii Zlotniczej",
    ["manni"] = "Karczma 'Kraniec Podrozy'",
    ["marsso"] = "Sklep",
    ["nimrod"] = "Sekretarz Gildii Medykow",
    ["virien"] = "Kaplan Sigmara, swiatynia",
    ["zelig von bogenhafen"] = "Wysoki Kaplan Myrmidii, Fort Czarnego Ognia",
    ["boreg khrazaksson"] = "Kuznia",
    ["gianni di cornutti"] = "Celnik Miejski",
    ["giuliamo 'odor' oderetti"] = "Sierzant Gwardii, na placu przy bramie",
    ["mario"] = "Tawerna 'U Grubego Mario'",
    ["melinda florenzo"] = "Dziewczynka na poludniu miasta",
    ["michael tommasino"] = "Burmistrz",
    ["tarinolli scherzoni"] = "Piekarnia",
    ["toni mandello"] = "Restauracja 'Smak Madrosci'",
    ["torquato di assemani"] = "Patroluje miasto",
    ["antonio gantucci"] = "Sklad celny, kolo portu",
    ["giacomo giandolimento"] = "Sklep z  wyrobami ekskluzywnymi",
    ["padre giancardo"] = "Wysoki Kaplan Mananna, Katedra",
    ["rovigo armelini"] = "Platnerz",
    ["sancia enriquez"] = "Kawiarnia",
    ["vito cattanei"] = "Restauracja",
    ["edovardo giovanno"] = "Sklep",
    ["garviazzo petrocio"] = "Kusnierz",
    ["ojciec mortitius"] = "Opiekun Kaplicy Morra, na poludnie od placu",
    ["paolo vinnarizio"] = "Kowal",
    ["valenzo di tiolonne"] = "Sklep",
    ["adela di tiolenne"] = "Zielarka",
    ["drytus"] = "Szkutnik",
    ["georgio"] = "Kowal",
    ["roberto"] = "Mezczyzna",
    ["seniore lorencjo"] = "Wojt",
    ["bencivenni di tella"] = "Platnerz",
    ["domenico di simoni"] = "Mezczyzna na ulicy",
    ["georgio andretti"] = "Karczma kupiecka",
    ["giuseppe di simoni"] = "Mezczyzna na ulicy",
    ["ignatio"] = "Garncarz",
    ["lucciano"] = "Sprzedawca skor na placu przy poczcie",
    ["luccio cantabresi"] = "Bednarz",
    ["luigi di simoni"] = "Mezczyzna na ulicy",
    ["mercucio ranivaldi"] = "Sprzedawca, Kaplica Mercopia",
    ["mocenigo"] = "Podrzedna tawerna w porcie",
    ["nanetta rosetti"] = "Gospoda 'Bianco Cervo'",
    ["patrizio"] = "Kaletnik",
    ["ricco"] = "Kapitan statku Perla dell'Oceano, port",
    ["susa"] = "Pomocniczka kaletnika   ",
    ["umberto travaglione"] = "Gildia kupiecka",
    ["vieri sarietti"] = "Jubiler",
    ["vincilago malacresta"] = "Kaplan, Kaplica Mercopia",
    ["benitto blanca"] = "Sklep z bronia",
    ["lanucci porte"] = "Jubiler",
    ["meloar sanchez"] = "Sklep powrozniczy",
    ["rivanon"] = "Mezczyzna",
    ["vega tuzzi"] = "Sklep z roznosciami",
    ["zetegen di toscania"] = "Sklep ze zbrojami",
    ["alain l'herbier"] = "Gospoda w Marguilles",
    ["alain"] = "Wytworca wedek w Cixous",
    ["alberto"] = "Sklep w Alimento",
    ["andreus"] = "Wojownik Kislevicki w kislevickim forcie",
    ["argul"] = "Szef ghouli przy trakcie Nuln-Blekitna Wstega",
    ["arsizio sogriano"] = "Szef bandytow na traktach w Imperium",
    ["artur"] = "Wojt Naszej Wsi",
    ["bardul"] = "Krasnolud, Zamek Drachenfels",
    ["buldo"] = "Krol snotlingow kolo Kreutzhofen",
    ["daniell"] = "Golebiarz w Vingtiennes",
    ["dharid haragranson"] = "Karczma 'Pod Zlamanym Oskardem', Osada gornicza",
    ["duccio tachiacci"] = "zebrak, na poludnie od Urbimo",
    ["erwin kroetz"] = "Czlowiek, Zamek Drachenfels",
    ["fabian le puissant"] = "Paladyn, Zamek Drachenfels",
    ["filippo buonarro"] = "Barman w Kasynie na zachod od Campogrotty",
    ["galvano aldighieri"] = "Kowal w kopalni w Gorach Alimento",
    ["ghark"] = "Ogr z mulem przy bagnach",
    ["gustaw kahner"] = "Wojt Tadrig",
    ["haggard"] = "Kowal, Zakon Sigmara",
    ["hans heineberg"] = "Zajazd 'Pod Piegowata Elfka', Bretonia",
    ["hans muller"] = "Sklep, Zakon Sigmara",
    ["harmut kenntemich"] = "Zajazd 'Srebrny Grot', kolo Ubersreiku",
    ["harroth"] = "Czlowiek, jaskinia w Gorach Szarych na poludnie od traktu",
    ["jacques chivienne"] = "Mer Vingtiennes",
    ["jacques"] = "Wojt Cixous",
    ["jean montpessac"] = "Karczmarz z gospody w Vingtiennes",
    ["jorn von strachenberg"] = "Czlowiek, na trakcie kolo Jouinard",
    ["joscelin colpeyn"] = "Gospoda 'Pod krowim ogonem', Marceaux Descloux",
    ["klaus moltke"] = "Arcyhierofant Lesnego Kregu, las kolo Kreutzhofen",
    ["kregan dhailanthan"] = "Sklep, Osada gornicza",
    ["krepus mocarny"] = "Szef orkow w obozie w Krainie Zgromadzenia",
    ["kurt bierkeller"] = "Tawerna Flisacka w Alimento",
    ["leonard ronet"] = "Wojt Marguilles",
    ["luca albertini"] = "Handlarz Roznosciami, na traktach w Tilei",
    ["marcovaldo di benutto"] = "Wlasciciel kopalni w Gorach Alimento",
    ["merrin albertelle"] = "Dom na wschod od Viadazy",
    ["meryneusz di meducci"] = "Nadzorca skupu w kopalni w Gorach Alimento",
    ["myphillus lynihasad"] = "Gnom w wiezy golemow",
    ["nadia"] = "Karczma 'Katsum' w kislevickim forcie",
    ["reinaud"] = "Rybak, gospoda w Cixous",
    ["rosalinda"] = "Gospoda w Cixous",
    ["slavic"] = "Kowal w kislevickim forcie",
    ["sordad"] = "Platnerz, Zakon Sigmara",
    ["tobin schulbach"] = "Wojt Wioski Ciemny Staw",
    ["urmf"] = "Orczyca, Zamek Drachenfels",
    ["ancelmus du tilleul"] = "Nuln - Kraina Zgromadzenia - Blekitna Wstega -",
    ["annibale"] = "Novigrad - Urbimo",
    ["asa thjazi"] = "Ard Skellige - Nilfgaard",
    ["batista"] = "Baccala - Mekan",
    ["bjorn dahlson"] = "Novigrad - Ard Skellige - Faroe ",
    ["cern"] = "Wyspa Utraconych - Urbimo",
    ["charonda"] = "Oxenfurt - Baccala - Piana",
    ["flavius"] = "Novigrad - Daevon",
    ["gervais desmouceaux"] = "Marguilles - Quenelles",
    ["giangaleazzo toscanini"] = "Barka kolo Toskanii     ",
    ["gmeath"] = "Prom na polnoc od Bialego Mostu",
    ["gvidon"] = "Novigrad - Wyspa Utraconych",
    ["hallgerda"] = "Novigrad - Ard Skellige",
    ["jacob visenberg"] = "Daevon - Biala Wstega",
    ["louis fontiere"] = "Prom na poludnie od Vingtiennes ",
    ["luiggi tospano"] = "Kreutzhofen - Alimento",
    ["malacius"] = "Oxenfurt - Daevon",
    ["mallcolm froidin"] = "Biala Wstega - Karak Varn",
    ["olaf an caedin"] = "Ard Skellige - Hindarsfjall",
    ["pluskolec"] = "Novigrad - Oxenfurt - Bialy Most",
    ["rygwit skroons"] = "Ard Skellige - Kaer Hemdall",
    ["strag"] = "Oxenfurt - Grabowa Buchta",
    ["adalbert leclerc"] = "Golebiarz",
    ["anton"] = "Soltys Ostrorogu",
    ["auril de raites"] = "Swiatynia Farnaga",
    ["belrand de estinus"] = "Posel Cesarstwa Nilfgaardu w kamienicy",
    ["biraldan"] = "Zielarz",
    ["bromius"] = "Sklep z przyprawami",
    ["dainty biberveldt"] = "Kupiec, alkierz tawerny 'Pod Grotem Wloczni'",
    ["drouhard teleri"] = "Starszy Gildii Kupieckiej, Gildia Kupcow",
    ["dudu biberveldt"] = "Kupiec, Gildia Kupcow",
    ["ferdinand hranz"] = "Sklep z uzbrojeniem, plac Reha",
    ["gerudirr visenbach"] = "Jubiler",
    ["gotth shverzt"] = "Sklep z bronia",
    ["hermina"] = "Sklep z ekwipunkiem",
    ["illiena aen tos"] = "Sklep z ubraniami",
    ["jander grot"] = "Rzeznik",
    ["kalwag"] = "Sierzant Oddzialow Chlopskich, Ostrorog",
    ["kaspian"] = "Hierarcha",
    ["lolekaneal"] = "Sklad win",
    ["magda"] = "Kasyno przy targu",
    ["marios marco"] = "Garbarz",
    ["mirtan arlof"] = "Handlarz zniczami na targu",
    ["myrrhis"] = "Sklep",
    ["oktawian dorgeniac"] = "Kancelista w kamienicy",
    ["orson"] = "Dowodca Strazy Wiecznego Ognia",
    ["otom"] = "Gnomi sklep",
    ["prokuj"] = "Kowal",
    ["rainart ereviell"] = "Ratusz",
    ["ratan"] = "Przy ognisku",
    ["rien arianno"] = "Sklep z ubraniami",
    ["swed"] = "Latarnik",
    ["tenea innevoana"] = "Poetka na polanie",
    ["veladorn martae"] = "Wyzszy Kaplan Wiecznego Ognia",
    ["vimme vivaldi"] = "Bankier",
    ["vit mariani"] = "Sklep z bizuteria na targu",
    ["zykkis"] = "Sklep",
    ["loer"] = "Wioska mysliwska",
    ["adipatus"] = "Sklep na polnocnym-zachodzie",
    ["barbus kelley"] = "Profesor alchemii, Uniwersytet",
    ["daniger de barbek"] = "Profesor nauk wyzwolonych, Uniwersytet",
    ["dijkstra"] = "Palac na Uniwersytecie",
    ["esmeralda"] = "Ratusz, dworka burmistrza",
    ["feleyn"] = "Bard, Uniwersytet",
    ["feno veers"] = "Profesor biologii, Uniwersytet",
    ["firon"] = "Gospoda 'Pod Kucykiem' na podgrodziu",
    ["gaunez"] = "Rycerz z Kociepola, okolice burdelu",
    ["gerhard"] = "Kowal z podgrodzia",
    ["gregory myers"] = "Profesor historii naturalnej, Uniwersytet",
    ["jarrvel ilernhort"] = "Ratusz, urzednik",
    ["kivan flink"] = "Salon tatuazu",
    ["myhrman"] = "Znachor",
    ["notlip"] = "Herbaciarnia",
    ["obiczkin"] = "Ratusz, burmistrz ",
    ["ori reuven"] = "Palac na Uniwersytecie",
    ["platfonus sorbus"] = "Profesor filozofii, Uniwersytet",
    ["ragast deres"] = "Drobny Handlarz Zniczami",
    ["refael oris"] = "Wyzszy Kaplan Wiecznego Ognia, swiatynia",
    ["salithrandir"] = "Sklep z przyprawami",
    ["tarantiew"] = "Ratusz, skryba",
    ["tark likawor"] = "Profesor techniki, Uniwersytet",
    ["uranvinell"] = "Bard na statku do Daevon",
    ["vidius"] = "Bednarz z podgrodzia",
    ["villan ivando"] = "Winiarnia 'Biala Dama'",
    ["zedar"] = "Karczma 'Pod wesolym studentem'",
    ["zvavik"] = "Garncarz z podgrodzia",
    ["gnieslaw"] = "Soltys",
    ["gosso caraziorri"] = "Grabowa Buchta",
    ["milna beregen"] = "Piekarnia",
    ["rudolf"] = "Nauczyciel plywania",
    ["boholt canveit"] = "Karczma 'Pod zagnica'",
    ["cavelt z piany"] = "swiatynia",
    ["ceresa"] = "Kobieta",
    ["cirvia beker"] = "Tawerna 'W Brzuchu Krakena' na barce",
    ["nartist mayer"] = "Sprzedawca zniczy przed swiatynia",
    ["rengald nertin"] = "swiatynia",
    ["kabernik seimo"] = "Sklep",
    ["anabela"] = "Mlynareczka",
    ["galand"] = "Mlynarz",
    ["matheus ordo"] = "Golebiarz",
    ["nuliven bialy"] = "Karczma 'Mlynskie Kolo'",
    ["andzia"] = "Dziewczynka na podgrodziu",
    ["briggida butterfly"] = "Zamtuz",
    ["derfel de mestr"] = "Sklep ze zbrojami",
    ["dora vehtli"] = "Piekarnia",
    ["ernest krank"] = "Stolarz",
    ["errdil"] = "Oberza 'Pod Pierwszym Razem' ",
    ["evea"] = "ne w wiosce na ne od Tretogoru",
    ["fiohri greyhard"] = "Krawiec",
    ["grotl taah"] = "Zarzadca budowy, Karczma w przebudowie zaraz przy wejsciu na w",
    ["hart mkniewod"] = "Zlotnik",
    ["heim ingeer"] = "Bibliotekarz, Ratusz",
    ["hubert brol"] = "Kamieniarz",
    ["karit bibberveld"] = "Handlarz Zywnoscia",
    ["maciej"] = "Chata na podgrodziu",
    ["marta"] = "Chata na podgrodziu",
    ["massimo di cale"] = "Winiarnia 'Pod Stara Wierzba'",
    ["nari ridath"] = "Wrozka",
    ["neville z rodu dziezkich"] = "Burmistrz, Ratusz",
    ["orson fuldor"] = "Karczma 'Pijany D'jinn'",
    ["ridia varrhard z klanu althoog"] = "Z klanu Althoog, Kowal",
    ["ronni widtel"] = "Stragan z roznosciami",
    ["siliya"] = "Sklep z ubraniami",
    ["sonia grift"] = "Sklep z bronia",
    ["tali de rouch"] = "Herbaciarnia w ogrodach",
    ["vierna"] = "Kobieta na podworzu",
    ["witt wawrzynosek"] = "Zielarz",
    ["zawigr greenspot"] = "Sklep z ekwipunkiem",
    ["adart arsen"] = "Gospoda cechowa 'Zloty Sen'",
    ["alhanan zarba"] = "Sklep z roznosciami ",
    ["aliona"] = "Tawerna Rybacka",
    ["arhen"] = "Sklep ze zbrojami",
    ["arian de norest"] = "Nadworny czarodziej, Palac",
    ["belleth feainnewedd"] = "Perfumeria",
    ["berand wirtz"] = "Sprzedawca zniczy, przed swiatynia",
    ["berghol"] = "Pijak, Karczma 'Pod Lisem'",
    ["dirmar elier"] = "Gospoda cechowa 'Zloty Sen'",
    ["filbert"] = "Krawiec ",
    ["grohard leral"] = "Kaplan w swiatyni",
    ["ikon"] = "Garbarz",
    ["iriana"] = "Kowal",
    ["klaus heler"] = "Medyk",
    ["malik"] = "Kamieniarz",
    ["meledith"] = "Uzdrowicielka",
    ["mirakul"] = "Zielarz",
    ["moan"] = "Kobieta w domku na polnocnym-zachodzie miasta",
    ["nuke morg"] = "Karczma 'Pod Lisem'",
    ["oto foltest"] = "Krol Temerii, Palac",
    ["promaxus"] = "Jubiler",
    ["rumian"] = "Sprzedawca ekwipunku",
    ["rymi"] = "Rymarz",
    ["sargal"] = "Karczma 'Stary Narakort'",
    ["velerad"] = "Grododzierzca",
    ["venart z dorian"] = "Gospoda cechowa 'Zloty Sen'",
    ["zabek"] = "Szewc",
    ["zorgel"] = "Sklep z bronia",
    ["berson fardramer"] = "Kuznia w Fandall",
    ["bertok hriggson"] = "Ciesla obok poczty",
    ["maritta hofmeier"] = "Pomocnica piekarki",
    ["skerina kerrons"] = "Zielarka",
    ["rozalia tumlebelly"] = "Piekarka",
    ["brent bregson"] = "Gospoda 'Pod kilofem i oskardem'",
    ["woody gladdensbach"] = "Domek za ogrodem w Fandall",
    ["adan sindikat"] = "Kuznia w miescie gnomow",
    ["arga grindblad"] = "Z klanu Kher-Trak, Fryzjerka",
    ["brah heerwag"] = "Pomocnik kowala",
    ["brouver hoog"] = "Prawa Reka Starosty Mahakamu ",
    ["dab blindgard"] = "Sekretarz Starosty Mahakamu, Gildia",
    ["dramli vrin"] = "Z klanu Houg, Gildia Krasnoludow z Mahakamu",
    ["elev ator"] = "Obsluga windy, miasto gnomow",
    ["frina vivaldi"] = "Bank",
    ["galin hoog"] = "Starosta, Palac",
    ["gent ventronix"] = "Hala produkcyjna w miescie gnomow",
    ["geront"] = "Bibliotekarz, miasto gnomow",
    ["gersth hethral"] = "Z klanu Ar'Troth, Browar Mahakamski",
    ["gnshin"] = "Krol goblinow w ukrytej swiatyni w jaskiniach",
    ["hanoc"] = "Inzynier, laboratoria gnomow",
    ["hast wherevry"] = "Kartograf, miasto gnomow",
    ["jull steedon"] = "Gospoda w miescie gnomow",
    ["lillianna indagatrix"] = "Asystentka w miescie gnomow",
    ["nilrem lotalot"] = "Alchemik, miasto gnomow",
    ["ora digh"] = "Z klanu Houg, Bibliotekarka Krasnoludow Mahakamu, ",
    ["percival  schuttenbach"] = "Jubiler, miasto gnomow",
    ["rahna vivaldi"] = "Poczta",
    ["serdock luf"] = "Z klanu Gryy'tsan",
    ["sophia"] = "Alchemik, miasto gnomow",
    ["tark"] = "Obsluga maszyny, gospoda w miescie gnomow",
    ["terunni"] = "Mistrz Gnomow, miasto gnomow",
    ["than phon"] = "Z klanu Houg, Gildia",
    ["trebhar harovitz"] = "Z klanu Houg, Kowal",
    ["yahan vrzimm"] = "Z klanu Zodo, Skup Skor",
    ["yaran vrzimm"] = "Z klanu Zodo, Sklep",
    ["yarro broin"] = "Daleki kuzyn Starosty",
    ["centhus crain"] = "Platnerz",
    ["yazon varda"] = "Kusnierz [wschod i gora]",
    ["jadger huss"] = "Bednarz [nw]",
    ["starkad giancardi"] = "Zlotnik (sw)",
    ["barclay els"] = "Dowodca twierdzy",
    ["daltz giancardi"] = "Bank",
    ["drumm"] = "Ochotnik, Karczma 'Pod Krwawym Toporem'",
    ["eudora brekenriggs"] = "Sklep",
    ["gdula"] = "Kantyna",
    ["grus"] = "Karczma 'Pod Krwawym Toporem'",
    ["hin"] = "Ochotnik, Karczma 'Pod Krwawym Toporem'",
    ["isarn hamerfel"] = "Kowal",
    ["jaxlen krecikolo"] = "Mistrz katowski, Plac egzekucyjny",
    ["milo vanderbeck"] = "Chirurg polowy, Lazaret",
    ["neit"] = "Ochotnik, Karczma 'Pod Krwawym Toporem'",
    ["persh"] = "Oprawca katowski, Plac egzekucyjny",
    ["rocco hildebrandt"] = "Biblioteka",
    ["schram cambus"] = "Kaplan Kultu Przodkow, swiatynia",
    ["sheldon"] = "Dowodca Roty, Arena",
    ["tersh"] = "Oprawca katowski, Plac egzekucyjny",
    ["vaks"] = "Ochotnik, Karczma 'Pod Krwawym Toporem'",
    ["wirising"] = "Gospoda 'Pod Wiedzminskim Mieczem'",
    ["aharon"] = "Mag, Wieza",
    ["candeler"] = "Sekretarz, Wieza",
    ["daniel etcheverry"] = "Zarzadca zamku",
    ["duncan henderley"] = "Doradca hrabiego w zamku",
    ["gouvin"] = "Garbarz",
    ["harcaes aubert"] = "Kupiec w zamku",
    ["jozwa"] = "Kowal",
    ["katon"] = "Mistrz Ostrza, Gospoda 'Zacisze'",
    ["natorp"] = "Przekluwacz",
    ["nelmar z mariboru"] = "Handlarz olejkami i pachnidlami na targu",
    ["sandris"] = "Stowarzyszenie Polelfow",
    ["tigrane z cintry"] = "Kwiaciarnia",
    ["henger yaren"] = "Kowal",
    ["kagren getz"] = "Skup skor",
    ["kirim moivre"] = "Dowodca strazy, chodzi kolo poczty",
    ["darmon dartiani"] = "Zajazd 'Pod Kasztanami'",
    ["dolora"] = "Sluzaca w zajezdzie 'Pod Kasztanami'",
    ["dwinor dra'gn'erth"] = "Mistrz zlotniczy, alkierz w zajezdzie 'Pod Kasztanami'",
    ["helgart buere"] = "Zajazd 'Pod Murami'",
    ["jerik blath"] = "Garncarz ",
    ["maritha z roggeveen"] = "Sluzaca w zajezdzie 'Pod Kasztanami'",
    ["meia"] = "Zielarka",
    ["nidia"] = "Polelfka",
    ["slavimir sobira"] = "Kusnierz",
    ["abian treint"] = "Bibliotekarz",
    ["ander winthrop"] = "Kucharz Naczelny",
    ["aynos breffet"] = "Marszalek Dworu",
    ["dulorn owlar"] = "Stajnia w dworze",
    ["hajin vinet"] = "Karczma 'U Hermana'",
    ["herman lined"] = "Karczma 'U Hermana'",
    ["vernick kraelm"] = "Kowal",
    ["gabel draik"] = "Garbarz, osada Mysliwska na zachod od Scali",
    ["herm gasniv"] = "Naczelnik, osada Mysliwska na zachod od Scali",
    ["jaslav paduc"] = "Rymarz, osada Mysliwska na zachod od Scali",
    ["jupies"] = "Poslaniec, osada Mysliwska na zachod od Scali",
    ["oleg anteczuk"] = "Kowal, osada Mysliwska na zachod od Scali",
    ["rante"] = "Karczma 'Dwa Jelenie', osada Mysliwska na zachod od Scali",
    ["amina"] = "Sklep z rybami na targu",
    ["anzelm"] = "Bednarz",
    ["armirez reimar"] = "Sklep z przyprawami na targu",
    ["arnolf rubenstine"] = "Sklep",
    ["barend lamiel"] = "Sekretarz, Ratusz",
    ["brunilda"] = "Sklep z warzywami na targu",
    ["caraes le'crotte"] = "Zajazd 'Zloty Smok'",
    ["dewald rest"] = "Sklep",
    ["dimar narretin"] = "Sklep z bizuteria na targu",
    ["eberhard"] = "'Karczma Katowska'",
    ["erest"] = "Rzeznik",
    ["fabio"] = "Karczma 'Pod Murem'",
    ["hargilda"] = "Sklep z owocami na targu",
    ["liena"] = "Piekarnia",
    ["niemir"] = "Zielarz",
    ["reghard cerard"] = "Naczelnik wiezienia",
    ["siemirad"] = "Szewc",
    ["stojmir"] = "Sklep ze skorami",
    ["xaver renietz"] = "Burmistrz, Ratusz",
    ["zarhorn edevry"] = "Zlotnik",
    ["favorik"] = "Soltys Rybitwy",
    ["petyr"] = "Tawerna 'Pod Papugami'",
    ["reuv"] = "Sklep ze zbrojami",
    ["sam hildebrandt"] = "Zlotnik",
    ["tankred"] = "Namiestnik",
    ["tsches nemen"] = "Bard, Tawerna 'Pod Papugami'",
    ["verdin"] = "Kowal",
    ["vilfrid wenck"] = "Oficer Daevonskiego Garnizonu",
    ["buoner"] = "Skup skor",
    ["farren"] = "Wojt",
    ["lanfear"] = "Strazniczka",
    ["ordeith"] = "Dowodca Strazy",
    ["ellearh"] = "Elfiego Zwiadu",
    ["gargant de fielbre"] = "Dowodca Oddzialow Specjalnego Przeznaczenia",
    ["jaim halzuh"] = "General Armii Kaedwen",
    ["rygard brago"] = "Dowodca Tropicieli",
    ["ulkar"] = "Adiutant",
    ["vitryk"] = "Dowodca Tarczownikow",
    ["dena"] = "Dziewczynka w okolicach zrodla wody",
    ["ginter"] = "Sprzedawca doniczek na targu",
    ["kalendra"] = "Kaplanka swiatyni Smokow",
    ["kitari"] = "Sprzedawca sadzonek na targu",
    ["laila"] = "Tancerka w karczmie",
    ["oileaver"] = "Pracownik salonu masazu",
    ["zinta"] = "Staruszka w ogrodzie na dachu",
    ["barrent"] = "Staruszek, zrujnowany do na poludniu ",
    ["brann"] = "Jarl Skellige, Dowodca Berserkerow",
    ["gober"] = "Nadworny Bibliotekarz, Twierdza Kaer Trolde",
    ["gotard"] = "Kowal",
    ["haakon canedeh"] = "Zlotnik",
    ["harp gudjohnson"] = "Smakosz Ryb",
    ["saarg hansson"] = "Karczma 'Gnijaca Meduza'",
    ["uve odlfriht"] = "Zielarz",
    ["vort tredson"] = "Sierzant Gwardii Jarla, Twierdza Kaer Trolde",
    ["yarael"] = "Przekluwanie ciala",
    ["aalback aen glyswen"] = "Rezydencja",
    ["aerdrun bleiddarse"] = "Kowal",
    ["blarney"] = "Czlowiek we wsi w zachodniej czesci wyspy",
    ["gallimard d'oromet"] = "Latarnia",
    ["gorven blavenchett"] = "Namiestnik, wieza w porcie na poludniowym-wschodzie",
    ["manuela"] = "Kobieta we wsi w zachodniej czesci wyspy",
    ["monh de bufnh"] = "Cesarski Urzednik Do Spraw Spisu Ludnosci, wieza w porcie na poludniowym-wschodzie",
    ["muircetach de magrive"] = "Rezydencja",
    ["vignar"] = "Zaklad wyrobow we wsi w zachodniej czesci wyspy",
    ["buba"] = "Rozwody",
    ["kelwig"] = "Golebiarz",
    ["lethys von merrederh"] = "Kaplan swiatyni Milosci",
    ["mavadil"] = "Obraczki",
    ["adden"] = "Wojt Eldar",
    ["adia"] = "Wyspa Faroe",
    ["ann"] = "Zielarka z Hagge",
    ["birk"] = "Nadzorca Wyrabu w lesie w Lyrii",
    ["celilith"] = "Oberza 'Pod Zadumanym Smokiem', na polnoc od Illian",
    ["chmielin"] = "Karczmarz, zajazd na drodze do Bodrogu",
    ["cyrvil"] = "Soltys wioski na polnocy lasu kolo Novigradu",
    ["damaris"] = "Herszt zbojow w Ciemnym Borze",
    ["dhun"] = "Starszy Dolnej Posady",
    ["dlavroc"] = "Wiezien w warowni zbojeckiej w Ciemnym Borze",
    ["dobromil"] = "Mlody nekromanta, las na wschod od Kociepola",
    ["efrem chancellor"] = "Komisarz Krola Venzlava, wyrabisko na drodze do Bodrogu",
    ["elazy"] = "Starosta bartny, osada bartnikow",
    ["faleantil"] = "Oberza 'Pod Zadumanym Smokiem', na polnoc od Illian",
    ["ghorzak"] = "Przywodca drwali z Puszczy Shekhal",
    ["glamot"] = "Tartak w Anchor",
    ["gottwald"] = "Karczma w osadzie bartnikow ",
    ["grzmiwoj"] = "Kowal i soltys Kociepola",
    ["hashet drett"] = "Zarzadca winnicy, na polnocny-zachod od Mariboru",
    ["ivar"] = "Starosta Gornej Posady",
    ["kian"] = "Kowal w Dolnej Posadzie",
    ["kornil"] = "Zielarz w Kociepolu",
    ["kozimir"] = "Soltys Obawy",
    ["krolken"] = "Herszt vranow kolo Mahakamu",
    ["larevandell woeddbleid"] = "Zajazd 'Pod Czarnym Jednorozcem'",
    ["lisael fainendel"] = "Kowal Elfow z Gor Sinych",
    ["luking"] = "Kramik na drodze do Scali",
    ["marf le dorf"] = "Zajazd w Dorian, na zachod od Puszczy Shekhal",
    ["mermehel hoffter"] = "Karczma 'U Vithera' w Kaedwen",
    ["morhil denemort"] = "Porucznik Kawalerii Redanskiej, na polnoc od Tretogoru",
    ["muchobij"] = "Wojt Anchor",
    ["nosigniew"] = "Golebiarz w Anchor",
    ["pringler drasdor"] = "'Zajazd Nadrzeczny', na zachod od Scali",
    ["raf"] = "Karczma w wiosce na polnocy lasu kolo Novigradu",
    ["rolf de wess"] = "Zajazd 'Pod Czarnym Jednorozcem'",
    ["sougival"] = "Gnom w chatce we wzgorzach Mahakamu",
    ["stilla thul"] = "'Zajazd Nadrzeczny', na zachod od Scali",
    ["telbo"] = "Pomocnik karczmarza, zajazd na drodze do Bodrogu",
    ["tudan"] = "Oberza 'Pod Zadumanym Smokiem', na polnoc od Illian",
    ["vadria"] = "Kaplanka Bogini Matki, Wyspa Hindarsfjall",
    ["verdon"] = "Traper w chatce na srodgorzu wschodniego Makahamu",
    ["verik"] = "Mlyn na poludniowy-zachod od Wyzimy",
    ["verner istvan"] = "Rotmistrz z garnizonu Spalli, patrol w Lyrii",
    ["vernika"] = "Chata w Kociepolu",
    ["vither aranos"] = "Karczma 'U Vithera' w Kaedwen",
    ["vole"] = "Skupu skor w Dolnej Posadzie",
    ["wingard"] = "Karczma 'Usmiech Karczmarza' w gorach Mahakamu",
    ["wit ardeli"] = "Gospoda 'Pod Wiedzminem', Sucha Kepa",
    ["zatras"] = "Kucharz w warowni zbojeckiej w Ciemnym Borze",
    ["zdziwoj"] = "Wojt wsi Sucha Kepa, na zachod od Gelibolu",
    ["zidia"] = "Karczma 'Pod Jablonia' w Gornej Posadzie",
    ["ziemowit"] = "Drwal z Obawy",
    ["zniwomir"] = "Chata na polnoc od Kociepola",
    ["zount"] = "Oberzysta w Eldar",
}

