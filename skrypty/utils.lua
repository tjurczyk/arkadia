scripts["utils"] = scripts["utils"] or {}


local num = {
    ["jednej"] = 1,
    ["dwoch"] = 2,
    ["trzech"] = 3,
    ["czterech"] = 4,
    ["pieciu"] = 5,
    ["szesciu"] = 6,
    ["siedmiu"] = 7,
    ["osmiu"] = 8,
    ["dziewieciu"] = 9,
    ["dziesieciu"] = 10,
    ["jedenastu"] = 11,
    ["dwunastu"] = 12,
    ["trzynastu"] = 13,
    ["czternastu"] = 14,
    ["pietnastu"] = 15,
    ["szesnastu"] = 16,
    ["siedemnastu"] = 17,
    ["osiemnastu"] = 18,
    ["dziewietnastu"] = 19,
}
local tens = {
    ["dwudziestu"] = 20,
    ["trzydziestu"] = 30,
    ["czterdziestu"] = 40,
    ["piecdziesieciu"] = 50,
    ["szescdziesieciu"] = 60,
    ["siedemdziesieciu"] = 70,
    ["osiemdziesieciu"] = 80,
    ["dziewiecdziesieciu"] = 90
}

local append = {
    ["jeden"] = 1,
    ["dwoch"] = 2,
    ["trzech"] = 3,
    ["czterech"] = 4,
    ["pieciu"] = 5,
    ["szesciu"] = 6,
    ["siedmiu"] = 7,
    ["osmiu"] = 8,
    ["dziewieciu"] = 9,
}

scripts.counted_string_to_int = {}

setmetatable(scripts.counted_string_to_int, {
    __index = function(table, key)
        if num[key] then
            return num[key]
        else
            local parts = key:split(" ")
            if #parts == 1 then
                return tens[parts[1]]
            end
            if #parts == 2 then
                return tens[parts[1]] + append[parts[2]]
            end
            return nil
        end
    end
})

scripts.string_to_liczebnik = {
    ["dwa"] = 2,
    ["dwie"] = 2,
    ["dwoje"] = 2,
    ["dwaj"] = 2,
    ["dwoch"] = 2,
    ["trzy"] = 3,
    ["troje"] = 3,
    ["trzej"] = 3,
    ["trzech"] = 3,
    ["cztery"] = 4,
    ["czworo"] = 4,
    ["czterech"] = 4,
    ["czterej"] = 4,
    ["piec"] = 5,
    ["piecioro"] = 5,
    ["szesc"] = 6,
    ["szescioro"] = 6,
    ["siedem"] = 7,
    ["siedmioro"] = 7,
    ["osiem"] = 8,
    ["osmioro"] = 8,
    ["dziewiec"] = 9,
    ["dziewiecioro"] = 9,
    ["dziesiec"] = 10,
    ["jedenascie"] = 11,
    ["dwanascie"] = 12,
    ["trzynascie"] = 13,
    ["czternascie"] = 14,
    ["pietnascie"] = 15,
    ["szesnascie"] = 16,
    ["siedemnascie"] = 17,
    ["osiemnascie"] = 18,
    ["dziewietnascie"] = 19,
    ["dwadziescia"] = 20,
    ["dwadziescia jeden"] = 21,
    ["dwadziescia dwa"] = 22,
    ["dwadziescia trzy"] = 23,
    ["dwadziescia cztery"] = 24,
    ["dwadziescia piec"] = 25,
    ["dwadziescia szesc"] = 26,
    ["dwadziescia siedem"] = 27,
    ["dwadziescia osiem"] = 28,
    ["dwadziescia dziewiec"] = 29,
    ["trzydziesci"] = 30,
    ["trzydziesci jeden"] = 31,
    ["trzydziesci dwa"] = 32,
    ["trzydziesci trzy"] = 33,
    ["trzydziesci cztery"] = 34,
    ["trzydziesci piec"] = 35,
    ["trzydziesci szesc"] = 36,
    ["trzydziesci siedem"] = 37,
    ["trzydziesci osiem"] = 38,
    ["trzydziesci dziewiec"] = 39,
    ["czterdziesci"] = 40,
}

scripts["tcolor_color"] = "orange"

function scripts:check_gmcp(silent)
    if not next(gmcp) then
        if not silent then
            scripts:print_log("Wyglada na to, ze GMCP nie jest wlaczone. Skrypty nie beda dzialac")
        end
        return false
    end
    return true
end

-- in template, all 'x' characters are replaced with random a-zA-Z0-9.
function generate_uuid(template)
    return string.gsub(template, '[xy]', function(c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

function scripts:get_table_without_first_item(arr)
    if not arr then
        error("Wrong input")
    end

    local items = {}
    for k, v in pairs(arr) do
        if k > 1 then
            table.insert(items, v)
        end
    end

    return items
end
