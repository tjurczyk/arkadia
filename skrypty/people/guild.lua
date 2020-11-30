scripts.people.guilds = {
    ["CKN"] = 1,
    ["ES"] = 2,
    ["SC"] = 3,
    ["KS"] = 4,
    ["KM"] = 5,
    ["OS"] = 6,
    ["OHM"] = 7,
    ["SGW"] = 8,
    ["PE"] = 9,
    ["WKS"] = 10,
    ["LE"] = 11,
    ["KG"] = 12,
    ["KGKS"] = 13,
    ["MC"] = 14,
    ["OK"] = 15,
    ["RA"] = 16,
    ["GL"] = 17,
    ["ZT"] = 18,
    ["ZS"] = 19,
    ["ZH"] = 20,
    ["NPC"] = 21,
    ["GP"] = 22
}

function scripts.people:print_guilds()
    local str_guilds = "Wspierane symbole Gildii: "
    for k, v in pairs(scripts.people["guilds"]) do
        str_guilds = str_guilds .. k .. ", "
    end

    scripts:print_log(str_guilds)
end

function scripts.people:get_guild_name(code)
    if not code then
        error("Wrong input")
    end

    for k, v in pairs(scripts.people["guilds"]) do
        if v == tonumber(code) then
            return k
        end
    end

    return nil
end

