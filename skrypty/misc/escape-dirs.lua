function misc:enemy_escape_print_arrow(dir, color)
    local l_color = nil
    if color then
        l_color = color
    else
        l_color = "grey"
    end
    if dir == "poludnie" then
        cecho("\n                  <" .. l_color .. ">#\n")
        cecho("                  <" .. l_color .. ">#\n")
        cecho("                <" .. l_color .. "># # #\n")
        cecho("                 <" .. l_color .. ">###\n")
        cecho("                  <" .. l_color .. ">#\n")
    elseif dir == "polnoc" then
        cecho("\n                  <" .. l_color .. ">#\n")
        cecho("                 <" .. l_color .. ">###\n")
        cecho("                <" .. l_color .. "># # #\n")
        cecho("                  <" .. l_color .. ">#\n")
        cecho("                  <" .. l_color .. ">#\n")
    elseif dir == "wschod" then
        cecho("\n                  <" .. l_color .. ">#\n")
        cecho("                   <" .. l_color .. ">#\n")
        cecho("              <" .. l_color .. ">#######\n")
        cecho("                   <" .. l_color .. ">#\n")
        cecho("                  <" .. l_color .. ">#\n")
    elseif dir == "zachod" then
        cecho("\n                <" .. l_color .. ">#\n")
        cecho("               <" .. l_color .. ">#\n")
        cecho("              <" .. l_color .. ">#######\n")
        cecho("               <" .. l_color .. ">#\n")
        cecho("                <" .. l_color .. ">#\n")
    elseif dir == "poludniowy-wschod" then
        cecho("\n               <" .. l_color .. ">#\n")
        cecho("                 <" .. l_color .. ">#\n")
        cecho("                   <" .. l_color .. ">#   #\n")
        cecho("                     <" .. l_color .. "># #\n")
        cecho("                   <" .. l_color .. "># # #\n")
    elseif dir == "poludniowy-zachod" then
        cecho("\n                       <" .. l_color .. ">#\n")
        cecho("                     <" .. l_color .. ">#\n")
        cecho("               <" .. l_color .. ">#   #\n")
        cecho("               <" .. l_color .. "># #\n")
        cecho("               <" .. l_color .. "># # #\n")
    elseif dir == "polnocny-wschod" then
        cecho("\n                   <" .. l_color .. "># # #\n")
        cecho("                     <" .. l_color .. "># #\n")
        cecho("                   <" .. l_color .. ">#   #\n")
        cecho("                 <" .. l_color .. ">#\n")
        cecho("               <" .. l_color .. ">#\n")
    elseif dir == "polnocny-zachod" then
        cecho("\n               <" .. l_color .. "># # #\n")
        cecho("               <" .. l_color .. "># #\n")
        cecho("               <" .. l_color .. ">#   #\n")
        cecho("                     <" .. l_color .. ">#\n")
        cecho("                       <" .. l_color .. ">#\n")
    elseif dir == "dol" then
        cecho("\n            <" .. l_color .. ">###\n")
        cecho("            <" .. l_color .. ">#  #\n")
        cecho("            <" .. l_color .. ">#  #\n")
        cecho("            <" .. l_color .. ">#  #\n")
        cecho("            <" .. l_color .. ">###\n")
    elseif dir == "gore" then
        cecho("\n            <" .. l_color .. ">#  #\n")
        cecho("            <" .. l_color .. ">#  #\n")
        cecho("            <" .. l_color .. ">#  #\n")
        cecho("            <" .. l_color .. ">#  #\n")
        cecho("             <" .. l_color .. ">## \n")
    end
end

