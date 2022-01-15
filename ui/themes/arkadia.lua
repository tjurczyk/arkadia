scripts.ui.themes.arkadia = scripts.ui.themes.plain:new()

function scripts.ui.themes.arkadia:apply_app_stylesheet()
    setBackgroundColor(0,0,0,0)
    setAppStyleSheet([[
        QDockWidget::title {
            background-color: #171512;
            padding: 5px;
            background-image : url(]]..scripts.ui.img_path..[[background-02.png);
         }
    
         QToolBar {
            background-image : url(]]..scripts.ui.img_path..[[background-02.png);
            border-bottom: 1px solid #171512;
          }
    ]])
end

function scripts.ui.themes.arkadia:get_footer_stylesheet()
    return [[
        background-image : url(]].. scripts.ui.img_path..[[background-03.png);
    ]]
end
function scripts.ui.themes.arkadia:get_window_stylesheet()
    return [[
        QWidget { 
            padding: 15px 20px;
            background-color: #171512;
            background-origin: border-box;
        }
    ]]
end

function scripts.ui.themes.arkadia:get_button_window_stylesheet()
    return [[
        QWidget { 
            padding: 55px 20px 10px 20px;
            background-color: #171512;
            background-origin: border-box;
        }
    ]]
end

function scripts.ui.themes.arkadia:get_button_area_bg()
    return [[
        background-image: url(]]..scripts.ui.img_path..[[background-02.png);
        background-origin: padding-box;
        border-bottom: 3px solid #403931;
    ]]
end

function scripts.ui.themes.arkadia:get_border_stylesheet()
    return [[
        background: none;
        border-style: solid;
        border-width: 24px 49px 24px 49px;
        border-image: url(]]..scripts.ui.img_path..[[uni-container-borders.png) 58 94 repeat;
    ]]
end

function scripts.ui.themes.arkadia:get_notification_color()
    return closestColor("#d1b493");
end

function scripts.ui.themes.arkadia:get_notification_stylesheet()
    return [[
        QLabel {
            border-style: solid;
            border-width: 24px 49px 24px 49px;
            background-color: #171512;
            border-image: url(]]..scripts.ui.img_path..[[uni-container-borders-short-height.png) 58 94 repeat;
            qproperty-wordWrap: true;
        }
    ]]
end

function scripts.ui.themes.arkadia:get_notification_close_stylesheet()
    return [[
        QLabel{
            background-color: transparent;
            background-image : url(]]..scripts.ui.img_path..[[btn-exit.png);
        }

        QLabel:hover{
         background-image : url(]]..scripts.ui.img_path..[[btn-exit-hover.png);
        }
    ]]
end

function scripts.ui.themes.arkadia:get_button_stylesheet(color)
    return [[
        QLabel {
            border: 0;
            padding: 0;
            background-color: ]] .. string.format(color, 125) .. [[;
            background-image : url(]] .. scripts.ui.img_path .. [[btn-universal-m.png);
            text-transform: uppercase;
            font-weight: 500;
            color: #d1b493;
            font-size: 10px;
        }

        QLabel:hover{
            background-color: ]] .. string.format(color, 255) .. [[;
        }
    ]]
end