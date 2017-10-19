function init_comms_win()
    -- get the font information they may have saved last time
    local fontSize = miniwindow_font_size or 8
    local fontName = miniwindow_font or GetInfo(23)
    local windowTextColour = WHITE
    local windowBackgroundColour = BLACK
    local windowTitleTextColour = BRIGHTWHITE
    local windowTitleBackgroundColour = BRIGHTBLACK

    WINDOW_POSITION = miniwin.pos_top_right
    title = "Communications Channel"

    windowinfo = movewindow.install (comms_win, WINDOW_POSITION, 0)  -- default position / flags

    -- make the window
    WindowCreate (comms_win,  windowinfo.window_left,
                        windowinfo.window_top,
                        windowWidth,
                        windowHeight,
                        windowinfo.window_mode,
                        4,
                        --windowinfo.window_flags,
                        WHITE)  -- create window

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

function build_comms_win()

end --function

function brutal_tell(name,line,wildcards,styles)
  brutal_write (name,line,wildcards,styles)
end --function

function brutal_channel_msg (name,line,wildcards,styles)
  brutal_write (name,line,wildcards,styles)
end --function

function brutal_write (name,line,wildcards,styles)
  local fontSize = miniwindow_font_size or 8
  local fontName = miniwindow_font or GetInfo(23)
  local windowTextColour = WHITE
  local windowBackgroundColour = BLACK
  local windowTitleTextColour = BRIGHTWHITE
  local windowTitleBackgroundColour = BRIGHTBLACK
  local left = TEXT_INSET
  --local top = (n - 1) * font_height + TEXT_INSET
  local top = fontSize * 2 + TEXT_INSET
  -- display each style, including the appropriate background under it
  for _, v in ipairs (styles) do
    local width = WindowTextWidth (comms_win, font_normal, v.text) -- get width of text
    local right = left + width                       -- work out RH side
    local bottom = top + fontSize                 -- work out bottom
    --WindowRectOp (comms_win, miniwin.rect_fill, left, top, right, bottom,
    --              ColourNameToRGB (v.backcolour or windowBackgroundColour))  -- draw background
    WindowText (comms_win, font_normal, v.text, left, top, windowWidth - TEXT_INSET, 0,
                  ColourNameToRGB (v.textcolour or windowTextColour))  -- draw text
    left = left + width  -- advance horizontally
  end -- for each style run
  Redraw()
end --function
