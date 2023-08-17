function scripts.ui:process_label_text_mode6(key, prefix, val, max_value, color)
    local timestamp = os.time(os.date("!*t"))
    if val == -1 then
      -- this happens at the start, stats have not been loaded yet
      return nil, false
    end
    -- zabezpieczenie na brak labeli do zrobienia belki, zwracam tekst
    local output = [[<center>]] .. prefix .. [[: ]] .. tostring(val) .. "/" .. tostring(max_value);
    local label_name = key .. "label"
    -- oznaczanie zmian stanu na skopiowane z  mode5 
    local change_indicator_duration = scripts.ui.cfg.footer_mode6_settings.change_indicator_duration
  
    local settings = scripts.ui.cfg.footer_mode6_settings.values[key];
    if settings.last_changed == nil then
      settings.last_changed = timestamp - change_indicator_duration
    end
    if settings.last_value == nil then
      settings.last_value = val
    end
    local was_changed =
      val ~= settings.last_value or (timestamp - settings.last_changed) < change_indicator_duration
    local increased = val > settings.last_value
    --jesli istnieje label dla etykiety tekstowowej to rysuje cala belke
    if (scripts.ui[label_name]["lb"] ~= nil) then
      local bar_color = settings.color
      local label_text = "" .. string.upper(prefix)
      local label_color = scripts.ui.cfg.footer_mode6_settings.bar_label_text_color
      local improve_on_decrease = settings.improve_on_decrease
      if was_changed then
        local bar_improve = false;
        settings.last_changed = timestamp
        settings.last_value = val;
        if increased then
          if settings.inverted == true then
            label_text = label_text .. scripts.ui.cfg.footer_mode6_settings.text_indicator_decrease
          else
            label_text = label_text .. scripts.ui.cfg.footer_mode6_settings.text_indicator_increase
            bar_improve = true;
          end
        else
          if settings.inverted == true then
            label_text = label_text .. scripts.ui.cfg.footer_mode6_settings.text_indicator_increase
            bar_improve = true;
          else
            label_text = label_text .. scripts.ui.cfg.footer_mode6_settings.text_indicator_decrease
          end
        end
        -- ustawiam odpowiedni kolor w zaleznosci od tego czy wartosc sie polepsza czy pogarsza
        -- z uwzglednieniem opcji improve_on_decrease
        if bar_improve == true then
          if improve_on_decrease == true then
            label_color = scripts.ui.cfg.footer_mode6_settings.bar_label_worsen_text_color
          else
            label_color = scripts.ui.cfg.footer_mode6_settings.bar_label_improve_text_color
          end
        else
          if improve_on_decrease == true then
            label_color = scripts.ui.cfg.footer_mode6_settings.bar_label_improve_text_color
          else
            label_color = scripts.ui.cfg.footer_mode6_settings.bar_label_worsen_text_color
          end
        end
      else
        label_text = label_text .. " "
      end
      -- aktualizuje etykiete tekstowa belki
      label_text = [[<font color="]] .. label_color .. [[">]] .. label_text .. [[ </font>]]
      scripts.ui[label_name]["lb"]:echo([[<center>]] .. label_text .. [[]])
      -- belka graficzna
      local bar_font = scripts.ui.cfg["footer_mode6_settings"]["bar_text_font"] or ""
      
      -- kolory z footer_bar
      if
        settings.color_mode == "footer_bar" and scripts.ui.footer_bar[key].background[val] ~= nil
      then
        bar_color = scripts.ui.footer_bar[key].background[val]
      end
      local label_color = bar_color
      
      -- zeruje belke
      for i = 1, max_value do
        scripts.ui[label_name][i]:setStyleSheet(
          [[  font-family:]] ..
          bar_font ..
          [[,]] ..
          getFont() ..
          [[,Consolas,Bitstream Vera Sans Mono,monospace; background-color: ]] ..
          settings.inactive_color ..
          [[;]]
        )
      end
      
      local label_val = val
      -- odwracam wartosc jesli opcja inverted
      if (settings.inverted == true) then
        label_val = max_value - val
      end
      
      -- obliczam wspolczynnik rozjasniania belki
      
      local brightness_percentage = tonumber(scripts.ui.cfg["footer_mode6_settings"]["brightness_percentage"])
      brightness_percentage = math.max(0, math.min(100, brightness_percentage))
      local brightness_ratio = 100 / brightness_percentage
      brightness_offset = (brightness_percentage / 100) / 2 * -1
  
      -- jesli belka gradient to obliczam poszczegolne kolory przejscia
      gradient_color_steps = {}
      if settings.color_mode == "gradient" then
        gradient_color_steps =
          scripts.utils.color_gradient_calculate_steps(
            settings.color, settings.gradient_color, max_value
          )
      end
      
      -- wypelniam belke wartosciami
      for i = 1, label_val do
        if settings.color_mode == "brightness" then
          local lighten_amount = brightness_offset + (i / max_value) / brightness_ratio
          label_color = scripts.utils.lighten_hex(bar_color, lighten_amount)
        elseif settings.color_mode == "gradient" then
          if (gradient_color_steps[i] ~= nil) then
            label_color = gradient_color_steps[i]
          else
            label_color = bar_color
          end
        end
        scripts.ui[label_name][i]:setStyleSheet(
          [[  font-family:]] ..
          bar_font ..
          [[,]] ..
          getFont() ..
          [[,Consolas,Bitstream Vera Sans Mono,monospace; background-color: ]] ..
          label_color ..
          [[;]]
        )
      end
      -- zwracam pusty output bo belka narysowana labelami
      output = ""
    end
    return output, was_changed
  end
  