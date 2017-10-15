function init_window_decorations()
  TextRectangle(0, 0, GetInfo (213) * 148, 0, 5, BACKGROUND, 2, FOREGROUND, 8)
  local bg_img = GetInfo(60) .. "brutal-plugin\\brutal\\sprites\\bg_img.png"
  SetBackgroundImage(bg_img,6)
end --function

function init_stats_win()

  -- get the font information they may have saved last time
  fontSize = miniwindow_font_size or 8
  fontName = miniwindow_font or GetInfo(23)

  windowTextColour = WHITE
  windowBackgroundColour = BLACK
  windowTitleTextColour = BRIGHTWHITE
  windowTitleBackgroundColour = BRIGHTBLACK

  WINDOW_POSITION = miniwin.pos_bottom_right
  if not whoami then
    player_name =  "Player"
  else
    player_name = whoami
  end
  title = player_name .. "'s Game Status"

  windowinfo = movewindow.install (stats_win, WINDOW_POSITION, 0)  -- default position / flags

  -- make the window
  WindowCreate (stats_win,  windowinfo.window_left,
                      windowinfo.window_top,
                      windowWidth,
                      windowHeight,
                      windowinfo.window_mode,
                      4,
                      --windowinfo.window_flags,
                      windowBackgroundColour)  -- create window

  -- grab a font
  WindowFont (stats_win, font_normal, fontName, fontSize) -- define font

  -- work out how high it is
  fontHeight = WindowFontInfo (stats_win, font_normal, 1)   -- height of the font

  -- how big the title box is
  titleBoxHeight = fontHeight + TEXT_INSET * 2
  -- useable area for text
  windowClientHeight = windowHeight - titleBoxHeight

  movewindow.add_drag_handler (stats_win, 0, 0, 0, titleBoxHeight, miniwin.cursor_both_arrow)
  WindowRectOp (stats_win, miniwin.rect_fill, 0, 0, 0, titleBoxHeight, windowTitleBackgroundColour)
  WindowText (stats_win, font_normal, title, TEXT_INSET, TEXT_INSET, windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowRectOp (stats_win, 1, 0, 0, windowWidth, windowHeight, BRIGHTWHITE)

  sprite_width =  WindowImageInfo(stats_win, "hp.png", 2) or 34
  sprite_height = WindowImageInfo(stats_win, "hp.png", 3) or 34

  LoadAllSprites()
  for k, v in pairs (sprites) do
    WindowLoadImageMemory (stats_win, k, sprites[k],false) -- load image from memory
    -- sprite_width or math.max (gauge_left,  WindowTextWidth (stats_win, font_normal, "Mana: "))

  end --for

  WindowDrawImage (stats_win, "hp.png", TEXT_INSET, titleBoxHeight + TEXT_INSET, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "sp.png", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 1, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "ep.png", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 2, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "exp.png", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 3, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "adv.png", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 4, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "cash.png", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 5, 0, 0, miniwin.image_transparent_copy)  -- draw it
  WindowDrawImage (stats_win, "df.png", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 6, 0, 0, miniwin.image_transparent_copy)  -- draw it

  WindowText (stats_win, font_normal, "HP", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 1), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "SP", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 2), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "EP", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 3), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "EXP", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 4), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "ADV", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 5), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "CASH", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 6), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, font_normal, "DF", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 7), windowWidth - TEXT_INSET, 0, windowTitleTextColour)

  check (WindowRectOp (stats_win, 1, 0, 0, 0, 0, ColourNameToRGB ("lightgrey")))

end --function

function init_comms_win()
    -- get the font information they may have saved last time
    fontSize = miniwindow_font_size or 8
    fontName = miniwindow_font or GetInfo(23)

    windowTextColour = WHITE
    windowBackgroundColour = BLACK
    windowTitleTextColour = BRIGHTWHITE
    windowTitleBackgroundColour = BRIGHTBLACK

    font_normal = font_normal
    WINDOW_POSITION = miniwin.pos_center_right
    title = "Communications Channel"


    windowinfo = movewindow.install (comms_win, WINDOW_POSITION, 0)  -- default position / flags

    -- make the window
    WindowCreate (comms_win,  windowinfo.window_left,
                        windowinfo.window_top,
                        windowWidth,
                        windowHeight,
                        windowinfo.window_mode,
                        7,
                        --windowinfo.window_flags,
                        windowBackgroundColour)  -- create window

    -- grab a font
    WindowFont (comms_win, font_normal, fontName, fontSize) -- define font

    -- work out how high it is
    fontHeight = WindowFontInfo (comms_win, font_normal, 1)   -- height of the font
    -- how big the title box is
    titleBoxHeight = fontHeight + TEXT_INSET * 2
    -- useable area for text
    windowClientHeight = windowHeight - titleBoxHeight

    movewindow.add_drag_handler (comms_win, 0, 0, 0, titleBoxHeight, miniwin.cursor_both_arrow)
    WindowRectOp (comms_win, miniwin.rect_fill, 0, 0, 0, titleBoxHeight, windowTitleBackgroundColour)
    WindowText (comms_win, font_normal, title, TEXT_INSET, TEXT_INSET, windowWidth - TEXT_INSET, 0, windowTitleTextColour)
    WindowRectOp (comms_win, 1, 0, 0, windowWidth, windowHeight, BRIGHTWHITE)

  end --function
