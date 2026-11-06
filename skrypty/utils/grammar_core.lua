Rzeczownik = Rzeczownik or {}
Rzeczownik.__index = Rzeczownik

function Rzeczownik:new(gender, singular_forms, plural_forms)
    local obj = {
        gender = gender,
        singular = singular_forms,
        plural = plural_forms
    }
    setmetatable(obj, self)

    -- Validate declensions
    if not obj:validate_declensions() then
        local label = (singular_forms and singular_forms[1]) or (plural_forms and plural_forms[1]) or "?"
        error("Nieprawidlowa odmiana rzeczownika: " .. label)
    end

    return obj
end

function Rzeczownik:validate_declensions()
    local cases = Grammar.CASES
    if self.singular and #self.singular ~= #cases then
        return false
    end
    if self.plural and #self.plural ~= #cases then
        return false
    end
    -- Musi byc przynajmniej jedna z form
    if not self.singular and not self.plural then
        return false
    end
    return true
end

function Rzeczownik:get_form(case, number)
    local forms = (number and self.plural) or self.singular
    return forms and forms[case] or ""
end

function Rzeczownik:get_base_form()
    if self.singular then return self.singular[1] end
    return self.plural and self.plural[1] or ""
end

function Rzeczownik:is_plurale_tantum()
    return self.singular == nil
end

-- =====================================================
-- PRZYMIOTNIK (ADJECTIVE) CLASS
-- =====================================================

Przymiotnik = Przymiotnik or {}
Przymiotnik.__index = Przymiotnik

function Przymiotnik:new(base_form)
    local obj = {
        base_form = base_form,  -- Always masculine singular nominative
        stem = nil,
        declension_rules = nil
    }
    setmetatable(obj, self)

    obj.stem = obj:extract_stem()
    obj.declension_rules = AdjectiveRules:get_rules(base_form)

    return obj
end

function Przymiotnik:extract_stem()
    local last_char = self.base_form:sub(-1)
    if last_char == "y" or last_char == "i" then
        return self.base_form:sub(1, -2)
    end
    return self.base_form
end

function Przymiotnik:decline(case, gender, number)
    return AdjectiveRules:apply_rules(self.stem, case, gender, number, self.declension_rules)
end

function Przymiotnik:detect_gender_from_form(form)
    local last_char = form:sub(-1)
    if last_char == "a" then return Grammar.ZENSKI
    elseif last_char == "e" then return Grammar.NIJAKI_OS
    else return Grammar.MESKI_OS end
end

-- =====================================================
-- GRAMMAR CONSTANTS AND UTILITIES
-- =====================================================

Grammar = Grammar or {
    CASES = {"mianownik", "dopelniacz", "celownik", "biernik", "narzednik", "miejscownik"},
    GENDERS = {"meski_osobowy", "meski_nieosobowy_zywotny", "meski_nieosobowy_niezywotny",
               "zenski", "nijaki_osobowy", "nijaki_nieosobowy","niemeskoosobowy"},

    -- Constants
    MIA = 1, DOP = 2, CEL = 3, BIE = 4, NAR = 5, MIE = 6,
    MESKI_OS = 1, MESKI_NOS_ZYW = 2, MESKI_NOS_NZYW = 3,
    ZENSKI = 4, NIJAKI_OS = 5, NIJAKI_NOS = 6, MESKI_NOS = 7,

    -- Common prepositions that start post-noun phrases
    PREPOSITIONS = {["z"] = true, ["ze"] = true, ["w"] = true, ["na"] = true, ["o"] = true, ["do"] = true, ["od"] = true, ["dla"] = true, ["bez"] = true, 
                   ["przez"] = true, ["nad"] = true, ["pod"] = true, ["przy"] = true, ["za"] = true, ["we"] = true}
}

-- =====================================================
-- ADJECTIVE DECLENSION RULES ENGINE
-- =====================================================

AdjectiveRules = AdjectiveRules or {
}

function AdjectiveRules:get_rules(adjective)
    local last_chars = adjective:sub(-2)
    if last_chars == "ki" or last_chars == "gi" then
        return "soft"
    elseif adjective:sub(-1) == "k" or adjective:sub(-1) == "g" then
        return "soft"
    elseif adjective:sub(-1) == "i" then
        -- "dlugi"/"krotki" juz zlapane wyzej jako "soft"
        -- "elfi","olbrzymi","lisi" etc. - stem konczy sie na zwykla spolgloskę + i
        return "soft_i"
    else
        return "hard"
    end
end

function AdjectiveRules:apply_rules(stem, case, gender, number, rule_type)
    return stem .. self:get_endings(case, gender, number, rule_type)
end

function AdjectiveRules:get_endings(case, gender, number, rule_type)
    local patterns = {
        hard = {
            singular = {
                [Grammar.MESKI_OS]        = {"y",  "ego", "emu", "ego", "ym",  "ym"},
                [Grammar.MESKI_NOS_ZYW]   = {"y",  "ego", "emu", "ego", "ym",  "ym"},
                [Grammar.MESKI_NOS_NZYW]  = {"y",  "ego", "emu", "y",   "ym",  "ym"},
                [Grammar.ZENSKI]          = {"a",  "ej",  "ej",  "a",   "a",   "ej"},
                [Grammar.NIJAKI_OS]       = {"e",  "ego", "emu", "e",   "ym",  "ym"},
                [Grammar.NIJAKI_NOS]      = {"e",  "ego", "emu", "e",   "ym",  "ym"}
            },
            plural = {
                [Grammar.MESKI_OS]  = {"i",  "ych", "ym", "ych", "ymi", "ych"},
                [Grammar.MESKI_NOS] = {"e",  "ych", "ym", "e",   "ymi", "ych"}
            }
        },
        soft = {
            singular = {
                [Grammar.MESKI_OS]        = {"i",  "iego", "iemu", "iego", "im",  "im"},
                [Grammar.MESKI_NOS_ZYW]   = {"i",  "iego", "iemu", "iego", "im",  "im"},
                [Grammar.MESKI_NOS_NZYW]  = {"i",  "iego", "iemu", "i",    "im",  "im"},
                [Grammar.ZENSKI]          = {"a",  "iej",  "iej",  "a",    "a",   "iej"},
                [Grammar.NIJAKI_OS]       = {"ie", "iego", "iemu", "ie",   "im",  "im"},
                [Grammar.NIJAKI_NOS]      = {"ie", "iego", "iemu", "ie",   "im",  "im"}
            },
            plural = {
                [Grammar.MESKI_OS]  = {"i",  "ich", "im", "ich", "imi", "ich"},
                [Grammar.MESKI_NOS] = {"ie", "ich", "im", "ie",  "imi", "ich"}
            }
        },
        -- soft_i: "elfi", "olbrzymi", "lisi" - base_form konczy sie na spolgl+"i"
        -- extract_stem ucina to "i", wiec koncowki musza zawierac "i" tam gdzie potrzeba
        soft_i = {
            singular = {
                [Grammar.MESKI_OS]        = {"i",  "iego",  "iemu",  "iego",  "im",  "im"},
                [Grammar.MESKI_NOS_ZYW]   = {"i",  "iego",  "iemu",  "iego",  "im",  "im"},
                [Grammar.MESKI_NOS_NZYW]  = {"i",  "iego",  "iemu",  "i",     "im",  "im"},
                [Grammar.ZENSKI]          = {"ia", "iej",   "iej",   "ia",    "ia",  "iej"},
                [Grammar.NIJAKI_OS]       = {"ie", "iego",  "iemu",  "ie",    "im",  "im"},
                [Grammar.NIJAKI_NOS]      = {"ie", "iego",  "iemu",  "ie",    "im",  "im"}
            },
            plural = {
                [Grammar.MESKI_OS]  = {"i",  "ich", "im", "ich", "imi", "ich"},
                [Grammar.MESKI_NOS] = {"ie", "ich", "im", "ie",  "imi", "ich"}
            }
        }
    }

    local pattern_set = patterns[rule_type] or patterns.hard
    local number_set = number and pattern_set.plural or pattern_set.singular
    local gender_set = number_set[gender] or number_set[Grammar.MESKI_NOS] or number_set[Grammar.MESKI_OS]

    return gender_set and gender_set[case] or ""
end

function AdjectiveRules:convert_to_base_form(inflected_form, current_case, current_gender, current_count)
    local soft_ending = self:get_endings(current_case, current_gender, current_count, "soft")
    local hard_ending = self:get_endings(current_case, current_gender, current_count, "hard")

    local stem

    -- Jesli ending soft rozni sie od hard, mozemy rozstrzygnac jednoznacznie
    if soft_ending ~= hard_ending then
        if soft_ending ~= "" and inflected_form:match(soft_ending .. "$") then
            stem = inflected_form:sub(1, -(#soft_ending + 1))
            -- Soft ending pasuje jednoznacznie - forma jest miekka
            return Przymiotnik:new(stem .. "i")
        elseif hard_ending ~= "" and inflected_form:match(hard_ending .. "$") then
            stem = inflected_form:sub(1, -(#hard_ending + 1))
            local stem_last = stem:sub(-1)
            local rule_type = (stem_last == "k" or stem_last == "g") and "soft" or "hard"
            return Przymiotnik:new(stem .. (rule_type == "soft" and "i" or "y"))
        end
    else
        -- Ending identyczny dla soft i hard (np. "a" dla zenskiego MIA) -
        -- rozstrzygamy po ostatniej literze stemu
        if hard_ending ~= "" and inflected_form:match(hard_ending .. "$") then
            stem = inflected_form:sub(1, -(#hard_ending + 1))
            local stem_last = stem:sub(-1)
            if stem_last == "i" then
                return Przymiotnik:new(stem)  -- "elfi", "olbrzymi" - "i" jest juz czescia base_form
            end
            local rule_type = (stem_last == "k" or stem_last == "g") and "soft" or "hard"
            return Przymiotnik:new(stem .. (rule_type == "soft" and "i" or "y"))
        end
    end

    -- Fallback: nie udalo sie odciac endingu
    stem = inflected_form
    local stem_last = stem:sub(-1)
    local rule_type = (stem_last == "k" or stem_last == "g" or stem_last == "i") and "soft" or "hard"
    return Przymiotnik:new(stem .. (rule_type == "soft" and "i" or "y"))
end

-- =====================================================
-- LICZEBNIK (NUMERAL) CLASS
-- =====================================================

Liczebnik = Liczebnik or {}
Liczebnik.__index = Liczebnik

-- Kolumny: MIA, DOP, CEL, BIE_mos, BIE_nmos, NAR, MIE
-- BIE_mos  = osobowy (jak dopelniacz)
-- BIE_nmos = nieosobowy (jak mianownik)
local NUMERAL_DECL = {
    ["dwa"] = {
        mos  = {"dwaj",   "dwoch", "dwom", "dwoch",   "dwa",    "dwoma",    "dwoch"},
        zen  = {"dwie",   "dwoch", "dwom", "dwie",    "dwie",   "dwoma",    "dwoch"},
        nmos = {"dwa",    "dwoch", "dwom", "dwa",     "dwa",    "dwoma",    "dwoch"},
    },
    ["trzy"] = {
        mos  = {"trzej",  "trzech", "trzem", "trzech", "trzy",   "trzema",  "trzech"},
        nmos = {"trzy",   "trzech", "trzem", "trzy",   "trzy",   "trzema",  "trzech"},
    },
    ["cztery"] = {
        mos  = {"czterej","czterech","czterem","czterech","cztery","czterema","czterech"},
        nmos = {"cztery", "czterech","czterem","cztery",  "cztery","czterema","czterech"},
    },
    -- 5-20: MIA_nmos rozni sie od rdzenia, BIE_mos=DOP, BIE_nmos=MIA, NAR=-oma/-u
    ["piec"]           = {mos={"pieciu",        "pieciu",        "pieciu",        "pieciu",        "piec",           "piecioma",        "pieciu"},
                          nmos={"piec",          "pieciu",        "pieciu",        "piec",          "piec",           "piecioma",        "pieciu"}},
    ["szesc"]          = {mos={"szesciu",        "szesciu",       "szesciu",       "szesciu",       "szesc",          "szescioma",       "szesciu"},
                          nmos={"szesc",          "szesciu",       "szesciu",       "szesc",         "szesc",          "szescioma",       "szesciu"}},
    ["siedem"]         = {mos={"siedmiu",        "siedmiu",       "siedmiu",       "siedmiu",       "siedem",         "siedmioma",       "siedmiu"},
                          nmos={"siedem",         "siedmiu",       "siedmiu",       "siedem",        "siedem",         "siedmioma",       "siedmiu"}},
    ["osiem"]          = {mos={"osmiu",          "osmiu",         "osmiu",         "osmiu",         "osiem",          "ośmioma",         "osmiu"},
                          nmos={"osiem",          "osmiu",         "osmiu",         "osiem",         "osiem",          "osmioma",         "osmiu"}},
    ["dziewiec"]       = {mos={"dziewieciu",     "dziewieciu",    "dziewieciu",    "dziewieciu",    "dziewiec",       "dziewiecioma",    "dziewieciu"},
                          nmos={"dziewiec",        "dziewieciu",    "dziewieciu",    "dziewiec",      "dziewiec",       "dziewiecioma",    "dziewieciu"}},
    ["dziesiec"]       = {mos={"dziesieciu",     "dziesieciu",    "dziesieciu",    "dziesieciu",    "dziesiec",       "dziesiecioma",    "dziesieciu"},
                          nmos={"dziesiec",        "dziesieciu",    "dziesieciu",    "dziesiec",      "dziesiec",       "dziesiecioma",    "dziesieciu"}},
    ["jedenascie"]     = {mos={"jedenastu",      "jedenastu",     "jedenastu",     "jedenastu",     "jedenascie",     "jedenastoma",     "jedenastu"},
                          nmos={"jedenascie",      "jedenastu",     "jedenastu",     "jedenascie",    "jedenascie",     "jedenastoma",     "jedenastu"}},
    ["dwanascie"]      = {mos={"dwunastu",       "dwunastu",      "dwunastu",      "dwunastu",      "dwanascie",      "dwunastoma",      "dwunastu"},
                          nmos={"dwanascie",       "dwunastu",      "dwunastu",      "dwanascie",     "dwanascie",      "dwunastoma",      "dwunastu"}},
    ["trzynascie"]     = {mos={"trzynastu",      "trzynastu",     "trzynastu",     "trzynastu",     "trzynascie",     "trzynastoma",     "trzynastu"},
                          nmos={"trzynascie",      "trzynastu",     "trzynastu",     "trzynascie",    "trzynascie",     "trzynastoma",     "trzynastu"}},
    ["czternascie"]    = {mos={"czternastu",     "czternastu",    "czternastu",    "czternastu",    "czternascie",    "czternastoma",    "czternastu"},
                          nmos={"czternascie",     "czternastu",    "czternastu",    "czternascie",   "czternascie",    "czternastoma",    "czternastu"}},
    ["pietnascie"]     = {mos={"pietnastu",      "pietnastu",     "pietnastu",     "pietnastu",     "pietnascie",     "pietnastoma",     "pietnastu"},
                          nmos={"pietnascie",      "pietnastu",     "pietnastu",     "pietnascie",    "pietnascie",     "pietnastoma",     "pietnastu"}},
    ["szesnascie"]     = {mos={"szesnastu",      "szesnastu",     "szesnastu",     "szesnastu",     "szesnascie",     "szesnastoma",     "szesnastu"},
                          nmos={"szesnascie",      "szesnastu",     "szesnastu",     "szesnascie",    "szesnascie",     "szesnastoma",     "szesnastu"}},
    ["siedemnascie"]   = {mos={"siedemnastu",    "siedemnastu",   "siedemnastu",   "siedemnastu",   "siedemnascie",   "siedemnastoma",   "siedemnastu"},
                          nmos={"siedemnascie",    "siedemnastu",   "siedemnastu",   "siedemnascie",  "siedemnascie",   "siedemnastoma",   "siedemnastu"}},
    ["osiemnascie"]    = {mos={"osiemnastu",     "osiemnastu",    "osiemnastu",    "osiemnastu",    "osiemnascie",    "osiemnastoma",    "osiemnastu"},
                          nmos={"osiemnascie",     "osiemnastu",    "osiemnastu",    "osiemnascie",   "osiemnascie",    "osiemnastoma",    "osiemnastu"}},
    ["dziewietnascie"] = {mos={"dziewietnascie", "dziewietnastu", "dziewietnastu", "dziewietnastu", "dziewietnascie", "dziewietnastoma", "dziewietnastu"},
                          nmos={"dziewietnascie",  "dziewietnastu", "dziewietnastu", "dziewietnascie","dziewietnascie", "dziewietnastoma", "dziewietnastu"}},
    ["dwadziescia"]    = {mos={"dwudziestu",     "dwudziestu",    "dwudziestu",    "dwudziestu",    "dwadziescia",    "dwudziestoma",    "dwudziestu"},
                          nmos={"dwadziescia",     "dwudziestu",    "dwudziestu",    "dwadziescia",   "dwadziescia",    "dwudziestoma",    "dwudziestu"}},
    ["wiele"]          = {mos={"wielu",          "wielu",         "wielu",         "wielu",         "wiele",          "wieloma",         "wielu"},
                          nmos={"wiele",           "wielu",         "wielu",         "wiele",         "wiele",          "wieloma",         "wielu"}},
}

local NUMERAL_FORMS = {}
local function build_numeral_index()
    for base, decl in pairs(NUMERAL_DECL) do
        NUMERAL_FORMS[base] = base
        for _, forms in pairs(decl) do
            for _, form in ipairs(forms) do
                if not NUMERAL_FORMS[form] then
                    NUMERAL_FORMS[form] = base
                end
            end
        end
    end
end
build_numeral_index()

-- BIE zalezy od zywotnosci: osobowy dostaje forme jak DOP, nieosob jak MIA
-- Kolumny wewnetrzne: 1=MIA 2=DOP 3=CEL 4=BIE_mos 5=BIE_nmos 6=NAR 7=MIE
local NUMERAL_COL = {
    [Grammar.MIA] = 1,
    [Grammar.DOP] = 2,
    [Grammar.CEL] = 3,
    [Grammar.BIE] = nil,  -- specjalny, patrz decline
    [Grammar.NAR] = 6,
    [Grammar.MIE] = 7,
}

local function numeral_gender_key(gender)
    if gender == Grammar.MESKI_OS                            then return "mos" end
    if gender == Grammar.ZENSKI                              then return "zen" end
    return "nmos"
end

local function is_osobowy(gender)
    return gender == Grammar.MESKI_OS or gender == Grammar.NIJAKI_OS
end

function Liczebnik:new(base_form)
    return setmetatable({ base_form = base_form }, self)
end

function Liczebnik:decline(case, gender)
    local decl = NUMERAL_DECL[self.base_form]
    if not decl then return self.base_form end
    local gkey  = numeral_gender_key(gender)
    local forms = decl[gkey] or decl.nmos
    if case == Grammar.BIE then
        return is_osobowy(gender) and forms[4] or forms[5]
    end
    local col = NUMERAL_COL[case]
    return col and forms[col] or self.base_form
end

function Liczebnik.is_numeral(word)
    return NUMERAL_FORMS[word] ~= nil or word:match("^%d+$") ~= nil
end

function Liczebnik.from_form(word)
    if word:match("^%d+$") then return Liczebnik:new(word) end
    local base = NUMERAL_FORMS[word]
    if not base then return nil end
    return Liczebnik:new(base)
end

-- "piec czarnych perel": od 5 w gore liczebnik w mianowniku/bierniku
-- wymaga dopelniacza l.mn. ("dwie czarne perly" - zgoda przypadku)
function Liczebnik:governs_genitive(case)
    if case ~= Grammar.MIA and case ~= Grammar.BIE then return false end
    local b = self.base_form
    if b == "dwa" or b == "trzy" or b == "cztery" then return false end
    local n = tonumber(b)
    if n then
        local last, last2 = n % 10, n % 100
        if n == 1 then return false end
        if last >= 2 and last <= 4 and not (last2 >= 12 and last2 <= 14) then return false end
    end
    return true
end

-- przypadek, w jakim stoja przymiotniki i rzeczownik po liczebniku
function Liczebnik:governed_case(case)
    return self:governs_genitive(case) and Grammar.DOP or case
end

-- =====================================================
-- DICTIONARY MANAGER
-- =====================================================

Dictionary = Dictionary or {
    nouns = {},  -- Base nouns (Rzeczownik objects)
    compounds = {},  -- Auto-generated compound nouns
    adjectives = {},  -- Irregular adjectives
    cache = {
        noun_lookups = {},
        adjective_forms = {}
    }
}

-- Add a noun to the dictionary
function Dictionary:add_noun(singular_forms, plural_forms, gender)
    gender = gender or Grammar.MESKI_OS
    if type(singular_forms) == "table" and #singular_forms == 0 then singular_forms = nil end
    if type(plural_forms)   == "table" and #plural_forms   == 0 then plural_forms   = nil end
    local noun = Rzeczownik:new(gender, singular_forms, plural_forms)
     self.nouns[noun:get_base_form()] = noun
    
     self:index_noun_forms(noun)
     return noun
 end
 
function Dictionary:index_noun_forms(noun)
    for case = 1, #Grammar.CASES do
        local singular_form = noun:get_form(case, false)
        local plural_form   = noun:get_form(case, true)

        if singular_form and singular_form ~= "" then
            self.cache.noun_lookups[singular_form] = {noun = noun, plural = false}
        end

        if plural_form and plural_form ~= "" then
            if not self.cache.noun_lookups[plural_form] then
                self.cache.noun_lookups[plural_form] = {noun = noun, plural = true}
            end
        end
    end
end

function Dictionary:find_noun(form)
    return self.cache.noun_lookups[form]
end

-- rzeczownik bez l.mn., ktorego forma podstawowa pasuje do podanych form l.mn.
-- ("turmalin" ~ "turmaliny", "perla" ~ "perlom"); zwraca nil gdy brak lub niejednoznaczne
function Dictionary:guess_singular(plural_forms)
    local best, best_len, ambiguous = nil, 0, false
    for base, noun in pairs(self.nouns) do
        if noun.singular and not noun.plural then
            local need = math.max(3, #base - 1)
            local len = 0
            for _, f in pairs(plural_forms) do
                if f ~= "?" then
                    local i = 0
                    while i < #base and base:sub(i + 1, i + 1) == f:sub(i + 1, i + 1) do i = i + 1 end
                    if i > len then len = i end
                end
            end
            if len >= need then
                if len > best_len then
                    best, best_len, ambiguous = noun, len, false
                elseif len == best_len then
                    ambiguous = true
                end
            end
        end
    end
    if ambiguous then return nil end
    return best
end

function Dictionary:load_from_file()
    local filename = getMudletHomeDir() .. "/dict.json"
    local file = io.open(filename, "r")
    if not file then
        scripts:print_log("Nie można otworzyć pliku do odczytu: " .. filename)
        return false
    end

    local content = file:read("*all")
    file:close()

    local data = yajl.to_value(content)
    if not data then
        scripts:print_log("Nieprawidłowy format JSON w pliku.")
        return false
    end
    self.nouns = {}
    self.cache.noun_lookups = {}

    for _, entry in ipairs(data) do
        if type(entry) == "table" then
			local singular = (entry[1] == false or entry[1] == nil) and {} or entry[1]
            local plural   = type(entry[2]) == "table" and entry[2] or nil
            local gender   = type(entry[2]) == "table" and entry[3] or entry[2] or Grammar.MESKI_OS
            self:add_noun(singular, plural, gender)
        end
    end

    return true
end

-- =====================================================
-- PHRASE 
-- =====================================================

Phrase = Phrase or {}
Phrase.__index = Phrase

function Phrase:new()
    return setmetatable({
        numeral  = nil,                 -- "2", "wiele", "trzy"
        pre_adjectives = {},            -- przymiotniki PRZED rzeczownikiem
        noun = nil,                     -- obiekt Rzeczownik
        post_adjectives = {},           -- przymiotniki PO rzeczowniku (rzadziej)
        post_phrase = ""                -- reszta po przyimku ("z kokardka", "porzucony na poboczu", "chaosu")
    }, self)
end

function Phrase:decline(case, number_hint)
	if not self.noun then return "" end
    local is_plural = number_hint or self.is_plural or false
    local parts = {}

    local inner = case
	if self.numeral then
        table.insert(parts, self.numeral:decline(case, self.noun.gender))
        inner = self.numeral:governed_case(case)
	end
    for _, adj in ipairs(self.pre_adjectives) do
        table.insert(parts, adj:decline(inner, self.noun.gender, is_plural))
    end

    table.insert(parts, self.noun:get_form(inner, is_plural))

    for _, adj in ipairs(self.post_adjectives) do
        table.insert(parts, adj:decline(inner, self.noun.gender, is_plural))
    end

    if self.post_phrase ~= "" then
        table.insert(parts, self.post_phrase)
    end

    return table.concat(parts, " ")
end

function Phrase:declineCore(case, number_hint)
	if not self.noun then return "" end
    local is_plural = number_hint or self.is_plural or false
    local parts = {}

    for _, adj in ipairs(self.pre_adjectives) do
        table.insert(parts, adj:decline(case, self.noun.gender, is_plural))
    end
    table.insert(parts, self.noun:get_form(case, is_plural))

    return table.concat(parts, " ")
end
-- =====================================================
-- PHRASE PARSER
-- =====================================================

PhraseParser = PhraseParser or {
    dictionary = Dictionary
}

function PhraseParser:tokenize(phrase)
    return string.split(phrase, " ")
end

function PhraseParser:extract_post_phrase(words)
    for i, word in ipairs(words) do
        if Grammar.PREPOSITIONS[word] then
            local post_phrase = table.concat(words, " ", i)
            local main_words = {unpack(words, 1, i - 1)}
            return main_words, post_phrase
        end
    end
    return words, ""
end

function PhraseParser:slice(tbl, start, finish)
    local result = {}
    finish = finish or #tbl
    for i = start, finish do
        result[#result + 1] = tbl[i]
    end
    return result
end

function PhraseParser:parse(phrase, case, number_hint)
    if not phrase or phrase:match("^%s*$") then
        return Phrase:new()
    end

    local words = self:tokenize(phrase)
    local main_words, post_phrase_from_preposition = self:extract_post_phrase(words)

    local result = Phrase:new()
    result.post_phrase = post_phrase_from_preposition or ""

    if #main_words == 0 then
        return result
    end

    -- liczebnik na poczatku: fraza jest w l.mn., a od "piec" w gore
    -- przymiotniki i rzeczownik stoja w dopelniaczu ("piec czarnych perel")
    local first = main_words[1]:lower()
    local start_idx = 1
    local inner_case = case
    if Liczebnik.is_numeral(first) then
        result.numeral = Liczebnik.from_form(first)
        inner_case = result.numeral:governed_case(case)
        start_idx = 2
    end

    local noun_idx = nil
    local is_plural = nil

    for i = start_idx, #main_words do
        local word = main_words[i]:lower()
        local entry = self.dictionary:find_noun(word, inner_case)
        if entry and entry.noun then
			local prev = main_words[i-1]
			if i == start_idx or self:looks_like_adjective(prev:lower(), inner_case) then
				noun_idx = i
				is_plural = self:form_number(entry.noun, word, inner_case)
				if is_plural == nil and i > start_idx then
					-- forma rzeczownika niejednoznaczna ("rekawice": BIE l.poj. / MIA l.mn.),
					-- rozstrzygamy po zgodzie z przymiotnikiem ("brazowe" -> l.mn.)
					is_plural = self:adjective_number(prev:lower(), entry.noun.gender, inner_case)
				end
				if is_plural == nil then is_plural = entry.plural end
				break
			end
        end
    end

    if not noun_idx then
        return result
    end

    local noun_entry = self.dictionary:find_noun(main_words[noun_idx]:lower(), inner_case)
    result.noun = noun_entry.noun
    if result.numeral then is_plural = true end
    if number_hint ~= nil then is_plural = number_hint end
    result.is_plural = is_plural

    local pre_words  = self:slice(main_words, start_idx, noun_idx - 1)
    local post_words = self:slice(main_words, noun_idx + 1)
	if #pre_words > 0 then pre_words[1] = pre_words[1]:lower() end
    self:parse_pre_adjectives(pre_words, result, inner_case)
    self:parse_post_part(post_words, result, inner_case)

    return result
end

-- czy przymiotnik 'word' stoi w l.mn. dla danego rodzaju i przypadku? nil = nie wiadomo
function PhraseParser:adjective_number(word, gender, case)
    if not case then return nil end
    local function matches(plural)
        local adj = AdjectiveRules:convert_to_base_form(word, case, gender, plural)
        return adj ~= nil and adj:decline(case, gender, plural) == word
    end
    local sg, pl = matches(false), matches(true)
    if pl and not sg then return true end
    if sg and not pl then return false end
    return nil
end

-- czy 'word' to forma l.mn. rzeczownika w danym przypadku?
-- slownik indeksuje formy globalnie, wiec "perly" (DOP l.poj. == MIA l.mn.)
-- trzeba rozstrzygnac po przypadku. nil = nie da sie stwierdzic
function PhraseParser:form_number(noun, word, case)
    if not case then return nil end
    local sg = noun.singular ~= nil and noun:get_form(case, false) == word
    local pl = noun.plural ~= nil and noun:get_form(case, true) == word
    if pl and not sg then return true end
    if sg and not pl then return false end
    return nil
end

function PhraseParser:parse_pre_adjectives(words, phrase, case)
    for _, word in ipairs(words) do
        if Liczebnik.is_numeral(word) then
            phrase.numeral = Liczebnik.from_form(word)
		elseif self:looks_like_adjective(word, case) then
            local adj = AdjectiveRules:convert_to_base_form(word, case, phrase.noun.gender, phrase.is_plural)
            if adj then
                table.insert(phrase.pre_adjectives, adj)
            end
        end
    end
end

function PhraseParser:parse_post_part(words, phrase, case)
    if #words == 0 then return end

    local post_adj = {}
    local remaining = {}

    for _, word in ipairs(words) do
		if self:looks_like_adjective(word, case) then
            local adj = AdjectiveRules:convert_to_base_form(
                word, case, phrase.noun.gender, phrase.is_plural
            )

            if self:is_valid_adjective_form(word, adj, case, phrase.noun.gender, phrase.is_plural) then
                table.insert(post_adj, adj)
            else
                table.insert(remaining, word)
            end
		else
            table.insert(remaining, word)
		end
	end
    phrase.post_adjectives = post_adj

    if #remaining > 0 then
        local tail = table.concat(remaining, " ")
        if phrase.post_phrase ~= "" then
            phrase.post_phrase = tail .. " " .. phrase.post_phrase
        else
            phrase.post_phrase = tail
        end
    end
end

local function candidate_base_forms(word)
    local candidates = {}
    -- Try stripping each possible ending and reconstructing a base form.
    -- We enumerate suffixes ordered longest-first so a longer match wins.
    local suffixes = {
        -- hard endings → base in -y
        {"owego",  "y"}, {"owej",  "y"}, {"owemu", "y"},
        {"owym",   "y"}, {"owymi", "y"},
        {"ego",    "y"}, {"emu",   "y"}, {"ymi",   "y"},
        {"ych",    "y"}, {"ym",    "y"},   -- l.mn. DOP/MIE/CEL ("czarnych perel")
        -- soft endings → base in -i  (ki/gi → soft, others → soft_i)
        {"iego",   "i"}, {"iemu",  "i"}, {"imi",   "i"}, {"ich",   "i"}, {"im",    "i"},
        -- single-char (must come last)
        {"y", "y"}, {"i", "i"}, {"a", nil}, {"e", nil},
    }
    for _, pair in ipairs(suffixes) do
        local suf, base_suffix = pair[1], pair[2]
        if #word > #suf and word:sub(-#suf) == suf then
            local stem = word:sub(1, -(#suf + 1))
            if base_suffix then
                candidates[#candidates + 1] = stem .. base_suffix
            else
                -- "-a" and "-e" are ambiguous: try both hard and soft bases
                candidates[#candidates + 1] = stem .. "y"
                candidates[#candidates + 1] = stem .. "i"
                candidates[#candidates + 1] = stem .. "ia"  -- soft_i feminine nom
            end
        end
    end
    return candidates
end

function PhraseParser:looks_like_adjective(word, case)
    if not word or #word < 2 then return false end
    if word:match("^%d") then return false end

    -- case unknown (used as pure guard in some callers) → fall back to heuristic
    if not case then
        local last = word:sub(-1)
        return last == "y" or last == "i" or last == "a" or last == "e"
            or word:match("ego$") ~= nil or word:match("emu$") ~= nil
            or word:match("[yi]m$") ~= nil or word:match("[yi]mi$") ~= nil
    end

    local genders = {
        Grammar.MESKI_OS, Grammar.MESKI_NOS_ZYW, Grammar.MESKI_NOS_NZYW,
        Grammar.ZENSKI, Grammar.NIJAKI_OS, Grammar.NIJAKI_NOS,
    }
    for _, base_form in ipairs(candidate_base_forms(word)) do
        local ok, adj = pcall(Przymiotnik.new, Przymiotnik, base_form)
        if ok and adj then
            for _, gender in ipairs(genders) do
                for _, plural in ipairs({false, true}) do
                    if adj:decline(case, gender, plural) == word then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function PhraseParser:is_valid_adjective_form(word, adj, case, gender, number)
    if not adj then return false end
    local declined = adj:decline(case, gender, number)
    if declined ~= word then return false end
	return true
end

function PhraseParser:get_form(phrase_obj, case, number_hint)
    return phrase_obj:decline(case, number_hint)
end

function PhraseParser:debugParse(phrase, case)
    case = case or Grammar.MIA
    local p = self:parse(phrase, case)
    
    scripts:print_log("=== DEBUG: \"" .. phrase .. "\"")
    scripts:print_log("Noun           : " .. (p.noun and p.noun:get_base_form() or "NIL"))
    scripts:print_log("Pre adjectives : " .. #p.pre_adjectives)
    for i, adj in ipairs(p.pre_adjectives) do
        scripts:print_log("   " .. i .. ": " .. (adj.base_form or "???"))
    end
    scripts:print_log("Post adjectives: " .. #p.post_adjectives)
    scripts:print_log("Post phrase    : \"" .. (p.post_phrase or "") .. "\"")
    scripts:print_log("Full decline   : " .. p:decline(Grammar.MIA))
    
    return p
end

-- =====================================================
-- GRAMMAR TEST RUNNER
-- Wczytuje dict_test.json i sprawdza poprawnosc odmiany
-- Format pliku: [["mianownik","dopelniacz","celownik","biernik","narzednik","miejscownik"]]
-- =====================================================

local function gender_name(g)
    return Grammar.GENDERS[g] or ("rodzaj_" .. tostring(g))
end

-- Wykryj rodzaj gramatyczny rzeczownika na podstawie 6 form calej frazy.
-- Heurystyka dziala na ostatnim slowie frazy mianownikowej (rzeczowniku),
-- a nastepnie rozroznia zywotnosc przez porownanie biernika z dopelniaczem/mianownikiem.
function Grammar:detect_gender_from_forms(forms, is_plural)
    is_plural = is_plural or false
    local words = {}
    for c = Grammar.MIA, Grammar.MIE do
        words[c] = PhraseParser:tokenize(forms[c])
	end

    -- liczebnik: fraza w l.mn.; czesc liczebnikow sama zdradza rodzaj
    local start = 1
    local numeral = nil
    local num_word = (words[Grammar.MIA][1] or ""):lower()
    if Liczebnik.is_numeral(num_word) then
        numeral = Liczebnik.from_form(num_word)
        is_plural = true
        start = 2
        if num_word == "dwie" then return Grammar.ZENSKI end
        if num_word:match("j$") or num_word:match("u$") then return Grammar.MESKI_OS end -- dwaj, trzej, pieciu
    end

    if is_plural then
        -- w l.mn. rozroznic sie da tylko meskoosobowy vs reszta:
        -- meskoosobowy ma biernik == dopelniacz ("dzielnych rycerzy")
        local bie = words[Grammar.BIE][#words[Grammar.BIE]]
        local dop = words[Grammar.DOP][#words[Grammar.DOP]]
        local mia = words[Grammar.MIA][#words[Grammar.MIA]]
        local governs = numeral and numeral:governs_genitive(Grammar.MIA)
        if not governs and bie == dop and bie ~= mia then return Grammar.MESKI_OS end
        return nil
    end

    if #words[Grammar.MIA] > start then
		local best_gender, best_score = Grammar.MESKI_OS, -1
		for _, gender in ipairs({Grammar.MESKI_OS, Grammar.MESKI_NOS_NZYW, Grammar.ZENSKI, Grammar.NIJAKI_NOS}) do
			local first_adj = AdjectiveRules:convert_to_base_form(words[Grammar.MIA][start], Grammar.MIA, gender, is_plural)
			local score = 0
			for c = Grammar.MIA, Grammar.MIE do
				if first_adj:decline(c, gender, is_plural) == words[c][start] then
					score = score + 1
				end
			end
			if score > best_score then
				best_score = score
				best_gender = gender
			end
		end
		return best_gender
	end

    local bie = words[Grammar.BIE][start]
    local dop = words[Grammar.DOP][start]
    local mia = words[Grammar.MIA][start]
    if bie == dop and bie ~= mia then return Grammar.MESKI_OS end
    if bie == mia then return nil end
    if mia:sub(-1) == "a" then return Grammar.ZENSKI end
    if mia:sub(-1) == "o" or mia:sub(-1) == "e" then return Grammar.NIJAKI_NOS end
    return nil
end

-- =====================================================
-- GENERYCZNA CZESC check_trigger (bez multimatches)
-- Przyjmuje formy jako tabele zamiast globalnego multimatches
-- forms:   tabela 6 stringow { mia, dop, cel, bie, nar, mie }
-- Zwraca liste roznic: { {case_name, expected, got, [suggestion]} }
-- Zwraca nil jesli wpis nalezy pominac (imie wlasne)
-- =====================================================
-- formy rzeczownika (slowo na pozycji 'pos') ze wszystkich 6 przypadkow frazy;
-- tam gdzie liczebnik wymusza dopelniacz (MIA/BIE od "piec"), forma jest nieznana -> "?"
function PhraseParser:noun_forms_from(forms, pos, numeral)
    local out = {}
    for c = Grammar.MIA, Grammar.MIE do
        local case_words = self:tokenize(forms[c])
        case_words, _ = self:extract_post_phrase(case_words)
        if numeral and numeral:governs_genitive(c) then
            out[c] = "?"
        else
            out[c] = case_words[pos] or "?"
        end
    end
    return out
end

-- "?" z frazy uzupelniamy tym, co juz jest w slowniku
function PhraseParser:merge_plural(plural, existing)
    if not existing then return plural end
    local out = {}
    for c = Grammar.MIA, Grammar.MIE do
        out[c] = (plural[c] == "?" and existing[c]) or plural[c]
    end
    return out
end

-- wpis do dict.json: [[l.poj.],[l.mn.],rodzaj] / [[l.poj.],rodzaj] / [[],[l.mn.],rodzaj]
function PhraseParser:format_entry(singular, plural, gender)
    local function list(t)
        local q = {}
        for _, f in ipairs(t) do q[#q + 1] = '"' .. f .. '"' end
        return "[" .. table.concat(q, ",") .. "]"
    end
    local g = gender and tostring(gender) or "?"
    if plural then
        return "[" .. (singular and list(singular) or "[]") .. "," .. list(plural) .. "," .. g .. "],"
    end
    return "[" .. list(singular) .. "," .. g .. "],"
end

function PhraseParser:check_forms(forms)
    local short = forms[Grammar.MIA]
	local l = short:sub(1,1)
    if l:upper() == l then
        return nil
    end
	
 
    local differences = {}
    local entry = PhraseParser:parse(short, Grammar.MIA)
    local odmiana = entry.noun
 
    if odmiana ~= nil then
        local numeral_count = entry.numeral and 1 or 0
		local post_start = numeral_count + #entry.pre_adjectives + 1 + 1


        local mia_words = self:tokenize(short)
        mia_words, _ = self:extract_post_phrase(mia_words)
        local post_words_mia = self:slice(mia_words, post_start)

        if #post_words_mia > 0 then
            local confirmed_post_adj = {}
            local confirmed_post_phrase = {}

            for wi, word in ipairs(post_words_mia) do
                local word_idx = post_start + wi - 1
                local all_same = true
                for c = Grammar.DOP, Grammar.MIE do
                    local cwords = self:tokenize(forms[c])
                    cwords, _ = self:extract_post_phrase(cwords)
                    if (cwords[word_idx] or "") ~= word then
                        all_same = false
                        break
                    end
                end

                if all_same then
                    table.insert(confirmed_post_phrase, word)
                else
                    local adj = AdjectiveRules:convert_to_base_form(word, Grammar.MIA, odmiana.gender, entry.is_plural)
                    if adj then
                        table.insert(confirmed_post_adj, adj)
                    else
                        table.insert(confirmed_post_phrase, word)
                   end
                end
            end

            entry.post_adjectives = confirmed_post_adj
            local confirmed_tail = table.concat(confirmed_post_phrase, " ")
            entry.post_phrase = confirmed_tail ~= "" and confirmed_tail or entry.post_phrase
        end
    end
 
    if odmiana == nil then
        local words = self:tokenize(short)
        words, _ = self:extract_post_phrase(words)
 
        local noun_start = 1
        if #words > 1 then
            local fw = words[1]
            local fw_last = fw:sub(-1)
            local looks_like_adj = (fw_last == "y" or fw_last == "i" or fw_last == "a" or fw_last == "e")
            if looks_like_adj then
                local first_adj = Przymiotnik:new(fw)
                if first_adj and first_adj.declension_rules then
                    local gender = Przymiotnik:detect_gender_from_form(fw)
                    local expected_ending = AdjectiveRules:get_endings(Grammar.MIA, gender, false, first_adj.declension_rules)
                    for i = 2, #words do
                        if expected_ending ~= "" and words[i]:sub(-#expected_ending) == expected_ending then
                            noun_start = i + 1
                        else
                            break
                        end
                    end
                end
            end
        end
 
        local noun_end = #words
        for i = #words, noun_start, -1 do
            local all_same = true
            for c = Grammar.DOP, Grammar.MIE do
                local case_words = self:tokenize(forms[c])
                case_words, _ = self:extract_post_phrase(case_words)
                if case_words[i] ~= words[i] then
                    all_same = false
                    break
                end
            end
            if all_same then
                noun_end = i - 1
            else
                break
            end
        end
 
        local numeral = Liczebnik.is_numeral(words[1]:lower()) and Liczebnik.from_form(words[1]:lower()) or nil
        local noun_forms = self:noun_forms_from(forms, noun_end, numeral)

        local suggestion
        if numeral then
            -- fraza z liczebnikiem daje tylko l.mn.; l.poj. bierzemy z pasujacego
            -- wpisu bez l.mn. (np. "turmalin" dla "turmaliny"), inaczej do uzupelnienia
            local gender_out = Grammar:detect_gender_from_forms(forms, true)
            local sg_noun = self.dictionary:guess_singular(noun_forms)
            if sg_noun then
                suggestion = self:format_entry(sg_noun.singular, self:merge_plural(noun_forms, nil), gender_out or sg_noun.gender)
                    .. "   <- zastap wpis '" .. sg_noun:get_base_form() .. "'"
            else
                suggestion = self:format_entry(nil, noun_forms, gender_out) .. "   <- uzupelnij l.poj."
            end
        else
            local gender_out = Grammar.MESKI_OS
            local last_char = words[noun_end] and words[noun_end]:sub(-1) or ""
            if last_char == "a" then gender_out = Grammar.ZENSKI
            elseif last_char == "e" or last_char == "o" then gender_out = Grammar.NIJAKI_NOS
            end
            suggestion = self:format_entry(noun_forms, nil, gender_out)
        end
        table.insert(differences, {
            case_name = "BRAK W SLOWNIKU",
            expected = short,
            got = nil,
            suggestion = suggestion
        })
        return differences
    end
 
    local estimated_gender = Grammar:detect_gender_from_forms(forms, entry.is_plural)

    -- fraza w l.mn. (np. z liczebnikiem): sprawdz czy slownik ma poprawna l.mn.
    if entry.is_plural and not odmiana:is_plurale_tantum() then
        local tokens = self:tokenize(short)
        tokens, _ = self:extract_post_phrase(tokens)
        local noun_pos = (entry.numeral and 1 or 0) + #entry.pre_adjectives + 1
        local plural = self:noun_forms_from(forms, noun_pos, entry.numeral)
        local gender = estimated_gender or odmiana.gender
        local suggestion = self:format_entry(odmiana.singular, self:merge_plural(plural, odmiana.plural), gender)

        if odmiana.plural == nil then
            table.insert(differences, {
                case_name  = "BRAK L.MN.",
                expected   = "l.mn. dla '" .. odmiana:get_base_form() .. "'",
                got        = "brak",
                suggestion = suggestion
            })
            return differences
        end

        for c = Grammar.MIA, Grammar.MIE do
            if plural[c] ~= "?" and plural[c] ~= odmiana:get_form(c, true) then
                differences.suggestion = suggestion
                break
            end
        end
        if estimated_gender and estimated_gender ~= odmiana.gender then
            differences.suggestion = suggestion
        end
    end

 	if is_definitely_plural then
		if odmiana:is_plurale_tantum() then
			is_definitely_plural = false
		end
	end

	if is_definitely_plural then
		local noun_forms = {}
		for c = Grammar.MIA, Grammar.MIE do
			local case_words = self:tokenize(forms[c])
			case_words, _ = self:extract_post_phrase(case_words)
			table.insert(noun_forms, '"' .. (case_words[#case_words] or "") .. '"')
		end
		local suggestion = "[[],["  .. table.concat(noun_forms, ",") .. "]," .. entry.noun.gender .. "],"
		table.insert(differences, {
			case_name  = "PLURALE_TANTUM",
			expected   = "wpis jako plural [[],forms,gender]",
			got        = "wpis jako singular [forms,gender]",
			suggestion = suggestion
		})
		return differences
	end
	

    if estimated_gender and estimated_gender ~= odmiana.gender then
        table.insert(differences, {
            case_name = "RODZAJ",
            expected = Grammar.GENDERS[estimated_gender] .. " (" .. estimated_gender .. ")",
            got      = Grammar.GENDERS[odmiana.gender]   .. " (" .. odmiana.gender .. ")"
        })
    end
 

    for i = Grammar.DOP, Grammar.MIE do
        local generated = entry:decline(i, entry.is_plural)
        local expected  = forms[i]
        if generated ~= expected then
            table.insert(differences, {
                case_name = Grammar.CASES[i],
                expected  = expected,
                got       = generated
            })
        end
    end
 
    return differences
end

-- =====================================================
-- WSPOLNA FUNKCJA DRUKOWANIA ROZNIC
-- idx:   numer testu (lub nil dla check_trigger)
-- mia:   mianownik frazy
-- diffs: tabela roznic z check_forms
-- =====================================================
local function print_diffs(idx, mia, diffs)
    if #diffs == 0 then return end
    local prefix = idx and string.format("[TEST #%d]", idx) or "[TRIGGER]"

    local first = diffs[1].case_name
    if first == "BRAK W SLOWNIKU" then
        scripts:print_log(string.format("%s BRAK W SLOWNIKU: \"%s\"", prefix, mia))
        scripts:print_log("  Sugerowany wpis: " .. (diffs[1].suggestion or "?"))
    elseif first == "BRAK L.MN." then
        scripts:print_log(string.format("%s BRAK L.MN. W SLOWNIKU: \"%s\"", prefix, mia))
        scripts:print_log("  Sugerowany wpis: " .. (diffs[1].suggestion or "?"))
    elseif first == "PLURALE_TANTUM" then
        scripts:print_log(string.format("%s PLURALE TANTUM: \"%s\"", prefix, mia))
        scripts:print_log("  Sugerowany wpis: " .. (diffs[1].suggestion or "?"))
    else
        scripts:print_log(string.format("%s ROZNICE dla: \"%s\"", prefix, mia))
        for _, diff in ipairs(diffs) do
            scripts:print_log(string.format(
                "  %-14s  oczekiwano: %-25s  w bazie: %s",
                diff.case_name, diff.expected, diff.got or "nil"))
        end
        if diffs.suggestion then
            scripts:print_log("  Sugerowany wpis: " .. diffs.suggestion)
        end
    end
end

function PhraseParser:check_trigger()
    local forms = {
        multimatches[1][2],
        multimatches[2][2],
        multimatches[3][2],
        multimatches[4][2],
        multimatches[5][2],
        multimatches[6][2],
    }

    local diffs = PhraseParser:check_forms(forms)
    if diffs then
        print_diffs(nil, forms[Grammar.MIA], diffs)
    end
end
-- =====================================================
-- TEST RUNNER
-- =====================================================
function Grammar.run_dict_test(filename)
    filename = filename or (getMudletHomeDir() .. "/dict_test.json")

    local file = io.open(filename, "r")
    if not file then
        scripts:print_log("[TEST] Nie mozna otworzyc: " .. filename)
        return
    end

    local content = file:read("*all")
    file:close()

    local data = yajl.to_value(content)
    if not data or type(data) ~= "table" then
        scripts:print_log("[TEST] Nieprawidlowy JSON w: " .. filename)
        return
    end

    local total    = 0
    local passed   = 0
    local failed   = 0
    local missing  = 0
    local plurale  = 0
    local skipped  = 0

    for idx, entry in ipairs(data) do
        local n = type(entry) == "table" and #entry or -1
        if n < 6 then
            scripts:print_log(string.format("[TEST] Wpis #%d: za malo form (%d zamiast 6), pomijam.", idx, n))
        else
            local forms = { entry[1], entry[2], entry[3], entry[4], entry[5], entry[6] }

            local diffs = PhraseParser:check_forms(forms)

            if diffs == nil then
                skipped = skipped + 1
                -- Odkomentuj jesli chcesz widziec pomijane imiona:
                -- scripts:print_log(string.format("[TEST #%d] POMINIETO (imie wlasne): %s", idx, entry[1]))
            else
                total = total + 1
                local mia = entry[1]

                if #diffs == 0 then
                    passed = passed + 1
                    -- Odkomentuj ponizej, jesli chcesz widziec tez przejscia:
                    -- scripts:print_log(string.format("[TEST #%d] OK: %s", idx, mia))
                else
                    local first = diffs[1].case_name
                    if first == "BRAK W SLOWNIKU" or first == "BRAK L.MN." then missing = missing + 1
                    elseif first == "BRAK L.MN." then
        scripts:print_log(string.format("%s BRAK L.MN. W SLOWNIKU: \"%s\"", prefix, mia))
        scripts:print_log("  Sugerowany wpis: " .. (diffs[1].suggestion or "?"))
    elseif first == "PLURALE_TANTUM" then plurale = plurale + 1
                    else failed = failed + 1 end
                    print_diffs(idx, mia, diffs)
                end
            end
        end
    end

    scripts:print_log(string.format(
        "[TEST] Wynik: %d/%d OK | %d roznic | %d brakujacych w slowniku | %d plurale tantum | %d pominieto (imiona)",
        passed, total, failed, missing, plurale, skipped))
end

function Dictionary:okno()
	reload_single_script("mcuderz.grammar_window")
end

Dictionary:load_from_file()
