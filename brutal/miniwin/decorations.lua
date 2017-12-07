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
  SetOption("echo_colour",echo_colour)
  SetOption("F1macro", F1macro)
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

function AddMiniWindowTitleBar(windowName,title,blank)
  local windowInfo = movewindow.install (windowName, miniwin.pos_top_right, miniwin.create_absolute_location, true)
  local titleHeight = WindowFontInfo (windowName, title_font, 1) + (1 * TEXT_INSET)
  local titleWidth = windowInfo.window_left
  if blank == true then
    WindowRectOp (windowName, miniwin.rect_fill, 0, 0, 0, 0, theme.WINDOW_BACKGROUND)
  end --if
  WindowRectOp (windowName, miniwin.rect_fill, 0, 0, 0, titleHeight, theme.TITLE_BACKGROUND)
  WindowText (windowName, title_font, title, TEXT_INSET, 0, titleWidth - TEXT_INSET, 0, FOREGROUND)
  WindowRectOp (windowName, 1, 0, 0, 0, 0, theme.WINDOW_BORDER)
end --function AddMiniWindowTitleBar

function createHUD(args)
  local left, top, width, height, posY = 0, 0, 0, 0, 0 --declare empty variables for miniwindow
  --init info window if set false
  if use_classic_infobar == false then
    CreateMiniWindow(minfo_win)
    left, top, width, height = 0, (GetInfo(280) - sprite_height), GetInfo(281) * 0.72,  GetInfo(280) * 0.035
    ResizeAndAddBorder(minfo_win, left, top, width, height)
    ShowInfoBar (use_classic_infobar)
  end

  --init communications window if set true
  if comms_win_enabled == true then
    CreateMiniWindow(comms_win)
    left = GetInfo(281) * 0.72 --x-axis
    top = posY --y-axis
    width = GetInfo(281) * 0.28 - 1 --width size of miniwindow
    height = (WindowFontInfo (comms_win, title_font, 1)) + (2 * TEXT_INSET) + (16 * WindowFontInfo (comms_win, body_font, 1)) --height of miniwindow

    ResizeAndAddBorder(comms_win, left, top, width, height)
    WindowDragHandler(comms_win, comms_thumb, "comms_dragMove", "", 0)
    WindowRectOp (comms_win, miniwin.rect_fill, width - 15, top - 15, width, height, theme.TITLE_BACKGROUND)

    AddMiniWindowTitleBar(comms_win,"communications", true)
    local titleHeight = WindowFontInfo (comms_win, title_font, 1) + (1 * TEXT_INSET)

    posY = posY + height + 1 --calulate top position for next window
    comms_WINDOW_WIDTH = WindowInfo (comms_win, 3) - 2*TEXT_INSET - comms_scrollbar_size
  end --if

  --init buffs window if set true
  if buffs_win_enabled == true then
    CreateMiniWindow(buffs_win)
    left = GetInfo(281) * 0.72 --x-axis
    top =  posY --y-axis
    width = GetInfo(281) * 0.28 - 1 --width size of miniwindow
    height = (WindowFontInfo (buffs_win, title_font, 1)) + (2 * TEXT_INSET) + (3 * sprite_height) --height of miniwindow
    ResizeAndAddBorder(buffs_win, left, top, width, height)
    posY = posY + height + 1 --calulate top position for next window
    AddMiniWindowTitleBar(buffs_win,"active buffs")
  end --if

  --init party window if set true
  if party_win_enabled == true then
    CreateMiniWindow(party_win)
    CreateMiniWindow(pgrid_win)
    left = GetInfo(281) * 0.72 --x-axis
    top = posY --y-axis
    width = GetInfo(281) * 0.28 - 1 --width size of miniwindow
    --height = GetInfo(280) * 0.225 --height of miniwindow
    height = (WindowFontInfo (party_win, title_font, 1) + TEXT_INSET) + (12 * TEXT_INSET) + (WindowFontInfo (party_win, body_font, 1) * 12)
    ResizeAndAddBorder(party_win, left, top, width, height)
    local pgrid_height = height - (WindowFontInfo (party_win, title_font, 1) + TEXT_INSET)
    local pgrid_top = top + WindowFontInfo (party_win, title_font, 1) +  TEXT_INSET
    ResizeAndAddBorder(pgrid_win, left, pgrid_top , width, pgrid_height)
    posY = posY + height + 1 --calulate top position for next window
    AddMiniWindowTitleBar(party_win,"party placement -- create or join a party",true)
  end --if

  --init status window if set true
  if stats_win_enabled == true then
    CreateMiniWindow(stats_win)
    left = GetInfo(281) * 0.72 --x-axis
    top = posY --y-axis
    width = GetInfo(281) * 0.28 - 1 --width size of miniwindow
    height = (WindowFontInfo (stats_win, title_font, 1)) + (3 * TEXT_INSET) + (7 * sprite_height) --height of miniwindow
    ResizeAndAddBorder(stats_win, left, top, width, height)
    posY = posY + height + 1 --calulate top position for next window
    AddMiniWindowTitleBar(stats_win,"current status",true)
    --load images and sprites
    LoadAllSprites()
    for k, v in pairs (sprites) do
      WindowLoadImageMemory (stats_win, k, sprites[k],false) -- load image from memory
    end --for
  end --if
end --function

function showHUD(args)
  local brutal_windows = {
    decor_win,
    stats_win,
    comms_win,
    party_win,
    pgrid_win,
    minfo_win,
    buffs_win
  }
  for _, v in ipairs (brutal_windows) do
      WindowShow(v,args)
  end
  if args == false then
    TextRectangle(0, 0,GetInfo(281), 0 , 0, BACKGROUND, 0, FOREGROUND, 8)
    SetBackgroundImage("",6)
  else
    TextRectangle(0, 0,GetInfo(281) * 0.72, 0 - sprite_height, 0, BACKGROUND, 0, FOREGROUND, 8)
  end --if
  --disable triggers
  EnableTriggerGroup ("brutal_prompt_group",args)
  EnableTriggerGroup ("reset_status",args)
  EnableTriggerGroup ("brutal_party",args)
  EnableTriggerGroup ("brutal_comms_group",args)
end --functions
