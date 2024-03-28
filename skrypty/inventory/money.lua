scripts.money = scripts.money or {
    money_in_session = 0
}

function scripts.money:calculate_transaction_value(amount_str)
    local transaction_value = scripts.utils:parse_money_string(amount_str)
    local copper_amount = scripts.utils:to_copper(transaction_value.mithryl_amount, transaction_value.gold_amount,
        transaction_value.silver_amount, transaction_value.copper_amount)
    display(transaction_value)
    display(copper_amount)
end
