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
  ResizeAndAddBorder(pgrid_win, left, top, width, height)
  DrawBlankPartyGrid()
  for player, info in pairs (myParty) do
    for k, v in pairs (info) do
      local grid_pos = (tostring(v.row..v.col))
      if grid_pos ~= "--" then
        local hp = string.format("%3s",v.hp) .. "%"
        local sp = string.format("%3s",v.sp) .. "%"
        local ep = string.format("%3s",v.ep) .. "%"
        local fourspaces = WindowTextWidth (pgrid_win, body_font, "    ") --4spaces
        local myGrid = PartyGrid[grid_pos]
        local left, top = myGrid.left + TEXT_INSET,  myGrid.top + TEXT_INSET
        local pos_x1 = left + fourspaces
        local pos_x2 = pos_x1 + TEXT_INSET --bar start
        local pos_x3 = (myGrid.right - 2*TEXT_INSET - fourspaces) --bar end
        local pos_x4 = (myGrid.right - TEXT_INSET - fourspaces) --percent pos
        --draw player name
        WindowText (pgrid_win, body_font, player, left, top , 0, 0, MAGENTA)
        top = top + WindowFontInfo (pgrid_win, body_font, 1)
        --draw player stats
        --hp
        WindowText (pgrid_win, body_font, "HP :", left, top , 0, 0, theme.BODY_FONT_COLOUR)
        DrawPartyGuage(pos_x2,pos_x3,top,v.hp, RED)
        WindowText (pgrid_win, body_font, hp, pos_x4, top , 0, 0, theme.BODY_FONT_COLOUR)
        top = top + WindowFontInfo (pgrid_win, body_font, 1)
        --sp
        WindowText (pgrid_win, body_font, "SP :", left, top , 0, 0, theme.BODY_FONT_COLOUR)
        DrawPartyGuage(pos_x2,pos_x3,top,v.sp, BLUE)
        WindowText (pgrid_win, body_font, sp, pos_x4, top , 0, 0, theme.BODY_FONT_COLOUR)
        top = top + WindowFontInfo (pgrid_win, body_font, 1)
        --ep
        WindowText (pgrid_win, body_font, "EP :", left, top , 0, 0, theme.BODY_FONT_COLOUR)
        DrawPartyGuage(pos_x2,pos_x3,top,v.ep, GREEN)
        WindowText (pgrid_win, body_font, ep, pos_x4, top , 0, 0, theme.BODY_FONT_COLOUR)
      end --if
    end --for
  end --for
  WindowShow (pgrid_win, true)
end --function

function updatePartyStats(name,line,wildcards)
  --\<party\>: (?<pname>\S+) \>\> HP:\[.+\] (?<p_hp>.+)% SP:\[.+\] (?<p_sp>.+)\% EP:\[.+] (?<p_ep>.+)%
  --\\\<party\>: (?<p_name>\S+) \\\>\\\> HP:\\\[.+\\\] (?<p_hp>.+)\\\% SP:\\\[.+\\\] (?<p_sp>.+)\\\% EP:\[.+] (?<p_ep>.+)\\\%
  local p_name = wildcards.p_name
  if p_name == whoami then
    local objects = {"hp","sp","ep"}
    for k, v in pairs (objects) do
      if tonumber(ingame_prompt[v]) ~= tonumber(wildcards[v]) then
        ingame_prompt[v] = tonumber(wildcards[v])
        track_update["source"] = "update"
        track_update[v] = true
      end --if
    end --for
    build_infobar()
    build_stats_win()
  end --if
  local hp, sp, ep = tonumber(wildcards.hp), tonumber(wildcards.sp), tonumber(wildcards.ep)
  for k, v in pairs (myParty) do
    if k == p_name then
      local outer = myParty[k]
      local inner = (outer[1])
      local row = inner["row"]
      local col = inner["col"]
      local tmp ={}
      table.insert (tmp,{
        row = row,
        col = col,
        hp = hp,
        sp = sp,
        ep = ep
      })
      myParty[k] = tmp
    end --if
  end --for
  FillPartyGrid()
end --function updatePartyGrid

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

function DrawPartyGuage(myPosX,bar_end,myPosY,myValue,myColour)
    --print (bar_start,bar_end,top,myValue,myColour)
    local guage_height = WindowFontInfo (pgrid_win, body_font, 1)
    local NUMBER_OF_TICKS = 4
    local BORDER_COLOUR = WHITE
    local GUAGE_SIZE = bar_end
    local Fraction = tonumber (myValue) / 100
    if Fraction > 1 then Fraction = 1 end
    if Fraction < 0 then Fraction = 0 end
    --WindowRectOp (pgrid_win, 2, bar_start, top, bar_end, top + bar_height, BLACK)  -- fill entire box
    WindowRectOp (pgrid_win, 2, myPosX, myPosY, GUAGE_SIZE, myPosY + guage_height, BLACK)  -- fill entire box
    local gauge_width = (GUAGE_SIZE - myPosX) * Fraction
    -- box size must be > 0 or WindowGradient fills the whole thing
   if math.floor (gauge_width) > 0 then

     -- top half
     WindowGradient (pgrid_win, myPosX, myPosY, myPosX + gauge_width, myPosY + guage_height / 2,
                     0x000000,
                     myColour, 2)

     -- bottom half
     WindowGradient (pgrid_win, myPosX, myPosY + guage_height / 2,
                     myPosX + gauge_width, myPosY +  guage_height,
                     myColour,
                     0x000000,
                     2)

   end -- non-zero

   -- show ticks
   local ticks_at = (GUAGE_SIZE - myPosX) / (NUMBER_OF_TICKS + 1)

   -- ticks
   for i = 1, NUMBER_OF_TICKS do
     WindowLine (pgrid_win, myPosX + (i * ticks_at), myPosY,
                 myPosX + (i * ticks_at), myPosY + guage_height, ColourNameToRGB ("silver"), 0, 1)
   end -- for

   -- draw a box around it
   check (WindowRectOp (pgrid_win, 1, myPosX, myPosY, GUAGE_SIZE, myPosY + guage_height,
           ColourNameToRGB ("lightgrey")))  -- frame entire box
end --function DrawPartyGuage
