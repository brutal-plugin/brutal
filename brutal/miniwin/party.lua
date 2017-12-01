function CreateEmptyPartyGrid()
  for x=1,3 do
    for y=1,3 do
      local myPos = x .. y
      table.insert (PartyGrid, myPos, {
            name = "",
            hp  = 0,
            sp = 0,
            ep = 0,
          })
    end --for y
  end --for x
end --function CreateEmptyPartyGrid

--CreateEmptyPartyGrid()
function CheckPartyStatus(args)
  wait.make (function()
    if args == false then
      return
    end --if
    note ("checking if we are in a party ..")
    send ("p created")
    local party_check = wait.regexp ("^You are not in a party\\.$|^Your party was created\.+$",3)
    if party_check then
      if string.match (party_check,"Your party was created*") then
        note ("grabbing party status information ..")
        send ("ps")
        wait.match ("+-\*", 3)
        local failsafe, party = 0, {}
        while true do
          local line = wait.match ("*")
          failsafe = failsafe + 1
          if string.match(line,"`%-+") or failsafe > 9 then
            break
          else
            table.insert (party,line)
          end --if
        end --while
        for k, v in ipairs (party) do
          local n,x,y,h,s,e,p
          n = Trim(v:sub(3,12))
          x = v:sub(18,18)
          y = v:sub(20,20)
          h = tonumber(Trim(v:sub(35,37)))
          s = tonumber(Trim(v:sub(44,46)))
          e = tonumber(Trim(v:sub(53,55)))
          myParty[n] = {}
          table.insert (myParty[n],{
            row = x,
            col = y,
            hp = h,
            sp = s,
            ep = e
          })
        end --for
        FillPartyGrid()
      else
        if WindowInfo (party_win, 6) == false then --Is it hidden right now?
          AddMiniWindowTitleBar(party_win,"party placement -- currently not in a party",true)
        end --if
        myParty = {} --empty the party table so we do not display old stats
      end --if
    end --if
  end) --wait
end --function CheckPartyStatus

function FillPartyGrid()
  local left = WindowInfo (pgrid_win, 10)   --Where it is right now: left
  local top = WindowInfo (pgrid_win, 11)    --Where it is right now: top
  local width = WindowInfo (pgrid_win, 3)   --Width
  local height = WindowInfo (pgrid_win, 4)  --Height
  local bodyfontHeight =
  ResizeAndAddBorder(pgrid_win, left, top, width, height)
  DrawBlankPartyGrid()
  for player, info in pairs (myParty) do
    for k, v in pairs (info) do
      local grid_pos = (tostring(v.row..v.col))
      local hp = "HP:" .. v.hp .. "%"
      local sp = "SP:" .. v.sp .. "%"
      local ep = "EP:" .. v.ep .. "%"
      local myGrid = PartyGrid[grid_pos]
      local left, top = myGrid.left + TEXT_INSET,  myGrid.top + TEXT_INSET
      WindowText (pgrid_win, body_font, player, left, top , 0, 0, MAGENTA)
      top = top + WindowFontInfo (comms_win, body_font, 1)
      WindowText (pgrid_win, body_font, hp, left, top , 0, 0, theme.BODY_FONT_COLOUR)
      top = top + WindowFontInfo (comms_win, body_font, 1)
      WindowText (pgrid_win, body_font, sp, left, top , 0, 0, theme.BODY_FONT_COLOUR)
      top = top + WindowFontInfo (comms_win, body_font, 1)
      WindowText (pgrid_win, body_font, ep, left, top , 0, 0, theme.BODY_FONT_COLOUR)
    end --for
  end --for
  WindowShow (pgrid_win, true)
end --function

function DrawBlankPartyGrid()
  if not next (PartyGrid) then
    local windowWidth = WindowInfo (pgrid_win, 3) -- get width
    local windowHeight = WindowInfo (pgrid_win, 4) -- get height
    for row=1,3 do
      for col=1,3 do
        PartyGrid[row..col] = {
          left =  math.ceil((windowWidth/3) * (row - 1)) + TEXT_INSET,
          top = math.ceil((windowHeight/3) * (col - 1)) + TEXT_INSET,
          right = math.ceil((windowWidth/3) * (row)) - TEXT_INSET,
          bottom = math.ceil((windowHeight/3) * (col)) - TEXT_INSET
        }
      end --for
    end --for
  end --if
  for k,v in pairs (PartyGrid) do
    WindowRectOp (pgrid_win, miniwin.rect_frame, v.left, v.top, v.right, v.bottom, theme.WINDOW_BORDER)
  end --for
end --function DrawBlankPartyGrid
