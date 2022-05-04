scripts.ui.multibinds = scripts.ui.multibinds or {
    font_size = 10
}

function scripts.ui.multibinds:setup()
    local css = CSSMan.new([[
    padding-left: 5px;
    border-bottom: 1px solid black;
    margin-bottom: 3px;
    font-family:]].. getFont() ..[[,Consolas,Monaco,Lucida Console,Liberation Mono,DejaVu Sans Mono,Bitstream Vera Sans Mono,Courier New, monospace;
  ]] .. amap.ui.normal_button)

    scripts.ui.multibinds_label = Geyser.Label:new({
        name = "scripts.ui.multibinds.label",
        height = "100%",
        width = "100%",
        fontSize = self.font_size
    }, scripts.ui.actions_container)

    scripts.ui.multibinds_label:setStyleSheet(css:getCSS())
    scripts.ui.multibinds_label:echo("Brak akcji")
end
