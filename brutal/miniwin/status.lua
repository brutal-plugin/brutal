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

  sprite_width =  WindowImageInfo(stats_win, "hp.png", 2)
  sprite_height = WindowImageInfo(stats_win, "hp.png", 3)

  LoadAllSprites()
  for k, v in pairs (sprites) do
    WindowLoadImageMemory (stats_win, k, sprites[k]) -- load image from memory
    -- sprite_width or math.max (gauge_left,  WindowTextWidth (win, font_id, "Mana: "))

  end --for

  print (sprite_width, sprite_height)

  WindowDrawImage (stats_win, "hp.png", TEXT_INSET, titleBoxHeight + TEXT_INSET, 0, 0, miniwin.image_copy)  -- draw it
  WindowDrawImage (stats_win, "sp.png", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 1, 0, 0, miniwin.image_copy)  -- draw it
  WindowDrawImage (stats_win, "ep.png", TEXT_INSET, titleBoxHeight + TEXT_INSET + sprite_height * 2, 0, 0, miniwin.image_copy)  -- draw it

  WindowText (stats_win, FONT_ID, "HP", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 1), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, FONT_ID, "SP", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 2), windowWidth - TEXT_INSET, 0, windowTitleTextColour)
  WindowText (stats_win, FONT_ID, "EP", (2 * TEXT_INSET + sprite_width) , (TEXT_INSET + sprite_height * 3), windowWidth - TEXT_INSET, 0, windowTitleTextColour)

end --function

function build_stats_win()

end -- function

function LoadAllSprites ()
  local path = GetInfo(60) .. "brutal-plugin\\brutal\\sprites\\"
  local files = {"hp.png","sp.png","ep.png"}
  sprites = {}
  for k, v in pairs (files) do
    local f = assert (io.open (path .. v, "rb"))  -- open read-only, binary mode
    sprites[v] = f:read ("*a")  -- read all of it
    f:close ()  -- close it
  end --for
end --function
