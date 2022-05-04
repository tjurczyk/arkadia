function scripts.ui:setup_footer_main()
    scripts.ui.footer_main_label = Geyser.VBox:new({
        name = "scripts.ui.footer_main_label",
        x = "2.5%",
        y = "2.5%",
        width = "95%",
        height = "95%",
    }, scripts.ui.footer_main)

    scripts.ui.footer_main_labels = {}

    local rows = math.ceil(table.size(scripts.ui.cfg.footer_items) / scripts.ui.footer_main_items_per_row)
    for i = 1, rows, 1 do
        table.insert(scripts.ui.footer_main_labels, Geyser.HBox:new({
            name = "scripts.ui.footer_main_label_" .. i,
        }, scripts.ui.footer_main_label))
    end
    

    if scripts.ui.cfg["footer_mode"] == "mode2" or scripts.ui.cfg["footer_mode"] == "mode3"
            or scripts.ui.cfg["footer_mode"] == "mode4"  or scripts.ui.cfg["footer_mode"] == "mode5"then
        scripts.ui:setup_gauge_mode2()
    elseif scripts.ui.cfg["footer_mode"] == "mode1" then
        scripts.ui:setup_gauge_mode1()
    end
end

