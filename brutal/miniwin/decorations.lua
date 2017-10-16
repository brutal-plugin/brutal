function init_window_decorations()
  TextRectangle(0, 0, GetInfo (213) * 148, 0, 5, BACKGROUND, 2, FOREGROUND, 8)
  local bg_img = GetInfo(60) .. "brutal-plugin\\brutal\\sprites\\bg_img.png"
  SetBackgroundImage(bg_img,6)
end --function

function LoadAllSprites ()
  local path = GetInfo(60) .. "brutal-plugin\\brutal\\sprites\\"
  local files = {"hp","sp","ep","exp","adv","cash","df","earth","fire","air","water","magic","day","night","dtime"}
  for k, v in pairs (files) do
    local f = assert (io.open (path .. v .. ".png", "rb"))  -- open read-only, binary mode
    sprites[v .. "_img"] = f:read ("*a")  -- read all of it
    f:close ()  -- close it
  end --for
end --function

function init_stats_win()
  -- get the font information they may have saved last time
  local fontSize = miniwindow_font_size or 8
  local fontName = miniwindow_font or GetInfo(23)
  local windowTextColour = WHITE
  local windowBackgroundColour = BLACK
  local windowTitleTextColour = BRIGHTWHITE
  local windowTitleBackgroundColour = BRIGHTBLACK

  WINDOW_POSITION = miniwin.pos_bottom_right

  windowinfo = movewindow.install (stats_win, WINDOW_POSITION, 0)  -- default position / flags
  -- create window
  WindowCreate (stats_win,  windowinfo.window_left,
                      windowinfo.window_top,
                      windowWidth,
                      sprite_height * 7,
                      windowinfo.window_mode,
                      20,
                      windowBackgroundColour)

  -- grab a font
  WindowFont (stats_win, font_normal, fontName, fontSize) -- define font

  -- work out how high it is
  fontHeight = WindowFontInfo (stats_win, font_normal, 1)   -- height of the font

  -- how big the title box is
  titleBoxHeight = fontHeight + TEXT_INSET * 2
  -- useable area for text
  windowClientHeight = windowHeight - titleBoxHeight

  if not whoami then
    title =  "Player" .. "'s Game Status"
  else
    title = whoami .. "'s Game Status"
  end

  movewindow.add_drag_handler (stats_win, 0, 0, 0, titleBoxHeight, miniwin.cursor_both_arrow)
  for k, v in pairs (sprites) do
    WindowLoadImageMemory (stats_win, k, sprites[k],false) -- load image from memory
  end --for
  fill_stats_win()
end --function

function init_comms_win()
    -- get the font information they may have saved last time
    fontSize = miniwindow_font_size or 8
    fontName = miniwindow_font or GetInfo(23)

    windowTextColour = WHITE
    windowBackgroundColour = BLACK
    windowTitleTextColour = BRIGHTWHITE
    windowTitleBackgroundColour = BRIGHTBLACK
    WINDOW_POSITION = miniwin.pos_center_right
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
