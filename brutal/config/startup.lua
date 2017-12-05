function brutal_alias(name,line)
  wait.make (function()
      if line == "#brutal help" then
        brutal_arguments()
        return
      end --if
      if line == "#brutal config" then
        config_brutal_alias()
        return
      end --if
      if line == "#brutal" then
        activate_brutal()
        return
      end --if
  end) --wait
end --function

function config_brutal_alias()
  wait.make (function()
      note ("checking for #brutal alias .." )
      send ("alias #brutal")
      local check = wait.regexp("^The alias \\\#brutal wasn't found\\\.$",1)
        if check then
          wait.time(0.5)
          extract_prompt()
        else
          note ("alias already exists .. type ''#brutal' to activate/deactivate")
        end --if
  end) --wait
end --function

function activate_brutal ()
  wait.make (function()
    --check if trigger name 'prompt_trigger' is enabled
    if GetTriggerInfo("prompt_trigger",8) == true then
      setup_brutal_environment(false,false)
      note ("#brutal deactivated .. restoring prompt")
      send ("#brutal")
      InfoClear()
    else
      so_whoami()
      note ("checking for #brutal alias .." )
      send ("alias #brutal")
      local alias_check = wait.regexp("^\\\#brutal\\\s+set prompt(.+)$",1)
      if alias_check then
          note ("#brutal alias detected ..")
          setup_brutal_environment (true,false)
          wait.time(0.1)
          send ("")
          local prompt_check =  wait.regexp("^\\\#brutal(.+)$",1)
          if not prompt_check then
            note ("capturing prompt .. ")
            send ("set prompt " .. brutal_prompt )
          end --if
          local activation = wait.regexp("^Variable updated: prompt$",1)
          if activation then
            note ("#brutal activated .. ")
            return
          end --if
      else
        note ("try '#brutal config'")
      end --if
    end --if
  end) --wait
end --if

function so_whoami()
  if whoami == "" then
    note ("grabbing player name ..")
    send ("whoami")
    local player_name = wait.match("You are *.",1)
    if player_name then
      whoami = string.match (player_name,"^You are (.+)\.$")
      note ("Yes, people take notice of your identity crisis.")
    end --if
  end --if
end --function


function setup_brutal_environment(args,source)
  --enable/disable triggers
  EnableTriggerGroup ("brutal_prompt_group",args)
  EnableTriggerGroup ("reset_status",args)
  EnableTriggerGroup ("brutal_party", args)

  --setup theme if enabled
  if brutal_theme_enabled == true then
    set_brutal_theme()
  end --if

  local left, top, width, height, posY = 0, 0, 0, 0, 0 --declare empty variables for miniwindow
  --init info window if set false
  if use_classic_infobar == false then
    CreateMiniWindow(minfo_win)
    left, top, width, height = 0, (GetInfo(280) - sprite_height), GetInfo(281) * 0.72,  GetInfo(280) * 0.035
    ResizeAndAddBorder(minfo_win, left, top, width, height)
    TextRectangle(0, 0,GetInfo(281) * 0.72, 0 - sprite_height, 0, BACKGROUND, 0, FOREGROUND, 8)
    WindowShow (minfo_win, true)
    ShowInfoBar (use_classic_infobar)
  else
    WindowShow (minfo_win, false)
    TextRectangle(0, 0,GetInfo(281) * 0.72, 0 , 0, BACKGROUND, 0, FOREGROUND, 8)
  end

  --init communications window if set true
  if comms_win_enabled == true then
    CreateMiniWindow(comms_win)
    left = GetInfo(281) * 0.72 --x-axis
    top = posY --y-axis
    width = GetInfo(281) * 0.28 - 1 --width size of miniwindow
    height = (WindowFontInfo (comms_win, title_font, 1)) + (2 * TEXT_INSET) + (16 * WindowFontInfo (comms_win, body_font, 1)) --height of miniwindow

    ResizeAndAddBorder(comms_win, left, top, width, height)
    WindowAddHotspot(comms_win, comms_thumb,
                    width - 15, top - 15, width, height,  -- position will be changed when we draw the window anyway
                     "", -- MouseOver
                     "", -- CancelMouseOver
                     "comms_MouseDown",
                     "", -- CancelMouseDown
                     "", -- MouseUp
                     "scrollbar tooltip",   -- TooltipText
                     miniwin.cursor_arrow,
                     0)  -- Flags
    WindowDragHandler(comms_win, comms_thumb, "comms_dragMove", "", 0)
    WindowRectOp (comms_win, miniwin.rect_fill, width - 15, top - 15, width, height, theme.TITLE_BACKGROUND)

    AddMiniWindowTitleBar(comms_win,"communications", true)
    local titleHeight = WindowFontInfo (comms_win, title_font, 1) + (1 * TEXT_INSET)
    WindowAddHotspot(comms_win, comms_wheel_hotspot,
                     0, titleHeight, width - comms_scrollbar_size, 0,
                     "", -- MouseOver
                     "", -- CancelMouseOver
                     "", -- MouseDown
                     "", -- CancelMouseDown
                     "comms_MouseUpInClient", -- MouseUp
                     "", -- TooltipText
                     miniwin.cursor_arrow,
                     0)  -- Flags

    WindowScrollwheelHandler(comms_win, comms_wheel_hotspot, "comms_wheelMove");
    EnableTriggerGroup ("brutal_comms_group",args)

    posY = posY + height + 1 --calulate top position for next window
    comms_WINDOW_WIDTH = WindowInfo (comms_win, 3) - 2*TEXT_INSET - comms_scrollbar_size
    WindowShow (comms_win, args)
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
    WindowShow (buffs_win, args)
  end --if

  --init party window if set true
  if party_win_enabled == true then
    CreateMiniWindow(party_win)
    CreateMiniWindow(pgrid_win)
    EnableTriggerGroup ("brutal_party", true)
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
    AddMiniWindowTitleBar(party_win,"party placement -- create or join a par",true)
    if args == true then
      wait.time(0.1)
      note ("checking if we are in a party ..")
      CheckPartyStatus()
    end --if
    WindowShow (party_win, args)
    WindowShow (pgrid_win, args)
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
    WindowShow (stats_win, args)
    for k, v in pairs (sprites) do
      WindowLoadImageMemory (stats_win, k, sprites[k],false) -- load image from memory
    end --for
  end --if

  if args == true and source == false then
    eval_terminal()
  end --if
end

function extract_prompt()
  wait.make (function ()
    eval_terminal()
    wait.time (0.1)
    note ("trying to determine prompt from 'set' ..")
    send ("set")
    local user_prompt = wait.match("| prompt               : Yes :*",2)
    if user_prompt then
      local dump, keep = string.match(user_prompt,"^\| prompt\(.+): Yes : (.+)\|$")
      if keep then
        note ("discovered prompt settings ..")
        local pause = wait.regexp ("^Random typomessages(.+)$")
        if pause then
          note ("backing up current prompt in 'alias #brutal' .. ")
          send ("alias #brutal set prompt " .. keep)
        end --if
        pause = wait.regexp ("^Alias:(.+)added\\\.$",1)
        if pause then
          note "reconfiguring prompt for use for #brutal .."
          send ("set prompt " .. brutal_prompt )
        end --if
        pause = wait.regexp ("^Variable updated: prompt$",1)
        if pause then
          so_whoami()
          setup_brutal_environment (true,true)
        end --if
        wait.time (1)
        note ("#brutal configuration completed ..")
        note("type '#brutal' to activate/deactivate ..")
        note ("#brutal activated ..")
        send ("")
      else
        note ("could not extract prompt settings .. aborting !! ")
        return
      end --if
    else
      note ("#brutal needs you to set a prompt !! ..")
      wait.time (0.5)
      send ("help prompt")
      return
    end --if
  end) --wait
end --extract_prompt

function eval_terminal()
  wait.time(1)
  note ("checking terminal settings ..")
  send ("term")
  local term = wait.match ("Your term type is \*",1)
    if term then
      local re = rex.new("^Your term type is (?<term_type>.+) \\(autodetect (?<term_autodetect>.+)\\) and your screen dimensions are (?<term_size>.+)\.$")
      local st, ed, ta = re:match(term)
      if ta.term_type == terminal_type and ta.term_size == terminal_size and ta.term_autodetect == terminal_autodetect then
        note ("terminal already configured for #brutal")
        return
      end --if
      if ta.term_autodetect ~= terminal_autodetect then
        send ("term autodetect")
        local x = wait.match ("Your term type is \*",1)
        if x then
          note ("changed terminal autodetect from " .. ta.term_autodetect .. " to ".. terminal_autodetect)
        end --if
      end --if
      if ta.term_type ~= terminal_type then
        send ("term " .. terminal_type)
        local x = wait.match ("Your term type is \*",1)
        if x then
          note ("changed terminal type from " .. ta.term_type .. " to ".. terminal_type)
        end --if
      end --if
      if ta.term_size ~= terminal_size then
        send ("term " .. terminal_size)
        local x = wait.match ("Your term type is \*",1)
        if x then
          note ("changed terminal size from " .. ta.term_size .. " to ".. terminal_size)
        end --if
      end --if
    end --if
end --eval_terminal
