
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
      --DoGauge ("HP",ingame_prompt["hp"],RED)

end -- function

function LoadAllSprites ()
  local path = GetInfo(60) .. "brutal-plugin\\brutal\\sprites\\"
  local files = {"hp","sp","ep","exp","adv","cash","df","earth","fire","air","water","magic","day","night","dtime"}
  sprites = {}
  for k, v in pairs (files) do
    local f = assert (io.open (path .. v .. ".png", "rb"))  -- open read-only, binary mode
    sprites[v .. "_img"] = f:read ("*a")  -- read all of it
    f:close ()  -- close it
  end --for
end --function
