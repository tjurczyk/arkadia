scripts.inv["available_types"] = {
    ["money"] = true,
    ["gems"] = true,
    ["food"] = true,
    ["other"] = true,
}

scripts.inv["bag_name"] = {
    ["plecak"] = 1,
    ["torba"] = 2,
    ["worek"] = 3,
    ["sakiewka"] = 4,
    ["mieszek"] = 5,
    ["sakwa"] = 6,
    ["wor"] = 7,
    ["szkatulka"] = 8,
}

scripts.inv["bag_in_dopelniacz"] = {
    ["plecak"] = "plecaka",
    ["torba"] = "torby",
    ["worek"] = "worka",
    ["sakiewka"] = "sakiewki",
    ["mieszek"] = "mieszka",
    ["sakwa"] = "sakwy",
    ["wor"] = "wora",
    ["szkatulka"] = "szkatulki",
}

scripts.inv["bag_in_biernik"] = {
    ["plecak"] = "plecak",
    ["torba"] = "torbe",
    ["worek"] = "worek",
    ["sakiewka"] = "sakiewke",
    ["mieszek"] = "mieszek",
    ["sakwa"] = "sakwe",
    ["wor"] = "wor",
    ["szkatulka"] = "szkatulke",
}

local pronouns = {
    m = { biernik = "swoj", dopelniacz = "swojego" },
    f = { biernik = "swoja", dopelniacz = "swojej" }
}

scripts.inv["bag_pronouns"] = {
    ["plecak"] = pronouns.m,
    ["torba"] = pronouns.f,
    ["worek"] = pronouns.m,
    ["sakiewka"] = pronouns.f,
    ["mieszek"] = pronouns.m,
    ["sakwa"] = pronouns.f,
    ["wor"] = pronouns.m,
    ["szkatulka"] = pronouns.f
}

scripts.inv["money_bag_1"] = "plecak"
scripts.inv["gems_bag_1"] = "plecak"
scripts.inv["food_bag_1"] = "plecak"
scripts.inv["other_bag_1"] = "plecak"


function alias_func_skrypty_inventory_bags_wez_monety()
    scripts.inv:get_from_bag({ "monety" }, "money", 1)
end

function alias_func_skrypty_inventory_bags_wez_monety_id()
    scripts.inv:get_from_bag({ "monety" }, "money", tonumber(matches[2]))
end

function alias_func_skrypty_inventory_bags_wloz_monety()
    scripts.inv:put_into_bag({ "monety" }, "money", 1)
end

function alias_func_skrypty_inventory_bags_wloz_monety_id()
    scripts.inv:put_into_bag({ "monety" }, "money", tonumber(matches[2]))
end

function alias_func_skrypty_inventory_bags_pojemniki_help()
    scripts:bags_print_help()
end

function alias_func_skrypty_inventory_bags_wdp()
    scripts.inv:wdp_id(1, matches[2])
end

function alias_func_skrypty_inventory_bags_wdp_id()
    scripts.inv:wdp_id(tonumber(matches[2]), matches[3])
end

function alias_func_skrypty_inventory_bags_wzp()
    scripts.inv:wzp_id(1, matches[2])
end

function alias_func_skrypty_inventory_bags_wzp_id()
    scripts.inv:wzp_id(tonumber(matches[2]), matches[3])
end

function alias_func_skrypty_inventory_bags_wlp()
    scripts.inv:wdp_id(1, "pocztowa paczke")
end

function alias_func_skrypty_inventory_bags_wlp_id()
    scripts.inv:wdp_id(tonumber(matches[2]), "pocztowa paczke")
end

function alias_func_skrypty_inventory_bags_wep()
    scripts.inv:wzp_id(1, "pocztowa paczke")
end

function alias_func_skrypty_inventory_bags_wep_id()
    scripts.inv:wzp_id(tonumber(matches[2]), "pocztowa paczke")
end

