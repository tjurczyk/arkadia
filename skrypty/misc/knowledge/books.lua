
scripts.misc = scripts.misc or {}
scripts.misc.knowdlege = scripts.misc.knowdlege or {} 

scripts.misc.knowdlege.books = scripts.misc.knowdlege.books or {
    ["opened_book_name"] = nil,
    ["current_book_name"] = nil,
    ["current_knowledge"] = nil,
    ["patterns"] = {
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
        ["poplamiona sfatygowana ksiege"] = "zglebiaj wiedze o wampirach z poplamionej sfatygowanej ksiegi",
        ["poplamiona wysuszona ksiege"] = "zglebiaj wiedze o pajakach i pajakowatych z poplamionej wysuszonej ksiegi",
        ["pozolkla powyginana ksiege"] = "zglebiaj wiedze o pajakach i pajakowatych z pozolklej powyginanej ksiegi",
        ["runiczna kosciana ksiege"] = "zglebiaj wiedze o nieumarlych z runicznej koscianej ksiegi",
        ["spieta opasla teke"] = "zglebiaj wiedze o golemach z spietej opaslej teki",
        ["srebrna luskowata ksiege"] = "zglebiaj wiedze o smokach i smokowatych z srebrnej luskowatej ksiegi",
        ["srebrnoniebieski zdobiony folial"] = "zglebiaj wiedze o ryboludziach ze srebrnoniebieskiego zdobionego folialu",
        ["tega okuta ksiege"] = "zglebiaj wiedze o istotach demonicznych z tegiej okutej ksiegi",
        ["twarda jednobarwna ksiege"] = "zglebiaj wiedze o wampirach z twarda jednobarwnej ksiegi",
        ["wielka opasla ksiege"] = "zglebiaj wiedze o smokach i smokowatych z wielkiej opaslej ksiegi",
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
    },
    ["patterns_alt"] = {
        ["wielkiej opaslej ksiegi"] = {
           ["smokach i smokowatych"] = "zglebiaj wiedze o stworach pokoniunkcyjnych z wielkiej opaslej ksiegi",
           ["stworach pokoniunkcyjnych"] = "zglebiaj wiedze o wampirach z wielkiej opaslej ksiegi"
        },
        ["opaslego szarawego tomiszcza"] = {
            ["ryboludziach"] = "zglebiaj wiedze o starszych rasach z opaslego szarawego tomiszcza"
        },
        ["grubej obitej ksiegi"] = {
            ["nieumarlych"] = "zglebiaj wiedze o nieumarlych z grubej obitej ksiegi"
        },
        ["czarnej grubej ksiegi"] = {
            ["chaosie i jego tworach"] = "zglebiaj wiedze o istotach demonicznych z czarnej grubej ksiegi",
        },
    }
}
books = scripts.misc.knowdlege.books;

function scripts.misc.knowdlege.books:open_book(command)
    if not mudlet.supports.coroutines then
        return
    end
    
    if books.trigger1 then disableTrigger(books.trigger1) end
    if books.trigger2 then disableTrigger(books.trigger2) end

    books.command = command;
    books.read_coroutine_id = coroutine.create(scripts.misc.knowdlege.books._read_book_coroutine)
    coroutine.resume(books.read_coroutine_id)
end

function scripts.misc.knowdlege.books:_read_book_coroutine(command)
    books.trigger1 = tempRegexTrigger("^Otwierasz (.*?) na stronie pierwszej\\.$", function() 
        trigger_func_scripts_misc_book_open(matches[2]) 
    end, 1)

    send(books.command, false)

    local timer = tempTimer(5, function()
        if books.trigger1 then disableTrigger(books.trigger1) end
    end)

    coroutine.yield()

    killTimer(timer)
    if books.trigger1 then disableTrigger(books.trigger1) end

    if books.opened_book_name then
        local book_name = books.opened_book_name;

        if books.patterns[book_name] then
            local command = books.patterns[book_name]
            scripts.utils.bind_functional_call(function()
                send(command)
                books.read_coroutine_id = coroutine.create(scripts.misc.knowdlege.books._continue_book_coroutine)
                coroutine.resume(books.read_coroutine_id)
            end, command)
        else
            debugc("Ksiega nie odnaleziona " .. book_name)
        end
    end
end


function scripts.misc.knowdlege.books:_continue_book_coroutine(command)

    books.trigger2 = tempRegexTrigger("^Masz wrazenie, ze z (.*?) nie dowiesz sie juz niczego wiecej o (.*?)\\.$", function()
        trigger_func_scripts_misc_book_continue(matches[2], matches[3])
    end, 1)

    local timer = tempTimer(30, function()
        if books.trigger2 then disableTrigger(books.trigger2) end
    end)

    coroutine.yield()

    killTimer(timer)
    if books.trigger2 then disableTrigger(books.trigger2) end

    if books.current_book_name then
        local book_name = books.current_book_name;
        local knowledge = books.current_knowledge;
        local patterns_alt = books.patterns_alt;
        if patterns_alt[book_name] and patterns_alt[book_name][knowledge] then

            local command = patterns_alt[book_name][knowledge];
            scripts.utils.bind_functional_call(function()
                send(command)

                books.read_coroutine_id = coroutine.create(scripts.misc.knowdlege.books._continue_book_coroutine)
                coroutine.resume(books.read_coroutine_id)
            end, command)
        end
    end  
end



function alias_func_scripts_misc_book_open(command)
    scripts.misc.knowdlege.books:open_book(command)
end

function trigger_func_scripts_misc_book_open(book_name)
    books.opened_book_name = string.lower(book_name)
    coroutine.resume(books.read_coroutine_id)
end

function trigger_func_scripts_misc_book_continue(book_name, knowledge)
    books.current_book_name = string.lower(book_name)
    books.current_knowledge = string.lower(knowledge)
    coroutine.resume(books.read_coroutine_id)
end

