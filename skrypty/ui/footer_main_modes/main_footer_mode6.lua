function scripts.ui:setup_gauge_mode6()
    local curr_row = scripts.ui.footer_main_labels[1]
    local curr_id = 2
    local settings = scripts.ui.cfg.footer_mode6_settings;
    for k, v in pairs(scripts.ui.cfg.footer_items) do
      local eng_name = scripts.ui["bar_to_eng"][v]
      local max_val = scripts.ui["footer_bar"][eng_name]["max"]
      scripts.ui[scripts.ui["bar_to_id1"][v]] =
        Geyser.Label:new(
          {
            name = "scripts.ui." .. scripts.ui["bar_to_id1"][v],
            fontSize = scripts.ui.footer_font_size,
            width = tostring(100 / scripts.ui.footer_main_items_per_row) .. "%",
            h_policy = Geyser.Fixed,
            message = "",
          },
          curr_row
        )
      scripts.ui[scripts.ui["bar_to_id1"][v]]:setStyleSheet(
        [[
              border: 0px;
              font-family:]] ..
        getFont() ..
        [[,Consolas,Bitstream Vera Sans Mono,monospace;
          ]]
      )
      local bar_label_width = settings.bar_label_width
      local my_width = settings.bar_width
      local my_height = settings.bar_height
      local my_space = settings.bar_item_space or 1
      local my_elements = max_val
      -- obliczam szerokosci poszczegolnych elementow dla zadanej szerokosci belki i ilosci elementow
      -- nie uzywam szerokosci procentowej zeby uniknac przeskakiwania pixeli przy zaokragleniach
      local chunks = {}
      local chunk_width = math.floor((my_width - ((my_elements - 1) * my_space)) / my_elements)
      -- nadwyzka do rozdysponowania
      local surplus = (my_width - ((my_elements - 1) * my_space)) - (chunk_width * my_elements)
      for i = 1, my_elements do
        if (surplus > 0) then
          chunks[i] = chunk_width + 1
          surplus = surplus - 1
        else
          chunks[i] = chunk_width
        end
      end
      -- etykieta tekstowa belki
      local bar_label_text_font_size =
        settings.bar_label_text_font_size or scripts.ui.footer_font_size
      scripts.ui[scripts.ui["bar_to_id1"][v]]["lb"] =
        Geyser.Label:new(
          {
            name = "scripts.ui." .. scripts.ui["bar_to_id1"][v] .. "_lb",
            fontSize = bar_label_text_font_size,
            x = 0,
            y = 0,
            width = bar_label_width,
            height = my_height,
            color = "#333333",
            message =
              [[<center><font color="]] ..
              scripts.ui["footer_info_normal"] ..
              [[">]] ..
              string.upper(scripts.ui["state_key_to_label_pre"][scripts.ui["bar_to_eng"][v]]) ..
              [[]],
          },
          scripts.ui[scripts.ui["bar_to_id1"][v]]
        )
      scripts.ui[scripts.ui["bar_to_id1"][v]]["lb"]:setStyleSheet(
        [[
              border: 0px;
              font-family:]] ..
        getFont() ..
        [[,Consolas,Bitstream Vera Sans Mono,monospace;
          ]]
      )
      local bar_text_color = settings.bar_text_color or "#000000";
      local bar_text_font_size = settings.bar_text_font_size or scripts.ui.footer_font_size
      local bar_text_bold = scripts.ui.cfg["footer_mode6_settings"]["bar_text_bold"] or false
      local label_x_pos = bar_label_width
      local my_message_prefix = "<center>"
      if bar_text_bold == true then
        my_message_prefix = my_message_prefix .. "<strong>"
      end
      -- tworze labele dla elementow belki
      for i = 1, my_elements do
        if (chunks[i] ~= nil) then
          local my_message = my_message_prefix .. tostring(i)
          -- obcinam za dlugie teksty jesli waski pasek
          if (chunks[i] < 12) and i > 9 then
            my_message = my_message_prefix .. string.sub(tostring(i), 2, 2)
          end
          -- usuwam tekst jesli bardzo waski pasek
          if (chunks[i] < 7) then
            my_message = my_message_prefix .. " "
          end
          scripts.ui[scripts.ui["bar_to_id1"][v]][i] =
            Geyser.Label:new(
              {
                name = "scripts.ui." .. scripts.ui["bar_to_id1"][v] .. "_" .. tostring(i) .. "",
                fontSize = bar_text_font_size,
                x = label_x_pos,
                y = 0,
                width = chunks[i],
                height = my_height,
                fgColor = bar_text_color,
                color = "#777777",
                message = my_message,
              },
              scripts.ui[scripts.ui["bar_to_id1"][v]]
            )
          --scripts.ui[scripts.ui["bar_to_id1"][v]][i]:echo(my_message)
          scripts.ui[scripts.ui["bar_to_id1"][v]][i]:setStyleSheet(
            [[  font-family:]] ..
            settings.bar_text_font ..
            [[,]] ..
            getFont() ..
            [[,Consolas,Bitstream Vera Sans Mono,monospace; background-color: "#777777";]]
          )
          label_x_pos = label_x_pos + chunks[i] + my_space
        end
      end
      if k ~= 1 and k % scripts.ui.footer_main_items_per_row == 0 then
        curr_row = scripts.ui.footer_main_labels[curr_id]
        curr_id = curr_id + 1
      end
    end
    if settings.show_tip_on_start == true then
      cecho(
        "<CadetBlue>(skrypty): <orange>Uzywasz trybu mode6. Uzyj <yellow>/mode6<orange> do wyswietlenia pomocy.\n"
      )
    end
  end


function alias_func_skrypty_ui_mode6(demo_type)

  demo_type = demo_type or 0
  if matches[3] ~= nil then
    demo_type = tonumber(matches[3])
  end

  if demo_type == 0 then
    cecho ("\n<CadetBlue>----------------------------------------------------------------------------------------------------------------\n")
    cecho ("<cyan>Pomoc do mode6\n")
    cecho ("<white>Tryb mode6 oferuje spore mozliwosci konfiguracji sposobu wyswietlania stanu postaci\n")
    cecho ("<white>oraz indywidualnego ustawienia kolorowania kazdej belki.\n")
    cecho ("<white>Konfiguracja parametrow znajduje sie w pliku <cyan>arkadia/skrypty/ui.lua \n")
    cecho ("<white>w tabeli <cyan>scripts.ui.cfg[\"footer_mode6_settings\"] \n")
    cecho ("<white>Poszczegolne parametry sa opisane komentarzem.\n")
    cecho ("<white>Aby zachowac wlasne zmiany przy aktualizacji skryptow, dodaj nowy element w Scripts\n")
    cecho ("<white>pod folderem Arkadia, dodaj User Event Handler 'scriptsLoaded' i wklej swoja konfiguracje.\n")
    cecho ("<white>Uwaga, skopiuj cala definicje tabeli, razem z elementami, ktorych nie zmieniasz.\n")
    cecho ("<white>\n")
    cecho ("<white>Mozesz tez zobaczyc kilka przykladowych konfiguracji nastepujacymi aliasami:.\n")
    cecho ("<yellow>/mode6 1 <white>Domyslne ustawienia belki.\n")
    cecho ("<yellow>/mode6 2 <white>Przyklad kolorowania z uzyciem przejsc pomiedzy kolorami\n")
    cecho ("<yellow>/mode6 3 <white>Przyklad kolorowania z wykorzystaniem rozjasniania.\n")
    cecho ("<yellow>/mode6 4 <white>Przyklad kolorowania w oparciu o wartosci kolorow zdefiniowane w footer_bar.\n")
    cecho ("<yellow>/mode6 5 <white>Przyklad domyslnego kolorowania, tekst bez pogrubienia, belki GLOD i PRAGNIENIE w trybie odwroconym.\n")
    cecho ("<yellow>/mode6 6 <white>Przyklad domyslnego kolorowania, belka kondycji zielona z czerwonym dopelnieniem.\n")
    cecho ("<CadetBlue>----------------------------------------------------------------------------------------------------------------\n\n")
  end

  if demo_type == 1 then
    scripts.ui.cfg["footer_mode6_settings"] = {
      ["show_tip_on_start"] = false,
      ["bar_width"] = 102,
      ["bar_height"] = 16,
      ["bar_item_space"] = 1,
      ["bar_text_color"] = "#000000",
      ["bar_text_font"] = "",
      ["bar_text_font_size"] = 8,
      ["bar_text_bold"] = true,
      ["bar_label_width"] = 32,
      ["bar_label_text_color"] = "#ffffff",
      ["bar_label_improve_text_color"] = "#ffff00",
      ["bar_label_worsen_text_color"] = "#00ffff",
      ["text_indicator_increase"] = "↑",
      ["text_indicator_decrease"] = "↓",
      ["bar_label_text_font_size"] = 10,
      ["change_indicator_duration"] = 10,
      ["brightness_percentage"] = 50,
      ["values"] = {
        ["hp"] = {
          ["color"]= "#e4190c",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ff0b64",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["fatigue"] = {
          ["color"]= "#05b12f",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#0799c9",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["mana"] = {
          ["color"]= "#308dff",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#30ffa2",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["soaked"] = {
          ["color"]= "#add8e6",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#9fd1a8",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["stuffed"] = {
          ["color"]= "#8c482e",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#8c602e",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["intox"]= {
          ["color"]= "#fb00ff",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ff0084",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["headache"] = {
          ["color"]= "#b8b8b8",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#9f7f7f",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["panic"] = {
          ["color"]= "#ffd504",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ff04d5",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["encumbrance"] = {
          ["color"]= "#e2ef27",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#e324d3",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["improve"] = {
          ["color"]= "#5b1dbf",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ac1dbf",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["form"] = {
          ["color"]= "#ff8404",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ffc404",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
      }
    }
      scripts.ui:setup_gauge_mode6()
      scripts.ui:update_bars_mode("label",true)
    end

    -- tryb gradient
    if demo_type == 2 then

      scripts.ui.cfg["footer_mode6_settings"] = {
        ["show_tip_on_start"] = false,
        ["bar_width"] = 102,
        ["bar_height"] = 16,
        ["bar_item_space"] = 1,
        ["bar_text_color"] = "#000000",
        ["bar_text_font"] = "",
        ["bar_text_font_size"] = 8,
        ["bar_text_bold"] = true,
        ["bar_label_width"] = 32,
        ["bar_label_text_color"] = "#ffffff",
        ["bar_label_improve_text_color"] = "#ffff00",
        ["bar_label_worsen_text_color"] = "#00ffff",
        ["text_indicator_increase"] = "↑",
        ["text_indicator_decrease"] = "↓",
        ["bar_label_text_font_size"] = 10,
        ["change_indicator_duration"] = 10,
        ["brightness_percentage"] = 50,

        ["values"] = {
          ["hp"] = {
            ["color"]= "#e4190c",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#ff0b64",
            ["inverted"] = false,
            ["color_mode"] = "gradient",
            ["improve_on_decrease"] = false,
          },
          ["fatigue"] = {
            ["color"]= "#05b12f",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#0799c9",
            ["inverted"] = false,
            ["color_mode"] = "gradient",
            ["improve_on_decrease"] = true,
          },
          ["mana"] = {
            ["color"]= "#308dff",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#30ffa2",
            ["inverted"] = false,
            ["color_mode"] = "gradient",
            ["improve_on_decrease"] = false,
          },
          ["soaked"] = {
            ["color"]= "#add8e6",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#9fd1a8",
            ["inverted"] = false,
            ["color_mode"] = "gradient",
            ["improve_on_decrease"] = false,
          },
          ["stuffed"] = {
            ["color"]= "#8c482e",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#8c602e",
            ["inverted"] = false,
            ["color_mode"] = "gradient",
            ["improve_on_decrease"] = false,
          },
          ["intox"]= {
            ["color"]= "#fb00ff",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#ff0084",
            ["inverted"] = false,
            ["color_mode"] = "gradient",
            ["improve_on_decrease"] = true,
          },
          ["headache"] = {
            ["color"]= "#b8b8b8",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#9f7f7f",
            ["inverted"] = false,
            ["color_mode"] = "gradient",
            ["improve_on_decrease"] = true,
          },
          ["panic"] = {
            ["color"]= "#ffd504",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#ff04d5",
            ["inverted"] = false,
            ["color_mode"] = "gradient",
            ["improve_on_decrease"] = true,
          },
          ["encumbrance"] = {
            ["color"]= "#e2ef27",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#e324d3",
            ["inverted"] = false,
            ["color_mode"] = "gradient",
            ["improve_on_decrease"] = true,
          },
          ["improve"] = {
            ["color"]= "#5b1dbf",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#ac1dbf",
            ["inverted"] = false,
            ["color_mode"] = "gradient",
            ["improve_on_decrease"] = false,
          },
          ["form"] = {
            ["color"]= "#ff8404",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#ffc404",
            ["inverted"] = false,
            ["color_mode"] = "gradient",
            ["improve_on_decrease"] = false,
          },
        }
      }

      scripts.ui:setup_gauge_mode6()
      scripts.ui:update_bars_mode("label",true)
    end

    -- tryb brightness
    if demo_type == 3 then
      scripts.ui.cfg["footer_mode6_settings"] = {
        ["show_tip_on_start"] = false,
        ["bar_width"] = 102,
        ["bar_height"] = 16,
        ["bar_item_space"] = 1,
        ["bar_text_color"] = "#000000",
        ["bar_text_font"] = "",
        ["bar_text_font_size"] = 8,
        ["bar_text_bold"] = true,
        ["bar_label_width"] = 32,
        ["bar_label_text_color"] = "#ffffff",
        ["bar_label_improve_text_color"] = "#ffff00",
        ["bar_label_worsen_text_color"] = "#00ffff",
        ["text_indicator_increase"] = "↑",
        ["text_indicator_decrease"] = "↓",
        ["bar_label_text_font_size"] = 10,
        ["change_indicator_duration"] = 10,
        ["brightness_percentage"] = 50,
        ["values"] = {
          ["hp"] = {
            ["color"]= "#e4190c",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#ff0b64",
            ["inverted"] = false,
            ["color_mode"] = "brightness",
            ["improve_on_decrease"] = false,
          },
          ["fatigue"] = {
            ["color"]= "#05b12f",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#0799c9",
            ["inverted"] = false,
            ["color_mode"] = "brightness",
            ["improve_on_decrease"] = true,
          },
          ["mana"] = {
            ["color"]= "#308dff",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#30ffa2",
            ["inverted"] = false,
            ["color_mode"] = "brightness",
            ["improve_on_decrease"] = false,
          },
          ["soaked"] = {
            ["color"]= "#add8e6",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#9fd1a8",
            ["inverted"] = false,
            ["color_mode"] = "brightness",
            ["improve_on_decrease"] = false,
          },
          ["stuffed"] = {
            ["color"]= "#8c482e",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#8c602e",
            ["inverted"] = false,
            ["color_mode"] = "brightness",
            ["improve_on_decrease"] = false,
          },
          ["intox"]= {
            ["color"]= "#fb00ff",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#ff0084",
            ["inverted"] = false,
            ["color_mode"] = "brightness",
            ["improve_on_decrease"] = true,
          },
          ["headache"] = {
            ["color"]= "#b8b8b8",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#9f7f7f",
            ["inverted"] = false,
            ["color_mode"] = "brightness",
            ["improve_on_decrease"] = true,
          },
          ["panic"] = {
            ["color"]= "#ffd504",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#ff04d5",
            ["inverted"] = false,
            ["color_mode"] = "brightness",
            ["improve_on_decrease"] = true,
          },
          ["encumbrance"] = {
            ["color"]= "#e2ef27",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#e324d3",
            ["inverted"] = false,
            ["color_mode"] = "brightness",
            ["improve_on_decrease"] = true,
          },
          ["improve"] = {
            ["color"]= "#5b1dbf",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#ac1dbf",
            ["inverted"] = false,
            ["color_mode"] = "brightness",
            ["improve_on_decrease"] = false,
          },
          ["form"] = {
            ["color"]= "#ff8404",
            ["inactive_color"] = "#6c6563",
            ["gradient_color"] = "#ffc404",
            ["inverted"] = false,
            ["color_mode"] = "brightness",
            ["improve_on_decrease"] = false,
          },
        }
      }
    scripts.ui:setup_gauge_mode6()
    scripts.ui:update_bars_mode("label",true)
  end

  if demo_type == 4 then
    scripts.ui.cfg["footer_mode6_settings"] = {
      ["show_tip_on_start"] = false,
      ["bar_width"] = 102,
      ["bar_height"] = 16,
      ["bar_item_space"] = 1,
      ["bar_text_color"] = "#000000",
      ["bar_text_font"] = "",
      ["bar_text_font_size"] = 8,
      ["bar_text_bold"] = true,
      ["bar_label_width"] = 32,
      ["bar_label_text_color"] = "#ffffff",
      ["bar_label_improve_text_color"] = "#ffff00",
      ["bar_label_worsen_text_color"] = "#00ffff",
      ["text_indicator_increase"] = "↑",
      ["text_indicator_decrease"] = "↓",
      ["bar_label_text_font_size"] = 10,
      ["change_indicator_duration"] = 10,
      ["brightness_percentage"] = 50,
      ["values"] = {
        ["hp"] = {
          ["color"]= "#e4190c",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ff0b64",
          ["inverted"] = false,
          ["color_mode"] = "footer_bar",
          ["improve_on_decrease"] = false,
        },
        ["fatigue"] = {
          ["color"]= "#05b12f",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#0799c9",
          ["inverted"] = false,
          ["color_mode"] = "footer_bar",
          ["improve_on_decrease"] = true,
        },
        ["mana"] = {
          ["color"]= "#308dff",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#30ffa2",
          ["inverted"] = false,
          ["color_mode"] = "footer_bar",
          ["improve_on_decrease"] = false,
        },
        ["soaked"] = {
          ["color"]= "#add8e6",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#9fd1a8",
          ["inverted"] = false,
          ["color_mode"] = "footer_bar",
          ["improve_on_decrease"] = false,
        },
        ["stuffed"] = {
          ["color"]= "#8c482e",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#8c602e",
          ["inverted"] = false,
          ["color_mode"] = "footer_bar",
          ["improve_on_decrease"] = false,
        },
        ["intox"]= {
          ["color"]= "#fb00ff",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ff0084",
          ["inverted"] = false,
          ["color_mode"] = "footer_bar",
          ["improve_on_decrease"] = true,
        },
        ["headache"] = {
          ["color"]= "#b8b8b8",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#9f7f7f",
          ["inverted"] = false,
          ["color_mode"] = "footer_bar",
          ["improve_on_decrease"] = true,
        },
        ["panic"] = {
          ["color"]= "#ffd504",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ff04d5",
          ["inverted"] = false,
          ["color_mode"] = "footer_bar",
          ["improve_on_decrease"] = true,
        },
        ["encumbrance"] = {
          ["color"]= "#e2ef27",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#e324d3",
          ["inverted"] = false,
          ["color_mode"] = "footer_bar",
          ["improve_on_decrease"] = true,
        },
        ["improve"] = {
          ["color"]= "#5b1dbf",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ac1dbf",
          ["inverted"] = false,
          ["color_mode"] = "footer_bar",
          ["improve_on_decrease"] = false,
        },
        ["form"] = {
          ["color"]= "#ff8404",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ffc404",
          ["inverted"] = false,
          ["color_mode"] = "footer_bar",
          ["improve_on_decrease"] = false,
        },
      }
    }

    scripts.ui:setup_gauge_mode6()
    scripts.ui:update_bars_mode("label",true)
  end

  if demo_type == 5 then

    scripts.ui.cfg["footer_mode6_settings"] = {
      ["show_tip_on_start"] = false,
      ["bar_width"] = 102,
      ["bar_height"] = 16,
      ["bar_item_space"] = 1,
      ["bar_text_color"] = "#000000",
      ["bar_text_font"] = "",
      ["bar_text_font_size"] = 8,
      ["bar_text_bold"] = false,
      ["bar_label_width"] = 32,
      ["bar_label_text_color"] = "#ffffff",
      ["bar_label_improve_text_color"] = "#ffff00",
      ["bar_label_worsen_text_color"] = "#00ffff",
      ["text_indicator_increase"] = "↑",
      ["text_indicator_decrease"] = "↓",
      ["bar_label_text_font_size"] = 10,
      ["change_indicator_duration"] = 10,
      ["brightness_percentage"] = 50,
      ["values"] = {
        ["hp"] = {
          ["color"]= "#e4190c",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ff0b64",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["fatigue"] = {
          ["color"]= "#05b12f",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#0799c9",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["mana"] = {
          ["color"]= "#308dff",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#30ffa2",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["soaked"] = {
          ["color"]= "#add8e6",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#9fd1a8",
          ["inverted"] = true,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["stuffed"] = {
          ["color"]= "#8c482e",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#8c602e",
          ["inverted"] = true,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["intox"]= {
          ["color"]= "#fb00ff",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ff0084",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["headache"] = {
          ["color"]= "#b8b8b8",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#9f7f7f",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["panic"] = {
          ["color"]= "#ffd504",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ff04d5",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["encumbrance"] = {
          ["color"]= "#e2ef27",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#e324d3",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["improve"] = {
          ["color"]= "#5b1dbf",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ac1dbf",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["form"] = {
          ["color"]= "#ff8404",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ffc404",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
      }
    }
  scripts.ui:setup_gauge_mode6()
  scripts.ui:update_bars_mode("label",true)
  end

  if demo_type == 6 then
    scripts.ui.cfg["footer_mode6_settings"] = {
      ["show_tip_on_start"] = false,
      ["bar_width"] = 102,
      ["bar_height"] = 16,
      ["bar_item_space"] = 1,
      ["bar_text_color"] = "#000000",
      ["bar_text_font"] = "",
      ["bar_text_font_size"] = 8,
      ["bar_text_bold"] = true,
      ["bar_label_width"] = 32,
      ["bar_label_text_color"] = "#ffffff",
      ["bar_label_improve_text_color"] = "#ffff00",
      ["bar_label_worsen_text_color"] = "#00ffff",
      ["text_indicator_increase"] = "↑",
      ["text_indicator_decrease"] = "↓",
      ["bar_label_text_font_size"] = 10,
      ["change_indicator_duration"] = 10,
      ["brightness_percentage"] = 50,

      ["values"] = {
        ["hp"] = {
          ["color"]= "#1dbf44",
          ["inactive_color"] = "#c2352d",
          ["gradient_color"] = "#ff0b64",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["fatigue"] = {
          ["color"]= "#05b12f",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#0799c9",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["mana"] = {
          ["color"]= "#308dff",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#30ffa2",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["soaked"] = {
          ["color"]= "#add8e6",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#9fd1a8",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["stuffed"] = {
          ["color"]= "#8c482e",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#8c602e",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["intox"]= {
          ["color"]= "#fb00ff",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ff0084",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["headache"] = {
          ["color"]= "#b8b8b8",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#9f7f7f",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["panic"] = {
          ["color"]= "#ffd504",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ff04d5",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["encumbrance"] = {
          ["color"]= "#e2ef27",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#e324d3",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = true,
        },
        ["improve"] = {
          ["color"]= "#5b1dbf",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ac1dbf",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
        ["form"] = {
          ["color"]= "#ff8404",
          ["inactive_color"] = "#6c6563",
          ["gradient_color"] = "#ffc404",
          ["inverted"] = false,
          ["color_mode"] = "solid",
          ["improve_on_decrease"] = false,
        },
      }
    }

    scripts.ui:setup_gauge_mode6()
    scripts.ui:update_bars_mode("label",true)
  end


end