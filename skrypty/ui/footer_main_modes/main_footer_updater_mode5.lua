
function scripts.ui:process_label_text_mode5(key, prefix, val, max_value, color)
    
  local timestamp = os.time(os.date("!*t"))
  if val == -1 then
    -- this happens at the start, stats have not been loaded yet
    return nil, false
  end
  
  local change_indicator_duration = scripts.ui.cfg.change_indicator_duration
  local settings = scripts.ui.cfg.footer_mode5_settings.values[key];
  
  if settings.last_changed == nil then
    settings.last_changed = timestamp - change_indicator_duration
  end
  if settings.last_value == nil then
    settings.last_value = val
  end

  local was_changed = val ~= settings.last_value or (timestamp - settings.last_changed) < change_indicator_duration
  local increased = val > settings.last_value
  --debugc(prefix, 'timediff ', (timestamp - settings.last_changed) < change_indicator_duration)
  --debugc(prefix, 'valdiff ', val, settings.last_value)
  
  local bar_color = settings.color
  local label = string.upper(prefix)
  if was_changed then

    settings.last_changed = timestamp
    settings.last_value = val;

     if increased then 
      label = label .. '↑' 
     else
       label = label .. '↓'
     end
     label = '<strong><font color="yellow">'..label..'</font></strong>'
  else
     label = label .. ' '
  end 
  
  local output = [[<center>]]..label..[[<font color=']]..bar_color..[['>]];
  local percent = 10 * val / max_value;

  for i = 1, 10 do
    if percent >= i then
      output = output .. '█'
    elseif percent > i - 0.5 then
      bar_color = scripts.utils.saturate_hex(bar_color, -0.5)
      output = output ..  '</font><font color="'..bar_color..'">█'
    else
      output = output .. '</font><font color="#6c6563">█'
    end
  end
  output = output .. '</font><font color="'..color..'">'
  if scripts.ui.cfg["footer_mode5_settings"].display_value_mode == "percent" then
    local percent_string = string.format("%.0f", 10.0 * percent)
    percent_string = string.rep('&nbsp;', 3 - #percent_string) .. percent_string
    output = output .. ' ' .. percent_string.."%"
  elseif scripts.ui.cfg["footer_mode5_settings"].display_value_mode == "raw" then
    local raw_value = val .. "/" .. max_value
    raw_value = raw_value .. string.rep('&nbsp;', 5 - #raw_value) 
    output = output .. ' ' .. raw_value
  end

  output = output .. '</font></center>';
  return output, was_changed
end
