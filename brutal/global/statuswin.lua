function build_status_window()
  local hp = ingame_prompt["hp"]
  local sp = ingame_prompt["sp"]
  local ep = ingame_prompt["ep"]

  local info_hp = ("HP " .. ingame_prompt["truehp"] .. "\/".. ingame_prompt["maxhp"] .. string.format("%4s",hp) .. "% ")
  local info_sp = ("SP " .. ingame_prompt["truesp"] .. "\/".. ingame_prompt["maxsp"] .. string.format("%4s",sp) .. "% ")
  local info_ep = ("EP " .. ingame_prompt["trueep"] .. "\/".. ingame_prompt["maxep"] .. string.format("%4s",ep) .. "% ")

  -- fill entire box to clear it
  check (WindowRectOp (win, 2, 0, 0, 0, 0, BACKGROUND_COLOUR))  -- fill entire box

  -- Edge around box rectangle
  check (WindowCircleOp (win, 3, 0, 0, 0, 0, BORDER_COLOUR, 0, 2, 0, 1))

  vertical = 6  -- pixel to start at


  DoGauge(info_hp, hp, ColourNameToRGB("red") )
  DoGauge(info_sp, sp, ColourNameToRGB("blue") )
  DoGauge(info_ep, ep, ColourNameToRGB("green") )

end --function


function init_statuswin()
  GAUGE_LEFT = 140
  GAUGE_HEIGHT = 12

  WINDOW_WIDTH = 300
  WINDOW_HEIGHT = 65
  NUMBER_OF_TICKS = 5

  BACKGROUND_COLOUR = ColourNameToRGB (background)
  FONT_COLOUR = ColourNameToRGB (foreground)
  BORDER_COLOUR = ColourNameToRGB (brightblack)
  win = GetPluginID () .. "statuswin"
  font_id = "fn"

  font_name = miniwindow_font    -- the actual font
  font_size = miniwindow_font_size

  local x, y, mode, flags =
     tonumber (GetVariable ("windowx")) or 0,
     tonumber (GetVariable ("windowy")) or 0,
     tonumber (GetVariable ("windowmode")) or 8, -- bottom right
     tonumber (GetVariable ("windowflags")) or 0

  -- make miniwindow so I can grab the font info
  check (WindowCreate (win,
                x, y, WINDOW_WIDTH, WINDOW_HEIGHT,
                mode,
                flags,
                BACKGROUND_COLOUR) )
   -- make a hotspot
   WindowAddHotspot(win, "hs1",
                    0, 0, 0, 0,   -- whole window
                    "",   -- MouseOver
                    "",   -- CancelMouseOver
                    "mousedown",
                    "",   -- CancelMouseDown
                    "",   -- MouseUp
                    "Drag to move",  -- tooltip text
                    1, 0)  -- hand cursor
   WindowDragHandler(win, "hs1", "dragmove", "dragrelease", 0)
   check (WindowFont (win, font_id, font_name, font_size, false, false, false, false, 0, 0))  -- normal
   font_height = WindowFontInfo (win, font_id, 1)  -- height
   if GetVariable ("enabled") == "false" then
     ColourNote ("yellow", "", "Warning: Plugin " .. GetPluginName ().. " is currently disabled.")
     check (EnablePlugin(GetPluginID (), false))
     return
   end -- they didn't enable us last time
   WindowShow (win, true)
 end -- OnPluginInstall

 function mousedown(flags, hotspot_id)

  -- find where mouse is so we can adjust window relative to mouse
  startx, starty = WindowInfo (win, 14), WindowInfo (win, 15)

  -- find where window is in case we drag it offscreen
  origx, origy = WindowInfo (win, 10), WindowInfo (win, 11)
end -- mousedown

function dragmove(flags, hotspot_id)

  -- find where it is now
  local posx, posy = WindowInfo (win, 17),
                     WindowInfo (win, 18)

  -- move the window to the new location
  WindowPosition(win, posx - startx, posy - starty, 0, 2);

  -- change the mouse cursor shape appropriately
  if posx < 0 or posx > GetInfo (281) or
     posy < 0 or posy > GetInfo (280) then
    check (SetCursor ( 11))   -- X cursor
  else
    check (SetCursor ( 1))   -- hand cursor
  end -- if

end -- dragmove

function dragrelease(flags, hotspot_id)
  local newx, newy = WindowInfo (win, 17), WindowInfo (win, 18)

  -- don't let them drag it out of view
  if newx < 0 or newx > GetInfo (281) or
     newy < 0 or newy > GetInfo (280) then
     -- put it back
    WindowPosition(win, origx, origy, 0, 2);
  end -- if out of bounds

end -- dragrelease


function DoGauge (sPrompt, Percent, Colour)

  local Fraction = tonumber (Percent) / 100

  if Fraction > 1 then Fraction = 1 end
  if Fraction < 0 then Fraction = 0 end


  local width = WindowTextWidth (win, font_id, sPrompt)

  WindowText (win, font_id, sPrompt,
                             GAUGE_LEFT - width, vertical, 0, 0, FONT_COLOUR)

  WindowRectOp (win, 2, GAUGE_LEFT, vertical, WINDOW_WIDTH - 5, vertical + GAUGE_HEIGHT,
                          BACKGROUND_COLOUR)  -- fill entire box


  local gauge_width = (WINDOW_WIDTH - GAUGE_LEFT - 5) * Fraction

   -- box size must be > 0 or WindowGradient fills the whole thing
  if math.floor (gauge_width) > 0 then

    -- top half
    WindowGradient (win, GAUGE_LEFT, vertical, GAUGE_LEFT + gauge_width, vertical + GAUGE_HEIGHT / 2,
                    0x000000,
                    Colour, 2)

    -- bottom half
    WindowGradient (win, GAUGE_LEFT, vertical + GAUGE_HEIGHT / 2,
                    GAUGE_LEFT + gauge_width, vertical +  GAUGE_HEIGHT,
                    Colour,
                    0x000000,
                    2)

  end -- non-zero

  -- show ticks
  local ticks_at = (WINDOW_WIDTH - GAUGE_LEFT - 5) / (NUMBER_OF_TICKS + 1)

  -- ticks
  for i = 1, NUMBER_OF_TICKS do
    WindowLine (win, GAUGE_LEFT + (i * ticks_at), vertical,
                GAUGE_LEFT + (i * ticks_at), vertical + GAUGE_HEIGHT, ColourNameToRGB ("silver"), 0, 1)
  end -- for

  -- draw a box around it
  check (WindowRectOp (win, 1, GAUGE_LEFT, vertical, WINDOW_WIDTH - 5, vertical + GAUGE_HEIGHT,
          ColourNameToRGB ("lightgrey")))  -- frame entire box

  vertical = vertical + font_height + 3
end -- function
