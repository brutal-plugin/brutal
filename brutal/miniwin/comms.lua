--parts of this code has been adopted from http://www.gammon.com.au/forum/?id=10728&reply=5#reply5
--thank you Nick for all the hard work!

function brutal_tell(name,line,wildcards,styles)
  ReformatBrutalComms(name,line,wildcards,styles)
end --function brutal_tell

function brutal_channel_msg (name,line,wildcards,styles)
  ReformatBrutalComms(name,line,wildcards,styles)
end --function brutal_channel_msg

function ReformatBrutalComms(name,line,wildcards,styles)
  --inject the timestamp
  local date_format = "%b %d @%Hh%M "
  local tstamp = os.date (date_format)
  table.insert (styles, 1, {
        text = tstamp,
        textcolour  = theme.BODY_FONT_COLOUR,
        backcolour = theme.WINDOW_BACKGROUND,
        length = string.len (tstamp),
        style = 0,
      })
  --check if the whole line will fit miniwindow width
  local windowWidth = WindowInfo (comms_win, 3) -- get width
  local lineWidth =  WindowTextWidth(comms_win, body_font, tstamp .. line) -- width of line + tstamp
  local availableWidth = windowWidth - 2*TEXT_INSET - comms_scrollbar_size -- available space for line
  --check how many times we can split it
  local howManySplits = math.ceil(lineWidth / availableWidth)
  --if there is no need to split, then add it to comms table and redraw the miniwindow
  if howManySplits == 1 then
    table.insert (comms,styles)
  else
    SplitCommsWithStyles(styles,availableWidth,howManySplits)
  end --if
  RedrawBrutalCommsWin()
end --fuction ReformatBrutalComms

function SplitCommsWithStyles(styles,availableWidth,howManySplits)
  local pixelLength, textLength = 0, 0
  local tmp1 = {}
  for _,style in ipairs(styles) do
    pixelLength = pixelLength + WindowTextWidth(comms_win, body_font, style.text)
    if pixelLength <= availableWidth then --if the style can fit in the 1st line add it
      table.insert (tmp1,style)
      textLength = textLength + style.length --keep track of how many charcters have been used
      if howManySplits == 1 then --used when reitrated, this will be the last line
        table.insert (comms,tmp1)
      end --if
    else --we have to split the style
        -- look for trailing space (work backwards). remember where space is
        local col =   style.length - 1
        local split_col
        -- keep going until out of columns
        while col > 1 do
          local width = 0
          if textLength >= 1 then --should we add the trailing space for the styles before?
            width = WindowTextWidth (comms_win, body_font, " ") * textLength + WindowTextWidth (comms_win, body_font, style.text:sub (1, col))
          else
            width = WindowTextWidth (comms_win, body_font, style.text:sub (1, col))
          end --if
          if width <= availableWidth then
            if not split_col then
              split_col = col  -- in case no space found, this is where we can split
            end --if
            -- see if space here
            if style.text:sub (col, col) == " " then
              split_col = col
              break
            end -- if space
          end -- if will now fit
          col = col - 1
        end --while
        -- if we found a place to split, use old style, and make it shorter. Also make a copy and put the rest in that
        if split_col then
            local line_1st = copytable.shallow (style) --thank you Nick
            local line_2nd = copytable.shallow (style) --thank you Nick
            line_1st.text = style.text:sub (1, split_col)
            line_1st.length = split_col
            line_2nd.text = line_2nd.text:sub (split_col + 1)
            line_2nd.length = #line_2nd.text
            --add the first lines
            table.insert (tmp1,line_1st)
            table.insert (comms,tmp1)
            --check if the 2nd line needs to be split, then itrate thru function again.
            local tmp2 = {}
            if WindowTextWidth (comms_win, body_font, line_2nd.text) >= availableWidth then
              table.insert (tmp2,line_2nd)
              textLength = 0 --reset new line text length, dont need it, just so i know :)
              howManySplits = howManySplits - 1 --reduce by one, fastest way to calulate it.
              SplitCommsWithStyles(tmp2,availableWidth,howManySplits) --itrate it again
            else --doubt that we will reach to this, but lets just have it incase.
              table.insert (tmp2,line_2nd)
              table.insert (comms,tmp2)
            end --if WindowTextWidth (comms_win, body_font, line_2nd.text) >= availableWidth
        end -- if split_col
    end --if pixelLength <= availableWidth
  end --for _,style in ipairs(styles)
end --function SplitCommsWithStyles

function RedrawBrutalCommsWin()
  local left = WindowInfo (comms_win, 10)   --Where it is right now: left
  local top = WindowInfo (comms_win, 11)    --Where it is right now: top
  local width = WindowInfo (comms_win, 3)   --Width
  local height = WindowInfo (comms_win, 13) --Where it is right now: Height
  local titlefontHeight = WindowFontInfo (comms_win, title_font, 1) + (1 * TEXT_INSET)
  local bodyfontHeight = WindowFontInfo (comms_win, body_font, 1)
  local comms_posY = 0 --first line y-axis position
  AddMiniWindowTitleBar(comms_win, "communications", true)
  local comms_posX = TEXT_INSET --first line x-axis position
  if comms_posY == 0 then
    comms_posY = comms_posY + TEXT_INSET + titlefontHeight --just below the title bar
  else --dont need this, but I like it so I know.
    comms_posY = comms_posY + bodyfontHeight --just below the last line
  end --if
  local comms_buffer = {} --empty buffer to fill our chat in miniwindow
  comms_buffer = comms --yes, lets make a copy of the whole table and work on the buffer instead.
  local maxLines = math.floor((height - titlefontHeight) / bodyfontHeight) --maximum lines to fit inside miniwindow body
  if #comms_buffer > maxLines then
    for x=#comms_buffer, maxLines, -1 do
      table.remove (comms_buffer,1) --keep removing the first line till maxLines reached.
    end --for
  end --if
  for k, v in ipairs (comms_buffer) do --line number table (outer)
    for i, j in ipairs (v) do --styles table (inner)
      WindowText (comms_win, body_font, j.text, comms_posX, comms_posY , 0, 0, j.textcolour) --draw it
      comms_posX = comms_posX +  WindowTextWidth(comms_win, body_font, j.text) --next style position
    end --for
    comms_posY = comms_posY + bodyfontHeight --next line y-axis position
    comms_posX = TEXT_INSET --next line x-axis position
  end --for
end --function
