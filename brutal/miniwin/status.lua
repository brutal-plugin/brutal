
function draw_stat_guages(myPositonY, myValue, myColour)
      GAUGE_LEFT = 120
      GAUGE_HEIGHT = 20
      NUMBER_OF_TICKS = 9
      BORDER_COLOUR = WHITE
      GUAGE_SIZE = 450
      local Fraction = tonumber (myValue) / 100

      if Fraction > 1 then Fraction = 1 end
      if Fraction < 0 then Fraction = 0 end
      WindowRectOp (stats_win, 2, GAUGE_LEFT, myPositonY, GUAGE_SIZE - 5, myPositonY + GAUGE_HEIGHT,
                              BLACK)  -- fill entire box
      local gauge_width = (GUAGE_SIZE - GAUGE_LEFT - 5) * Fraction

       -- box size must be > 0 or WindowGradient fills the whole thing
      if math.floor (gauge_width) > 0 then

        -- top half
        WindowGradient (stats_win, GAUGE_LEFT, myPositonY, GAUGE_LEFT + gauge_width, myPositonY + GAUGE_HEIGHT / 2,
                        0x000000,
                        myColour, 2)

        -- bottom half
        WindowGradient (stats_win, GAUGE_LEFT, myPositonY + GAUGE_HEIGHT / 2,
                        GAUGE_LEFT + gauge_width, myPositonY +  GAUGE_HEIGHT,
                        myColour,
                        0x000000,
                        2)

      end -- non-zero

      -- show ticks
      local ticks_at = (GUAGE_SIZE - GAUGE_LEFT - 5) / (NUMBER_OF_TICKS + 1)

      -- ticks
      for i = 1, NUMBER_OF_TICKS do
        WindowLine (stats_win, GAUGE_LEFT + (i * ticks_at), myPositonY,
                    GAUGE_LEFT + (i * ticks_at), myPositonY + GAUGE_HEIGHT, ColourNameToRGB ("silver"), 0, 1)
      end -- for

      -- draw a box around it
      check (WindowRectOp (stats_win, 1, GAUGE_LEFT, myPositonY, GUAGE_SIZE - 5, myPositonY + GAUGE_HEIGHT,
              ColourNameToRGB ("lightgrey")))  -- frame entire box

end --function

function build_stats_win()
      --reinitilize the window with static items
      fill_stats_win()
      local sprite_width = 25
      WindowText (stats_win, font_normal, string.upper(ingame_prompt["st"]), (sprite_width * 6) , (TEXT_INSET), windowWidth - TEXT_INSET, 0, BRIGHTRED)

      --grab hp/ep/sp values from ingame_prompt
      local hp = string.format("%3s",ingame_prompt["hp"])
      local sp = string.format("%3s",ingame_prompt["sp"])
      local ep = string.format("%3s",ingame_prompt["ep"])
      local truehp = ingame_prompt["truehp"]
      local truesp = ingame_prompt["truesp"]
      local trueep = ingame_prompt["trueep"]
      local maxhp = ingame_prompt["maxhp"]
      local maxsp = ingame_prompt["maxsp"]
      local maxep = ingame_prompt["maxep"]

      --format percentages and draw them
      local myHP = hp .. "%"
      local mySP = sp .. "%"
      local myEP = ep .. "%"
      WindowText (stats_win, font_normal, myHP, (sprite_width * 3) , (TEXT_INSET + sprite_height * 1), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, mySP, (sprite_width * 3) , (TEXT_INSET + sprite_height * 2), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, myEP, (sprite_width * 3) , (TEXT_INSET + sprite_height * 3), windowWidth - TEXT_INSET, 0, windowTitleTextColour)

      --draw the guages
      draw_stat_guages(TEXT_INSET + sprite_height * 1, hp, RED)
      draw_stat_guages(TEXT_INSET + sprite_height * 2, sp, BLUE)
      draw_stat_guages(TEXT_INSET + sprite_height * 3, ep, GREEN)

      --determine strike/normal if hp/ep/sp were updates and draw them

      myHP = "[" .. truehp .. "/" .. maxhp .. "]"
      mySP = "[" .. truesp .. "/" .. maxsp .. "]"
      myEP = "[" .. trueep .. "/" .. maxep .. "]"
      WindowText (stats_win, track_update["hpFont"], myHP, (sprite_width * 18) , (TEXT_INSET + sprite_height * 1), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, track_update["spFont"], mySP, (sprite_width * 18) , (TEXT_INSET + sprite_height * 2), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, track_update["epFont"], myEP, (sprite_width * 18) , (TEXT_INSET + sprite_height * 3), windowWidth - TEXT_INSET, 0, windowTitleTextColour)

      --grab exp, cash, df values and format them
      local xp = commas(ingame_prompt["xp"])
      local exptolvl = commas (ingame_prompt["exptolvl"])
      local protolvl = ingame_prompt["protolvl"] .. "%"
      local exptoadv = commas (ingame_prompt["exptoadv"])
      local protoadv = ingame_prompt["protoadv"] .. "%"
      local cash = commas(ingame_prompt["cash"])
      local df = commas(ingame_prompt["df"])
      local my_exp = xp .. "\/" .. exptolvl .. " (" .. protolvl .. ")"
      local my_adv = exptoadv .. " (" ..protolvl .. ")"

      --display them
      WindowText (stats_win, font_normal, my_exp, (sprite_width * 3) , (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, my_adv, (sprite_width * 15) , (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, cash, (sprite_width * 3) , (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, df, (sprite_width * 15) , (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, windowTitleTextColour)

      -- daytime and phase -text
      local daytime = ingame_prompt["dt"] .. ", " .. string.lower(ingame_prompt["hr"])
      local phase  = string.lower(ingame_prompt["phase"])
      WindowText (stats_win, font_normal, daytime, (sprite_width * 3) , (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, phase, (sprite_width * 15) , (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, windowTitleTextColour)

      --daytime and phase -dynamic sprite
      local dt_img = ingame_prompt["dt"] .. "_img"
      local phase_img = phase .. "_img"
      WindowDrawImage (stats_win, dt_img, TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 5, 0, 0, miniwin.image_transparent_copy)  -- draw it
      WindowDrawImage (stats_win, phase_img, TEXT_INSET * 60, titleBoxHeight + TEXT_INSET + sprite_height * 5, 0, 0, miniwin.image_transparent_copy)  -- draw it

      --referesh the window with the updated information
      WindowShow (stats_win, true)
      movewindow.save_state (stats_win)
end -- function

function fill_stats_win()
      --blank out miniwindow
      WindowRectOp (stats_win, 2, 0, 0, windowWidth,   sprite_height * 7, BLACK)

      --create a title bar
      local titleBoxHeight = fontHeight + TEXT_INSET * 2
      local windowTitleBackgroundColour = BRIGHTBLACK
      local windowTitleTextColour = BRIGHTWHITE
      if not whoami then
        player_name =  "Player"
      else
         player_name = whoami
      end
      local title = player_name .. "'s Game Status"

      --draw the title bar
      WindowRectOp (stats_win, miniwin.rect_fill, 0, 0, 0, titleBoxHeight, windowTitleBackgroundColour)
      WindowText (stats_win, font_normal, title, TEXT_INSET, TEXT_INSET, windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowRectOp (stats_win, 1, 0, 0, windowWidth, windowHeight, BRIGHTWHITE)
      check (WindowRectOp (stats_win, 1, 0, 0, 0, 0, ColourNameToRGB ("lightgrey")))

      --fill window with static items
      WindowDrawImage (stats_win, "hp_img", TEXT_INSET, titleBoxHeight + TEXT_INSET, 0, 0, miniwin.image_transparent_copy)  -- draw it
      WindowDrawImage (stats_win, "sp_img", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 1, 0, 0, miniwin.image_transparent_copy)  -- draw it
      WindowDrawImage (stats_win, "ep_img", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 2, 0, 0, miniwin.image_transparent_copy)  -- draw it
      WindowDrawImage (stats_win, "exp_img", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 3, 0, 0, miniwin.image_transparent_copy)  -- draw it
      WindowDrawImage (stats_win, "adv_img", TEXT_INSET * 60, titleBoxHeight + TEXT_INSET + sprite_height * 3, 0, 0, miniwin.image_transparent_copy)  -- draw it
      WindowDrawImage (stats_win, "cash_img", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 4, 0, 0, miniwin.image_transparent_copy)  -- draw it
      WindowDrawImage (stats_win, "df_img", TEXT_INSET * 60, titleBoxHeight + TEXT_INSET + sprite_height * 4, 0, 0, miniwin.image_transparent_copy)  -- draw it
      WindowText (stats_win, font_normal, "HP :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 1), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, "SP :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 2), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, "EP :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 3), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, "XP :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, "AD :", (2 * TEXT_INSET * 31 + sprite_width) , (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, "$$ :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, "DF :", (2 * TEXT_INSET * 31 + sprite_width) , (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, "DT :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, "PH :", (2 * TEXT_INSET * 31 + sprite_width) , (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
end --function
