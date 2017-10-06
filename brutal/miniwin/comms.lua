function init_comms_win()
  -- get the font information they may have saved last time
  fontSize = miniwindow_font_size or 8
  fontName = miniwindow_font or GetInfo(23)

  windowTextColour = WHITE
  windowBackgroundColour = BLACK
  windowTitleTextColour = BRIGHTWHITE
  windowTitleBackgroundColour = BRIGHTBLACK

  FONT_ID = font_normal
  WINDOW_POSITION = miniwin.pos_center_right
  title = "Communications Channel"


  windowinfo = movewindow.install (comms_win, WINDOW_POSITION, 0)  -- default position / flags

  -- make the window
  WindowCreate (comms_win,  windowinfo.window_left,
                      windowinfo.window_top,
                      windowWidth,
                      windowHeight,
                      windowinfo.window_mode,
                      windowinfo.window_flags,
                      windowBackgroundColour)  -- create window

  -- grab a font
  WindowFont (comms_win, FONT_ID, fontName, fontSize) -- define font

  -- work out how high it is
  fontHeight = WindowFontInfo (comms_win, FONT_ID, 1)   -- height of the font
  -- how big the title box is
  titleBoxHeight = fontHeight + TEXT_INSET * 2
  -- useable area for text
  windowClientHeight = windowHeight - titleBoxHeight

  movewindow.add_drag_handler (comms_win, 0, 0, 0, titleBoxHeight, miniwin.cursor_both_arrow)
  WindowRectOp (comms_win, miniwin.rect_fill, 0, 0, 0, titleBoxHeight, windowTitleBackgroundColour)
  WindowText (comms_win, FONT_ID, title, TEXT_INSET, TEXT_INSET, windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowRectOp (comms_win, 1, 0, 0, windowWidth, windowHeight, BRIGHTWHITE)

end --function

function build_comms_win()

end --function

function brutal_tell(name,line,wildcards,styles)
  brutal_write (name,line,wildcards,styles)
end --function

function brutal_channel_msg (name,line,wildcards,styles)

end --function

function brutal_write (name,line,wildcards,styles)

end --function
