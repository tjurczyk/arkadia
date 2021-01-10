
scripts.misc = scripts.misc or {}
scripts.misc.books = {
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
}

scripts.misc.books_alt = {
    ["wielkiej opaslej ksiegi"] = {
       ["smokach i smokowatych"] = "zglebiaj wiedze o stworach pokoniunkcyjnych z wielkiej opaslej ksiega",
       ["stworach pokoniunkcyjnych"] = "zglebiaj wiedze o wampirach z wielkiej opaslej ksiega"
    },
    ["opaslego szarawego tomiszcza"] = {
        ["ryboludziach"] = "zglebiaj wiedze o o starszych rasach z opaslego szarawego tomiszcza"
    },
    ["czarnej grubej ksiegi"] = {
        ["chaosie i jego tworach"] = "zglebiaj wiedze o istotach demonicznych z czarnej grubej ksiegi",
    }
}

function trigger_func_skrypty_misc_book_open(book_name)
    book_name = string.lower(book_name)
    if scripts.misc.books[book_name] then
        scripts.utils.bind_functional(scripts.misc.books[book_name])
    else
        debugc("Ksiega nie odnaleziona " .. book_name)
    end
end

function trigger_func_skrypty_misc_book_continue(book_name, knowledge)
    book_name = string.lower(book_name)
    knowledge = string.lower(knowledge)
    if scripts.misc.books_alt[book_name] and scripts.misc.books_alt[book_name][knowledge] then
        scripts.utils.bind_functional(scripts.misc.books_alt[book_name][knowledge])
    end
end

