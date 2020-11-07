scripts.inv.equipment.extended_evaluation = scripts.inv.equipment.extended_evaluation or {
    handler = nil
}

local value_keys = {
    "wywazenie",
    "obrazenia",
    "klute",
    "obuchowe",
    "ciete",
    "parowanie"
}

function scripts.inv.equipment.extended_evaluation:init()
    self.handler = scripts.event_register:register_singleton_event_handler(self.handler, "equipmentEvaluation", function(_, equipment)
        self:evaluate(equipment)
    end)
end

function scripts.inv.equipment.extended_evaluation:evaluate(equipment)
    if equipment.typSprzetu == "puklerz" then
        return
    end
    local sum, count = 0, 0
    for _, value_key in pairs(value_keys) do
        if equipment[value_key] and equipment[value_key].value then
            sum = sum + equipment[value_key].value
            count = count + 1
        end
    end
    echo("\n\n")
    cecho("<light_slate_blue>" .. string.sub(" Suma: <grey>" .. sum .. "                                            ", 0, 50))
    cecho("<light_slate_blue> " .. string.sub("Srednia: <grey>" .. round(sum / count, 2) .. "                                 ", 0, 50))
end

scripts.inv.equipment.extended_evaluation:init()