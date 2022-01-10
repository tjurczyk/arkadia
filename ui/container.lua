local img_path = getMudletHomeDir() .. "/arkadia/ui/assets/"

setAppStyleSheet([[
    
]])

setUserWindowStyleSheet("states_window", [[
    QWidget { 
        border-style: solid;
        border-width: 60px;
        border-image: url(]]..img_path..[[uni-container-borders.png) 94 repeat;  
        padding: -45px -45px;
    }
]])

setUserWindowStyleSheet("talk_window", [[
    QWidget { 
        border-style: solid;
        border-width: 60px;
        border-image: url(]]..img_path..[[uni-container-borders.png) 94 repeat;  
        padding: -45px -25px;
    }
]])