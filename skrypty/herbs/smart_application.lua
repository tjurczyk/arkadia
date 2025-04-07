function herbs:init_smart_application()
    herbs['smart_application_skip'] = {
        kon = {},
        man = { deliona = true },
        zme = {}
    }

    herbs['smart_application_queue'] = {
        kon = { herbs = {}, index = 0 },
        man = { herbs = {}, index = 0 },
        zme = { herbs = {}, index = 0 },
    }
end

function herbs:smart_application_execute(htype)
    if herbs.smart_application_queue[htype].index == 0 then
        herbs:smart_application_init_htype_queue(htype)
    end

    cecho("wezme " .. herbs.smart_application_queue[htype].herbs[herbs.smart_application_queue[htype].index])

    -- TODO add removing the herb from queue if went to 0

    herbs.smart_application_queue[htype].index = (herbs.smart_application_queue[htype].index + 1) %
        table.size(herbs.smart_application_queue[htype].herbs)

    if herbs.smart_application_queue[htype].index == 0 then
        herbs.smart_application_queue[htype].index = 1
    end
end

function herbs:smart_application_init_htype_queue(htype)
end
