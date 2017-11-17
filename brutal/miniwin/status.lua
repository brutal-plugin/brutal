function build_stats_win()
  --blank window and re-add title bar
  check (WindowRectOp (stats_win, 2, 0, 0, 0, 0, theme.WINDOW_BACKGROUND))
  check (WindowRectOp (stats_win, 1, 0, 0, 0, 0, theme.WINDOW_BORDER))
  AddMiniWindowTitleBar(stats_win,"current status")
  --add empty container for x,y
  local posX_1, posX_2, posY = 0, 0, 0
  --get the window width
  local windowInfo = movewindow.install (windowName, miniwin.pos_top_right, miniwin.create_absolute_location, true)
  local windowWidth = windowInfo.window_left
  --get y position for first sprite, just after title bar
  posY =  (2 * TEXT_INSET) + WindowFontInfo (stats_win, title_font, 1)
  --draw the static images
  WindowDrawImage (stats_win, "hp_img", TEXT_INSET, posY, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "sp_img", TEXT_INSET, posY + sprite_height * 1, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "ep_img", TEXT_INSET, posY + sprite_height * 2, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "exp_img", TEXT_INSET, posY + sprite_height * 3, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "adv_img", TEXT_INSET * 50, posY + sprite_height * 3, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "cash_img", TEXT_INSET, posY + sprite_height * 4, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "df_img", TEXT_INSET * 50, posY + sprite_height * 4, 0, 0, miniwin.image_transparent_copy)  -- draw it
  --draw the dynamic images
  local dt_img = ingame_prompt["dt"] .. "_img"
  local phase_img = ingame_prompt["phase"] .. "_img"
  WindowDrawImage (stats_win, dt_img, TEXT_INSET, posY + sprite_height * 5, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, phase_img, TEXT_INSET * 50, posY + sprite_height * 5, 0, 0, miniwin.image_transparent_copy)  -- draw it
  --draw the static text titles for images
  posX_1 = (2 * TEXT_INSET + sprite_width)
  posX_2 = (2 * TEXT_INSET * 26 + sprite_width)
  WindowText (stats_win, body_font, "HP :", posX_1, (TEXT_INSET + sprite_height * 1), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, "SP :", posX_1, (TEXT_INSET + sprite_height * 2), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, "EP :", posX_1, (TEXT_INSET + sprite_height * 3), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, "XP :", posX_1, (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, "AD :", posX_2, (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, "$$ :", posX_1, (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, "DF :", posX_2, (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, "DT :", posX_1, (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, "PH :", posX_2, (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  --draw the dynamic text
  posX_1 = posX_1 + WindowTextWidth (stats_win,body_font,"     ") -- five spaces, for x-axis
  posX_2 = posX_2 + WindowTextWidth (stats_win,body_font,"     ") -- five spaces, for x-axis
  --grab hp/ep/sp values from ingame_prompt
  local hp = string.format("%3s",ingame_prompt["hp"])
  local sp = string.format("%3s",ingame_prompt["sp"])
  local ep = string.format("%3s",ingame_prompt["ep"])

  --format percentages and draw them
  local myHP = hp .. "%"
  local mySP = sp .. "%"
  local myEP = ep .. "%"
  WindowText (stats_win, body_font, myHP, posX_1 , (TEXT_INSET + sprite_height * 1), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, mySP, posX_1 , (TEXT_INSET + sprite_height * 2), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, myEP, posX_1 , (TEXT_INSET + sprite_height * 3), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)

  --grab exp, cash, df values, daytime and phase and format them
  local xp = commas(ingame_prompt["xp"])
  local exptolvl = commas (ingame_prompt["exptolvl"])
  local protolvl = ingame_prompt["protolvl"] .. "%"
  local exptoadv = commas (ingame_prompt["exptoadv"])
  local protoadv = ingame_prompt["protoadv"] .. "%"
  local cash = commas(ingame_prompt["cash"])
  local df = commas(ingame_prompt["df"])
  local my_exp = xp .. "\/" .. exptolvl .. " (" .. protolvl .. ")"
  local my_adv = exptoadv .. " (" .. protoadv .. ")"
  local daytime = ingame_prompt["dt"] .. ", " .. string.lower(ingame_prompt["hr"])
  local phase  = string.lower(ingame_prompt["phase"])
  --display them
  WindowText (stats_win, body_font, my_exp, posX_1 , (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, my_adv, posX_2 , (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, cash, posX_1 , (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, df, posX_2 , (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, daytime, posX_1, (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, body_font, phase, posX_2 , (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  --draw the health guages
  local posX_3 = posX_1 + WindowTextWidth (stats_win,body_font,"     ") -- five spaces, for x-axis
  local guage_height = WindowFontInfo (stats_win, body_font, 1)
  draw_stat_guages(posX_3,guage_height,sprite_height * 1 + TEXT_INSET, hp, RED)
  draw_stat_guages(posX_3,guage_height,sprite_height * 2 + TEXT_INSET, sp, BLUE)
  draw_stat_guages(posX_3,guage_height,sprite_height * 3 + TEXT_INSET, ep, GREEN)
  --fill in the health stats
  local truehp = ingame_prompt["truehp"]
  local truesp = ingame_prompt["truesp"]
  local trueep = ingame_prompt["trueep"]
  local maxhp = ingame_prompt["maxhp"]
  local maxsp = ingame_prompt["maxsp"]
  local maxep = ingame_prompt["maxep"]
  myHP = "[" .. truehp .. "/" .. maxhp .. "]"
  mySP = "[" .. truesp .. "/" .. maxsp .. "]"
  myEP = "[" .. trueep .. "/" .. maxep .. "]"
  posX_3 = posX_3 + 280
  --draw the text
  WindowText (stats_win, track_update["hpFont"], myHP, posX_3, (TEXT_INSET + sprite_height * 1), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, track_update["spFont"], mySP, posX_3, (TEXT_INSET + sprite_height * 2), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
  WindowText (stats_win, track_update["epFont"], myEP, posX_3, (TEXT_INSET + sprite_height * 3), windowWidth - TEXT_INSET, 0, theme.BODY_FONT_COLOUR)
end --function

function draw_stat_guages(myPosX,guage_height,myPosY, myValue, myColour)
      NUMBER_OF_TICKS = 9
      BORDER_COLOUR = WHITE
      GUAGE_SIZE = 375
      local Fraction = tonumber (myValue) / 100

      if Fraction > 1 then Fraction = 1 end
      if Fraction < 0 then Fraction = 0 end
      WindowRectOp (stats_win, 2, myPosX, myPosY, GUAGE_SIZE, myPosY + guage_height,
                              BLACK)  -- fill entire box
      local gauge_width = (GUAGE_SIZE - myPosX) * Fraction

       -- box size must be > 0 or WindowGradient fills the whole thing
      if math.floor (gauge_width) > 0 then

        -- top half
        WindowGradient (stats_win, myPosX, myPosY, myPosX + gauge_width, myPosY + guage_height / 2,
                        0x000000,
                        myColour, 2)

        -- bottom half
        WindowGradient (stats_win, myPosX, myPosY + guage_height / 2,
                        myPosX + gauge_width, myPosY +  guage_height,
                        myColour,
                        0x000000,
                        2)

      end -- non-zero

      -- show ticks
      local ticks_at = (GUAGE_SIZE - myPosX) / (NUMBER_OF_TICKS + 1)

      -- ticks
      for i = 1, NUMBER_OF_TICKS do
        WindowLine (stats_win, myPosX + (i * ticks_at), myPosY,
                    myPosX + (i * ticks_at), myPosY + guage_height, ColourNameToRGB ("silver"), 0, 1)
      end -- for

      -- draw a box around it
      check (WindowRectOp (stats_win, 1, myPosX, myPosY, GUAGE_SIZE, myPosY + guage_height,
              ColourNameToRGB ("lightgrey")))  -- frame entire box

end --function draw_stat_guages
