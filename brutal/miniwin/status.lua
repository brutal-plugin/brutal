
  function DoGauge (sPrompt, Percent, Colour)
    GAUGE_LEFT = 55
    GAUGE_HEIGHT = 15

    WINDOW_WIDTH = 200
    WINDOW_HEIGHT = 65
    NUMBER_OF_TICKS = 5
    BACKGROUND_COLOUR = ColourNameToRGB "rosybrown"
    FONT_COLOUR = ColourNameToRGB "darkred"
    BORDER_COLOUR = ColourNameToRGB "#553333"
    vertical = 10
    font_height = WindowFontInfo (stats_win, font_normal, 1)


    local Fraction = tonumber (Percent) / 100

    if Fraction > 1 then Fraction = 1 end
    if Fraction < 0 then Fraction = 0 end

    local width = WindowTextWidth (stats_win, font_normal, sPrompt)

    WindowText (stats_win, font_normal, sPrompt,
                               GAUGE_LEFT - width, vertical, 0, 0, FONT_COLOUR)

    WindowRectOp (stats_win, 2, GAUGE_LEFT, vertical, WINDOW_WIDTH - 5, vertical + GAUGE_HEIGHT,
                            BACKGROUND_COLOUR)  -- fill entire box


    local gauge_width = (WINDOW_WIDTH - GAUGE_LEFT - 5) * Fraction

     -- box size must be > 0 or WindowGradient fills the whole thing
    if math.floor (gauge_width) > 0 then

      -- top half
      WindowGradient (stats_win, GAUGE_LEFT, vertical, GAUGE_LEFT + gauge_width, vertical + GAUGE_HEIGHT / 2,
                      0x000000,
                      Colour, 2)

      -- bottom half
      WindowGradient (stats_win, GAUGE_LEFT, vertical + GAUGE_HEIGHT / 2,
                      GAUGE_LEFT + gauge_width, vertical +  GAUGE_HEIGHT,
                      Colour,
                      0x000000,
                      2)

    end -- non-zero

    -- show ticks
    local ticks_at = (WINDOW_WIDTH - GAUGE_LEFT - 5) / (NUMBER_OF_TICKS + 1)

    -- ticks
    for i = 1, NUMBER_OF_TICKS do
      WindowLine (stats_win, GAUGE_LEFT + (i * ticks_at), vertical,
                  GAUGE_LEFT + (i * ticks_at), vertical + GAUGE_HEIGHT, ColourNameToRGB ("silver"), 0, 1)
    end -- for

    -- draw a box around it
    check (WindowRectOp (stats_win, 1, GAUGE_LEFT, vertical, WINDOW_WIDTH - 5, vertical + GAUGE_HEIGHT,
            ColourNameToRGB ("lightgrey")))  -- frame entire box

    vertical = vertical + font_height + 3
  end -- function


function build_stats_win()
      --reinitilize the window
      init_stats_win()
      fill_stats_win()

      local hp = string.format("%3s",ingame_prompt["hp"])
      local sp = string.format("%3s",ingame_prompt["sp"])
      local ep = string.format("%3s",ingame_prompt["ep"])

      WindowText (stats_win, font_normal, hp .. "%", (5 * TEXT_INSET + sprite_width * 2) , (TEXT_INSET + sprite_height * 1), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, sp .. "%", (5 * TEXT_INSET + sprite_width * 2) , (TEXT_INSET + sprite_height * 2), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, ep .. "%", (5 * TEXT_INSET + sprite_width * 2) , (TEXT_INSET + sprite_height * 3), windowWidth - TEXT_INSET, 0, windowTitleTextColour)

      --grab exp, cash, df values
      local xp = commas(ingame_prompt["xp"])
      local exptolvl = commas (ingame_prompt["exptolvl"])
      local protolvl = ingame_prompt["protolvl"] .. "%"
      local exptoadv = commas (ingame_prompt["exptoadv"])
      local protoadv = ingame_prompt["protoadv"] .. "%"
      local cash = commas(ingame_prompt["cash"])
      local df = commas(ingame_prompt["df"])
      my_exp = xp .. "\/" .. exptolvl .. " (" .. protolvl .. ")"
      my_adv = exptoadv .. " (" ..protolvl .. ")"
      --display them
      WindowText (stats_win, font_normal, my_exp, (5 * TEXT_INSET + sprite_width * 2) , (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, my_adv, (73 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, cash, (5 * TEXT_INSET + sprite_width * 2) , (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, df, (73 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, windowTitleTextColour)

      -- daytime and phase
      local dt = ingame_prompt["dt"]
      local hr = string.lower(ingame_prompt["hr"])
      local daytime = dt .. ", " .. hr
      local phase  = string.lower(ingame_prompt["phase"])
      WindowText (stats_win, font_normal, daytime, (5 * TEXT_INSET + sprite_width * 2) , (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      WindowText (stats_win, font_normal, phase, (73 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
      local dt_img = dt .. "_img"
      local phase_img = phase .. "_img"
      WindowDrawImage (stats_win, dt_img, TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 5, 0, 0, miniwin.image_transparent_copy)  -- draw it
      WindowDrawImage (stats_win, phase_img, TEXT_INSET * 60, titleBoxHeight + TEXT_INSET + sprite_height * 5, 0, 0, miniwin.image_transparent_copy)  -- draw it
      --referesh the window with the updated information
      WindowShow (stats_win, true)
end -- function

function fill_stats_win()
  WindowDrawImage (stats_win, "hp_img", TEXT_INSET, titleBoxHeight + TEXT_INSET, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "sp_img", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 1, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "ep_img", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 2, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "exp_img", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 3, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "adv_img", TEXT_INSET * 60, titleBoxHeight + TEXT_INSET + sprite_height * 3, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "cash_img", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 4, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "df_img", TEXT_INSET * 60, titleBoxHeight + TEXT_INSET + sprite_height * 4, 0, 0, miniwin.image_transparent_copy)  -- draw it

  WindowText (stats_win, font_normal, "HP   :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 1), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "SP   :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 2), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "EP   :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 3), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "EXP  :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "ADV   :", (2 * TEXT_INSET * 31 + sprite_width) , (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "CASH :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "DF    :", (2 * TEXT_INSET * 31 + sprite_width) , (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "TIME :", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "PHASE :", (2 * TEXT_INSET * 31 + sprite_width) , (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
end --function
