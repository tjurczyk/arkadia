scripts.ui.multibinds = scripts.ui.multibinds or {}

function scripts.ui.multibinds:setup()
    local css = CSSMan.new([[
    padding-left: 5px;
    border-bottom: 1px solid black;
    margin-bottom: 3px;
    background-color: rgba(]] .. scripts.ui.footer_r .. [[,]] .. scripts.ui.footer_g .. [[,]] .. scripts.ui.footer_b .. [[,0);
    font-family:]].. getFont() ..[[,Consolas,Monaco,Lucida Console,Liberation Mono,DejaVu Sans Mono,Bitstream Vera Sans Mono,Courier New, monospace;
  ]] .. amap.ui.normal_button)

    scripts.ui.multibinds_label = Geyser.Label:new({
        name = "scripts.ui.multibinds.label",
        height = "100%",
        width = "100%",
        fontSize = 10
    }, scripts.ui.actions_container)

    scripts.ui.multibinds_label:setStyleSheet(css:getCSS())
    scripts.ui.multibinds_label:echo("Brak akcji")
end
