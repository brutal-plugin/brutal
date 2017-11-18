function set_brutal_theme()
  SetThemeColours()
  local bg_img = brutal_path .. "theme\\bg_img.png"
  SetOutputFont (theme.OUTPUT_FONT_NAME, theme.OUTPUT_FONT_SIZE)
  SetInputFont(theme.INPUT_FONT_NAME, theme.INPUT_FONT_SIZE, 0, 0)
  SetCommandWindowHeight(4 * TEXT_INSET + theme.BODY_FONT_SIZE )
  SetOption("input_background_colour", input_background_colour)
  SetOption("input_text_colour", input_text_colour)
  SetOption("confirm_before_replacing_typing", confirm_before_replacing_typing)
  SetOption("ErrorNotificationToOutputWindow", ErrorNotificationToOutputWindow)
  SetOption("max_output_lines", max_output_lines)
  SetOption("wrap_column", wrap_column)
  SetOption("lower_case_tab_completion", lower_case_tab_completion)
  --F1Macro needs db hack, SetOption("F1macro", F1macro) does not work
  db = sqlite3.open(GetInfo (82))  -- open preferences
  db:exec 'UPDATE prefs SET value = 1 WHERE name = "F1macro"'
  db:close()  -- close
  SetBackgroundImage(bg_img,6)
  Redraw()
end --function set_brutal_theme

function LoadAllSprites ()
  local path = brutal_path .. "sprites\\"
  local files = {"hp","sp","ep","exp","adv","cash","df","earth","fire","air","water","magic","day","night","karma","status"}
  for k, v in pairs (files) do
    local f = assert (io.open (path .. v .. ".png", "rb"))  -- open read-only, binary mode
    sprites[v .. "_img"] = f:read ("*a")  -- read all of it
    f:close ()  -- close it
  end --for
end --function LoadAllSprites

function CreateMiniWindow(windowName)
  --Dummy window to get font characteristics
  --long WindowCreate(BSTR WindowName, long Left, long Top, long Width, long Height, short Position, long Flags, long BackgroundColour);
  --print (GetInfo (280)) -- Output window client height
  --print (GetInfo (281)) -- Output window client width
  check (WindowCreate (windowName, 0, 0, 0, 0, miniwin.pos_top_left, miniwin.create_transparent, theme.WINDOW_BACKGROUND))
  check (WindowFont(windowName, body_font, theme.BODY_FONT_NAME, theme.BODY_FONT_SIZE))       --add body_font to window
  check (WindowFont(windowName, title_font, theme.TITLE_FONT_NAME, theme.TITLE_FONT_SIZE))    --add title_font to window
  check (WindowFont (windowName, font_normal, theme.BODY_FONT_NAME, theme.BODY_FONT_SIZE, false, false, false, false)) --define font for normal
  check (WindowFont (windowName, font_strike, theme.BODY_FONT_NAME, theme.BODY_FONT_SIZE, false, false, false, true))  --define font for strike
  --install the window movement handler, get back the window position
  --windowinfo = movewindow.install (windowName, miniwin.pos_top_right, miniwin.create_absolute_location, true)
end --function CreateMiniWindow

function ResizeAndAddBorder(windowName, left, top, width, height)
  --long WindowCreate(BSTR WindowName, long Left, long Top, long Width, long Height, short Position, long Flags, long BackgroundColour);
  --long WindowRectOp(BSTR WindowName, short Action, long Left, long Top, long Right, long Bottom, long Colour1, long Colour2);
  check (WindowCreate (windowName, left, top, width, height, miniwin.pos_top_left, (miniwin.create_transparent + miniwin.create_absolute_location + miniwin.create_keep_hotspots), theme.WINDOW_BACKGROUND))
  check (WindowRectOp (windowName, 1, 0, 0, 0, 0, theme.WINDOW_BORDER))
end --function SetMiniWindowPositions

function AddMiniWindowTitleBar(windowName,title)
  local windowInfo = movewindow.install (windowName, miniwin.pos_top_right, miniwin.create_absolute_location, true)
  local titleHeight = WindowFontInfo (windowName, title_font, 1) + (1 * TEXT_INSET)
  local titleWidth = windowInfo.window_left
  WindowRectOp (windowName, miniwin.rect_fill, 0, 0, 0, titleHeight, theme.TITLE_BACKGROUND)
  WindowText (windowName, title_font, title, TEXT_INSET, 0, titleWidth - TEXT_INSET, 0, FOREGROUND)
  WindowRectOp (windowName, 1, 0, 0, 0, 0, theme.WINDOW_BORDER)
end --function AddMiniWindowTitleBar
