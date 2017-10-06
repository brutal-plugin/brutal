function init_stats_win()

  -- get the font information they may have saved last time
  fontSize = miniwindow_font_size or 8
  fontName = miniwindow_font or GetInfo(23)

  windowTextColour = WHITE
  windowBackgroundColour = BLACK
  windowTitleTextColour = BRIGHTWHITE
  windowTitleBackgroundColour = BRIGHTBLACK

  FONT_ID = font_normal
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
                      windowinfo.window_flags,
                      windowBackgroundColour)  -- create window

  -- grab a font
  WindowFont (stats_win, FONT_ID, fontName, fontSize) -- define font

  -- work out how high it is
  fontHeight = WindowFontInfo (stats_win, FONT_ID, 1)   -- height of the font

  -- how big the title box is
  titleBoxHeight = fontHeight + TEXT_INSET * 2
  -- useable area for text
  windowClientHeight = windowHeight - titleBoxHeight

  movewindow.add_drag_handler (stats_win, 0, 0, 0, titleBoxHeight, miniwin.cursor_both_arrow)
  WindowRectOp (stats_win, miniwin.rect_fill, 0, 0, 0, titleBoxHeight, windowTitleBackgroundColour)
  WindowText (stats_win, FONT_ID, title, TEXT_INSET, TEXT_INSET, windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowRectOp (stats_win, 1, 0, 0, windowWidth, windowHeight, BRIGHTWHITE)

end --function

function build_stats_win()

end -- function
