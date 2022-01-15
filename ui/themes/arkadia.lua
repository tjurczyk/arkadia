scripts.ui.themes.arkadia = scripts.ui.themes.plain:new()

function scripts.ui.themes.arkadia:apply_app_stylesheet()
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