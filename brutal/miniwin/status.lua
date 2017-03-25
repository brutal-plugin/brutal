function build_stat_window()
  local hp = ingame_prompt["hp"]
  local sp = ingame_prompt["sp"]
  local ep = ingame_prompt["ep"]

  local info_hp = ("HP" .. string.format("%4s",hp) .. "% ")
  local info_sp = ("SP" .. string.format("%4s",sp) .. "% ")
  local info_ep = ("EP" .. string.format("%4s",ep) .. "% ")

  -- fill entire box to clear it
  check (WindowRectOp (stat_win, 2, 0, 0, 0, 0, BACKGROUND))  -- fill entire box

  -- Edge around box rectangle
  check (WindowCircleOp (stat_win, 3, 0, 0, 0, 0, BORDER_COLOUR, 0, 2, 0, 1))

  vertical = 6  -- pixel to start at

  --insert rest of character information
  DoInfo()

  --insert health bars
  DoGauge(info_hp, hp, ColourNameToRGB(red) )
  DoGauge(info_sp, sp, ColourNameToRGB(blue) )
  DoGauge(info_ep, ep, ColourNameToRGB(green) )

end --function


function init_stat_win()
  GAUGE_LEFT = 61
  GAUGE_HEIGHT = 12

  WINDOW_WIDTH = 300
  WINDOW_HEIGHT = 140
  NUMBER_OF_TICKS = 9
  BORDER_COLOUR = BRIGHTBLACK


  local x, y, mode, flags =
     tonumber (GetVariable ("windowx")) or 0,
     tonumber (GetVariable ("windowy")) or 0,
     tonumber (GetVariable ("windowmode")) or 8, -- bottom right
     tonumber (GetVariable ("windowflags")) or 4

  -- make miniwindow so I can grab the font info
  check (WindowCreate (stat_win,
                x, y, WINDOW_WIDTH, WINDOW_HEIGHT,
                mode,
                flags,
                BACKGROUND) )
   -- make a hotspot
   WindowAddHotspot(stat_win, "hs1",
                    0, 0, 0, 0,   -- whole window
                    "",   -- MouseOver
                    "",   -- CancelMouseOver
                    "mousedown",
                    "",   -- CancelMouseDown
                    "",   -- MouseUp
                    "Drag to move",  -- tooltip text
                    1, 0)  -- hand cursor
   WindowDragHandler(stat_win, "hs1", "dragmove", "dragrelease", 0)
   check (WindowFont (stat_win, font_normal, miniwindow_font, miniwindow_font_size, false, false, false, false, 0, 0))  -- normal
   check (WindowFont (stat_win, font_strike, miniwindow_font, miniwindow_font_size, false, false, false, true, 0, 0))  -- normal
   check (WindowFont (stat_win, font_under, miniwindow_font, miniwindow_font_size, false, false, true, false, 0, 0))  -- normal
   font_height = WindowFontInfo (stat_win, font_normal, 1)  -- height
   if GetVariable ("enabled") == "false" then
     ColourNote ("yellow", "", "Warning: Plugin " .. GetPluginName ().. " is currently disabled.")
     check (EnablePlugin(GetPluginID (), false))
     return
   end -- they didn't enable us last time
 end -- OnPluginInstall


 function mousedown(flags, hotspot_id)
  -- find where mouse is so we can adjust window relative to mouse
  startx, starty = WindowInfo (stat_win, 14), WindowInfo (stat_win, 15)

  -- find where window is in case we drag it offscreen
  origx, origy = WindowInfo (stat_win, 10), WindowInfo (stat_win, 11)
end -- mousedown

function dragmove(flags, hotspot_id)

  -- find where it is now
  local posx, posy = WindowInfo (stat_win, 17),
                     WindowInfo (stat_win, 18)

  -- move the window to the new location
  WindowPosition(stat_win, posx - startx, posy - starty, 0, 6);

  -- change the mouse cursor shape appropriately
  if posx < 0 or posx > GetInfo (281) or
     posy < 0 or posy > GetInfo (280) then
    check (SetCursor ( 11))   -- X cursor
  else
    check (SetCursor ( 1))   -- hand cursor
  end -- if

end -- dragmove

function dragrelease(flags, hotspot_id)

  local newx, newy = WindowInfo (stat_win, 17), WindowInfo (stat_win, 18)

  -- don't let them drag it out of view
  if newx < 0 or newx > GetInfo (281) or
     newy < 0 or newy > GetInfo (280) then
     -- put it back
    WindowPosition(stat_win, origx, origy, 0, 6);
  end -- if out of bounds

end -- dragrelease


function DoGauge (sPrompt, Percent, Colour)

  local Fraction = tonumber (Percent) / 100

  if Fraction > 1 then Fraction = 1 end
  if Fraction < 0 then Fraction = 0 end


  local width = WindowTextWidth (stat_win, font_normal, sPrompt)

  WindowText (stat_win, font_normal, sPrompt,
                             GAUGE_LEFT - width, vertical, 0, 0, FOREGROUND)

  WindowRectOp (stat_win, 2, GAUGE_LEFT, vertical, WINDOW_WIDTH - 5, vertical + GAUGE_HEIGHT,
                          BACKGROUND)  -- fill entire box


  local gauge_width = (WINDOW_WIDTH - GAUGE_LEFT - 5) * Fraction

   -- box size must be > 0 or WindowGradient fills the whole thing
  if math.floor (gauge_width) > 0 then

    -- top half
    WindowGradient (stat_win, GAUGE_LEFT, vertical, GAUGE_LEFT + gauge_width, vertical + GAUGE_HEIGHT / 2,
                    0x000000,
                    Colour, 2)

    -- bottom half
    WindowGradient (stat_win, GAUGE_LEFT, vertical + GAUGE_HEIGHT / 2,
                    GAUGE_LEFT + gauge_width, vertical +  GAUGE_HEIGHT,
                    Colour,
                    0x000000,
                    2)

  end -- non-zero

  -- show ticks
  local ticks_at = (WINDOW_WIDTH - GAUGE_LEFT - 5) / (NUMBER_OF_TICKS + 1)

  -- ticks
  for i = 1, NUMBER_OF_TICKS do
    WindowLine (stat_win, GAUGE_LEFT + (i * ticks_at), vertical,
                GAUGE_LEFT + (i * ticks_at), vertical + GAUGE_HEIGHT, ColourNameToRGB (brightblack), 0, 1)
  end -- for

  -- draw a box around it
  check (WindowRectOp (stat_win, 1, GAUGE_LEFT, vertical, WINDOW_WIDTH - 5, vertical + GAUGE_HEIGHT,
          ColourNameToRGB (brightblack)))  -- frame entire box

  vertical = vertical + font_height + 1
end -- function

function DoInfo()
  --exp, exptolvl, protolvl
  DrawText (whoami .. "'s Status",font_under,"yes")

  --ad, exptoadv, prototoadv
  DrawText ("Meh one",font_normal,"yes")

  --df, cash
  DrawText ("Meh too",font_normal,"yes")

  --phase, daytime, hour
  DrawText ("Meh three",font_normal,"yes")

  --status
  DrawText ("Meh four",font_normal,"yes")
end --function

function DrawText(drawline,font_style,new_line)
  local width =   WindowTextWidth (font_normal, font_style, drawline)
  local height  = WindowFontInfo (stat_win, font_style, 1)
  WindowText (stat_win, font_style, drawline, 5 - width, vertical, 0, 0, FOREGROUND)
  if new_line == "yes" then
    vertical = vertical + height + 1
  end --if
end --function
