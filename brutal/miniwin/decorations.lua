function init_window_decorations()
  --TextRectangle(0, 0, GetInfo (213) * 148, 0, 5, BACKGROUND, 2, FOREGROUND, 8)
  if brutal_output_font == "Inconsolata" or
    infobar_font  == "Inconsolata" or
    miniwindow_font  == "Inconsolata" then
    AddFont(brutal_path .. "theme\\Inconsolata-Regular.ttf")
  end --if
  if brutal_theme_enabled then
    SetNormalColour (1,ColourNameToRGB("black"))
    SetNormalColour (2,ColourNameToRGB("crimson"))
    SetNormalColour (3,ColourNameToRGB("forestgreen"))
    SetNormalColour (4,ColourNameToRGB("chocolate"))
    SetNormalColour (5,ColourNameToRGB("dodgerblue"))
    SetNormalColour (6,ColourNameToRGB("magenta"))
    SetNormalColour (7,ColourNameToRGB("cadetblue"))
    SetNormalColour (8,ColourNameToRGB("lightgrey"))
    SetBoldColour (1,ColourNameToRGB("gray"))
    SetBoldColour (2,ColourNameToRGB("red"))
    SetBoldColour (3,ColourNameToRGB("chartreuse"))
    SetBoldColour (4,ColourNameToRGB("yellow"))
    SetBoldColour (5,ColourNameToRGB("mediumblue"))
    SetBoldColour (6,ColourNameToRGB("mediumvioletred"))
    SetBoldColour (7,ColourNameToRGB("teal"))
    SetBoldColour (8,ColourNameToRGB("white"))
    local bg_img = brutal_path .. "theme\\bg_img.png"
    SetOutputFont (brutal_output_font, brutal_output_font_size)
    SetInputFont(brutal_output_font, brutal_output_font_size, 0, 0)
    SetCommandWindowHeight(4 * TEXT_INSET + brutal_output_font_size )
    SetOption("input_background_colour", input_background_colour)
    SetOption("input_text_colour", input_text_colour)
    SetOption("confirm_before_replacing_typing", confirm_before_replacing_typing)
    SetOption("F1macro", F1macro)
    SetOption("ErrorNotificationToOutputWindow", ErrorNotificationToOutputWindow)
    SetOption("max_output_lines", max_output_lines)
    SetOption("wrap_column", wrap_column)
    --GetInfo(257) -- Info bar window height (long)
    --GetInfo(258) -- Info bar window width (long)
    --GetDeviceCaps(8) -- Horizontal width in pixels
    SetBackgroundImage(bg_img,6)
    Redraw()
  end --if
end --function

function LoadAllSprites ()
  local path = brutal_path .. "sprites\\"
  local files = {"hp","sp","ep","exp","adv","cash","df","earth","fire","air","water","magic","day","night","dtime"}
  for k, v in pairs (files) do
    local f = assert (io.open (path .. v .. ".png", "rb"))  -- open read-only, binary mode
    sprites[v .. "_img"] = f:read ("*a")  -- read all of it
    f:close ()  -- close it
  end --for
end --function
