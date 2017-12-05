function AddPartyTriggers()
  local party_guages = "^\\\<party\\\>: (?<p_name>.+) \\\>\\\> HP:\\\[.......\\\].(?<hp>.+)% SP:\\\[.......\\\] (?<sp>.+)% EP:\\\[.......\\\] (?<ep>.+)%$"
  local party_moves = "^(?<p_name>.+) moves to position (?<x>.+),(?<y>.+)\\\.$"
  local party_kicks = "^(?<p_leader>.+) kicks (?<p_name>.+) out from party\\\.$"
  local party_joins = "(?<p_name>.+) steps to position (?<x>.+),(?<y>.+) and starts following the leader\\\.$"
  local party_guide = "^(?<p_leader>.+) guides (?<p_name>.+) to position (?<x>.+),(?<y>.+)\\\.$"
  local party_leave = "^(?<p_name>.+) has left the party\\\.$"
  local party_destroy = "^You leave the party\\\.$"
  local party_swaps = "^(?<p_one>.+) moves to (?<x1>.+),(?<y1>.+) and (?<p_two>.+) moves to (?<x2>.+),(?<y2>.+)\\\.$"
  local party_rename = "^(?<p_name>.+) renames the party to '(?<party_name>.+)'\\\.$"
  local party_join = "^You join the party\\\.$"
  local party_create = "^You form a party called (?<party_name>.+)\\\.$"
  local flags = 8 + 32 --KeepEvaluating + RegularExpression
  AddTrigger("party_guages", party_guages, "", flags , -1, 0, "", "updatePartyStats")
  AddTrigger("party_moves", party_moves, "", flags , -1, 0, "", "updatePartyMoves")
  AddTrigger("party_kicks", party_kicks, "", flags , -1, 0, "", "updatePartyKicks")
  AddTrigger("party_leave", party_leave, "", flags , -1, 0, "", "updatePartyKicks")
  AddTrigger("party_joins", party_joins, "", flags , -1, 0, "", "updatePartyJoins")
  AddTrigger("party_guide", party_guide, "", flags , -1, 0, "", "updatePartyGuide")
  AddTrigger("party_swaps", party_swaps, "", flags , -1, 0, "", "updatePartySwaps")
  AddTrigger("party_rename", party_rename, "", flags , -1, 0, "", "updatePartyRename")
  AddTrigger("party_destroy", party_destroy, "", flags , -1, 0, "", "destroyParty")
  AddTrigger("party_create", party_create, "", flags + 1, -1, 0, "", "createNewParty") --always enabled
  AddTrigger("party_join", party_join, "", flags + 1, -1, 0, "", "CheckPartyStatus") --always enabled
  local brutal_party = {"guages","moves","kicks","leave","joins","guide","destroy","swaps","rename"}
  for k, v in pairs (brutal_party) do
    SetTriggerOption("party_" .. v,"group","brutal_party")
  end --for
end --function

function CheckPartyStatus()
  wait.make (function()
    send ("party status")
    local party_check = wait.regexp ("^\\\| Partyname: (?<party_name>.+)Kills made:(.+)\\\|$|^You are not in a party\\\!$",2)
    if party_check then
      if string.match (party_check,"| Partyname*") then
        local re = rex.new ("^\\\| Partyname: (?<party_name>.+)Kills made:(.+)\\\|$")
        local s, e, t = re:match (party_check)
        AddMiniWindowTitleBar(party_win,"party placement -- " .. Trim(t.party_name) ,true)
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
        EnableTriggerGroup ("brutal_party", true)
        FillPartyGrid()
      else
        EnableTriggerGroup ("brutal_party", false)
        if WindowInfo (party_win, 6) == false then --Is it hidden right now?
          AddMiniWindowTitleBar(party_win,"party placement -- create or join a party",true)
        end --if
        myParty = {} --empty the party table so we do not display old stats
      end --if
    end --if
  end) --wait
end --function CheckPartyStatus

function createNewParty(name,line,wildcards)
  myParty[whoami] = {}
  table.insert (myParty[whoami],{
    row = 1,
    col = 1,
    hp = ingame_prompt["hp"],
    sp = ingame_prompt["sp"],
    ep = ingame_prompt["ep"]
  })
  AddMiniWindowTitleBar(party_win,"party placement -- " .. wildcards.party_name,true)
  EnableTriggerGroup("brutal_party",true)
  FillPartyGrid()
end --function

function FillPartyGrid()
  if GetTriggerInfo ("party_guages", 8) == false then
    return
  end --if
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
  if wildcards.p_name == whoami then
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
    if k == wildcards.p_name then
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
      myParty[k] = {}
      myParty[k] = tmp
    end --if
  end --for
  FillPartyGrid()
end --function updatePartyGrid

function updatePartyMoves(name,line,wildcards)
  local p_name = wildcards.p_name
  local outer = myParty[p_name]
  local inner = outer[1]
  myParty[p_name] = {}
  table.insert (myParty[p_name],{
    row = wildcards.x,
    col = wildcards.y,
    hp = inner["hp"],
    sp = inner["sp"],
    ep = inner["ep"]
  })
  FillPartyGrid()
end --function

function updatePartyKicks(name,line,wildcards)
  table.remove (myParty[wildcards.p_name])
  FillPartyGrid()
end --function

function updatePartySwaps(name,line,wildcards)
  local p_one = {p_name = wildcards.p_one, x = wildcards.x1, y = wildcards.y1}
  local p_two = {p_name = wildcards.p_two, x = wildcards.x2, y = wildcards.y2}
  updatePartyMoves("name","line",p_one)
  updatePartyMoves("name","line",p_two)
end --function

function updatePartyRename(name,line,wildcards)
  AddMiniWindowTitleBar(party_win,"party placement -- " .. wildcards.party_name,true)
end --function

function destroyParty()
  myParty = {}
  AddMiniWindowTitleBar(party_win,"party placement -- create or join a party",true)
  EnableTriggerGroup ("brutal_party", false)
  WindowShow (pgrid_win, false)
end --function

function updatePartyGuide(name,line,wildcards)
  local p_name = wildcards.p_name
  if not next (myParty[p_name]) then
    local outer = myParty[p_name]
    local inner = outer[1]
    myParty[p_name] = {}
    table.insert (myParty[p_name],{
      row = wildcards.x,
      col = wildcards.y,
      hp = inner["hp"],
      sp = inner["sp"],
      ep = inner["ep"]
    })
  else
    myParty[p_name] ={}
    table.insert (myParty[p_name],{
      row = wildcards.x,
      col = wildcards.y,
      hp = 100,
      sp = 100,
      ep = 100
    })
  end --if
  FillPartyGrid()
end --function

function updatePartyJoins(name,line,wildcards)
  local p_name = wildcards.p_name
  if not (myParty[p_name]) then
    myParty[p_name] = {}
    table.insert (myParty[p_name],{
      row = wildcards.x,
      col = wildcards.y,
      hp = 100,
      sp = 100,
      ep = 100
    })
  else
    local outer = myParty[p_name]
    local inner = outer[1]
    myParty[p_name] = {}
    table.insert (myParty[p_name],{
      row = wildcards.x,
      col = wildcards.y,
      hp = inner["hp"],
      sp = inner["sp"],
      ep = inner["ep"]
    })
  end --if
  FillPartyGrid()
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
