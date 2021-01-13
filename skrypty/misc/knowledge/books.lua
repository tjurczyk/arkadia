
scripts.misc = scripts.misc or {}
scripts.misc.knowdlege = scripts.misc.knowdlege or {} 
scripts.misc.knowdlege.books = scripts.misc.knowdlege.books or {}
scripts.misc.knowdlege.books.patterns = {
    ["ciezka czerwona ksiege"] = "zglebiaj wiedze o wampirach z ciezkiej czerwonej ksiegi",
    ["ciezka solidna ksiege"] = "zglebiaj wiedze o stworach pokoniunkcyjnych z ciezkiej solidnej ksiegi",
    ["czarna gruba ksiege"] = "zglebiaj wiedze o chaosie i jego tworach z czarnej grubej ksiegi",
    ["czarne nadgryzione tomiszcze"] = "zglebiaj wiedze o szczuroludziach z czarnego nadgryzionego tomiszcza",
    ["ekstrawagancka pomaranczowa ksiazke"] = "zglebiaj wiedze o wampirach z ekstrawaganckiej pomaranczowej ksiazki",
    ["elegancka kieszonkowa ksiazeczke"] = "zglebiaj wiedze o magii i jej tworach z eleganckiej kieszonkowej ksiazeczki",
    ["ilustrowana opasla ksiege"] = "zglebiaj wiedze o szczuroludziach z ilustrowanej opaslej ksiegi",
    ["kamienna ciezka ksiege"] = "zglebiaj wiedze o golemach z kamiennej ciezkiej ksiegi",
    ["miekka nieduza ksiazke"] = "zglebiaj wiedze o szczuroludziach z miekkiej nieduzej ksiazki",
    ["niewielka czarna ksiazeczke"] = "zglebiaj wiedze o smokach i smokowatych z niewielkiej czarnej ksiazeczki",
    ["opasle szarawe tomiszcze"] = "zglebiaj wiedze o ryboludziach z opaslego szarawego tomiszcza",
    ["plomienista opasla ksiege"] = "zglebiaj wiedze o magii i jej tworach z plomienistej opaslej ksiegi",
    ["podniszczony gruby dziennik"] = "zglebiaj wiedze o jaszczuroludziach z podniszczonego grubego dziennika",
    ["popielata tloczona ksiege"] = "zglebiaj wiedze o goblinoidach z popielatej tloczonej ksiegi",
    ["poplamiona sfatygowana ksiege"] = "zglebiaj wiedze o wampirach z poplamionej sfatygowanej ksieg",
    ["poplamiona wysuszona ksiege"] = "zglebiaj wiedze o pajakach i pajakowatych z poplamionej wysuszonej ksiegi",
    ["pozolkla powyginana ksiege"] = "zglebiaj wiedze o pajakach i pajakowatych z pozolklej powyginanej ksiegi",
    ["runiczna kosciana ksiege"] = "zglebiaj wiedze o nieumarlych z runicznej koscianej ksiegi",
    ["spieta opasla teke"] = "zglebiaj wiedze o golemach z spietej opaslej teki",
    ["srebrna luskowata ksiege"] = "zglebiaj wiedze o smokach i smokowatych z srebrnej luskowatej ksiegi",
    ["srebrnoniebieski zdobiony folial"] = "zglebiaj wiedze o ryboludziach ze srebrnoniebieskiego zdobionego folialu",
    ["tega okuta ksiege"] = "zglebiaj wiedze o istotach demonicznych z tegiej okutej ksiegi",
    ["twarda jednobarwna ksiege"] = "zglebiaj wiedze o wampirach z twarda jednobarwnej ksiega",
    ["wielka opasla ksiege"] = "zglebiaj wiedze o smokach i smokowatych z wielkiej opaslej ksiega",
    ["wysluzona bordowa ksiege"] = "zglebiaj wiedze o chaosie i jego tworach z wysluzonej bordowej ksiegi",
    ["zatechly przybrudzony rekopis"] = "zglebiaj wiedze o nieumarlych z zatechlego przybrudzonego rekopisu",
    ["zdobiona oprawna ksiege"] = "zglebiaj wiedze o starszych rasach z zdobionej oprawnej ksiegi",
    ["chudy skorzany notatnik"] = "zglebiaj wiedze o pajakach i pajakowatych z chudego skorzanego notatnika",
    ["czarna podniszczona ksiege"] = "zglebiaj wiedze o chaosie i jego tworach z czarnej podniszczonej ksiegi",
    ["czarna zdobiona ksiege"] = "zglebiaj wiedze o istotach demonicznych z czarnej zdobionej ksiegi",
    ["gruba ksiege"] = "zglebiaj wiedze o chaosie i jego tworach z grubej ksiegi",
    ["gruba obita ksiege"] = "zglebiaj wiedze o nieumarlych z grubej obitej ksiegi",
    ["nieduzy zawilgly notatnik"] = "zglebiaj wiedze o wampirach z nieduzego zawilglego notatnika",
    ["niewielka pachnaca ksiege"] = "zglebiaj wiedze o chaosie i jego tworach z niewielkiej pachnacej ksiegi",
    ["pek koralowych tabliczek"] = "zglebiaj wiedze o ryboludziach z peku koralowych tabliczek",
    ["skorzana makabryczna ksiege"] = "zglebiaj wiedze o nieumarlych z skorzanej makabrycznej ksiegi",
    ["pogryziona brazowa ksiege"] = "zglebiaj wiedze o goblinoidach z pogryzionej brazowej ksiegi",
}

scripts.misc.knowdlege.books.patterns_alt = {
    ["wielkiej opaslej ksiegi"] = {
       ["smokach i smokowatych"] = "zglebiaj wiedze o stworach pokoniunkcyjnych z wielkiej opaslej ksiega",
       ["stworach pokoniunkcyjnych"] = "zglebiaj wiedze o wampirach z wielkiej opaslej ksiega"
    },
    ["opaslego szarawego tomiszcza"] = {
        ["ryboludziach"] = "zglebiaj wiedze o o starszych rasach z opaslego szarawego tomiszcza"
    },
    ["czarnej grubej ksiegi"] = {
        ["chaosie i jego tworach"] = "zglebiaj wiedze o istotach demonicznych z czarnej grubej ksiegi",
    },
}

function scripts.misc.knowdlege.books:open_book(command)
    if self.trigger1 then disableTrigger(self.trigger1) end
    if self.trigger2 then disableTrigger(self.trigger2) end

    self.trigger1 = tempRegexTrigger("^Otwierasz (.*?) na stronie pierwszej\\.$", function() 
        trigger_func_scripts_misc_book_open(matches[2]) 
    end, 1)
    self.trigger2 = tempRegexTrigger("^Masz wrazenie, ze z (.*?) nie dowiesz sie juz niczego wiecej o (.*?)\\.$", function()
        trigger_func_scripts_misc_book_continue(matches[2], matches[3])
    end, 1)
    send(command, false)
    tempTimer(10, function() disableTrigger(self.trigger1) end)
    tempTimer(20, function() disableTrigger(self.trigger2) end)
end

function alias_func_scripts_misc_book_open(command)
    scripts.misc.knowdlege.books:open_book(command)
end


function trigger_func_scripts_misc_book_open(book_name)
    book_name = string.lower(book_name)
    local patterns = scripts.misc.knowdlege.books.patterns
    if patterns[book_name] then
        scripts.utils.bind_functional(patterns[book_name])
    else
        debugc("Ksiega nie odnaleziona " .. book_name)
    end
end

function trigger_func_scripts_misc_book_continue(book_name, knowledge)
    book_name = string.lower(book_name)
    knowledge = string.lower(knowledge)

    local patterns_alt = scripts.misc.knowdlege.books.patterns_alt;
    if patterns_alt[book_name] and patterns_alt[book_name][knowledge] then
        scripts.utils.bind_functional(patterns_alt[book_name][knowledge])
    end
end

