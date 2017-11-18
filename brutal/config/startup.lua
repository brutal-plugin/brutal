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
      local check = wait.regexp("^The alias #brutal wasn't found\.$",1)
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
      local alias_check = wait.regexp("^\#brutal.+$",1)
      if alias_check then
          setup_brutal_environment (true,false)
          send ("")
          local prompt_check =  wait.regexp("^\#brutal.+$",1)
          if not prompt_check then
            note ("capturing prompt .. ")
            send ("set prompt " .. brutal_prompt )
          end --if
          wait.time (0.1)
          note ("#brutal activated .. ")
          return
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
      --<party>: Wazimu >> HP:[#######] 100% SP:[#######] 100% EP:[###### ]  99%
      local my_party_guages = "^\\\<party\\\>: ".. whoami .." \\\>\\\> HP:\\\[.......\\\].(?<hp>.+)% SP:\\\[.......\\\] (?<sp>.+)% EP:\\\[.......\\\] (?<ep>.+)%$"
      AddTrigger("party_self_bar", my_party_guages, "", 41 , -1, 0, "", "healthbar_update")
    end --if
  end --if
end --function


function setup_brutal_environment(args,source)
  --enable/disable triggers
  EnableTriggerGroup ("brutal_prompt_group",args)
  EnableTriggerGroup ("reset_status",args)

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
    posY = posY + height + 1 --calulate top position for next window
    AddMiniWindowTitleBar(comms_win,"communications")
    EnableTriggerGroup ("brutal_comms_group",args)
    WindowShow (comms_win, args)
  end --if

  --init buffs window if set true
  if buffs_win_enabled == true then
    CreateMiniWindow(buffs_win)
    left = GetInfo(281) * 0.72 --x-axis
    top =  posY --y-axis
    width = GetInfo(281) * 0.28 - 1 --width size of miniwindow
    height = (WindowFontInfo (buffs_win, title_font, 1)) + (2 * TEXT_INSET) + (5 * sprite_height) --height of miniwindow
    ResizeAndAddBorder(buffs_win, left, top, width, height)
    posY = posY + height + 1 --calulate top position for next window
    AddMiniWindowTitleBar(buffs_win,"active buffs")
    WindowShow (buffs_win, args)
  end --if

  --init party window if set true
  if party_win_enabled == true then
    CreateMiniWindow(party_win)
    left = GetInfo(281) * 0.72 --x-axis
    top = posY --y-axis
    width = GetInfo(281) * 0.28 - 1 --width size of miniwindow
    height = GetInfo(280) * 0.225 --height of miniwindow
    ResizeAndAddBorder(party_win, left, top, width, height)
    posY = posY + height + 1 --calulate top position for next window
    AddMiniWindowTitleBar(party_win,"party placement")
    WindowShow (party_win, args)
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
    AddMiniWindowTitleBar(stats_win,"current status")
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
    wait.time (0.5)
    note ("trying to determine prompt from 'set' ..")
    send ("set")
    local user_prompt = wait.match("| prompt               : Yes :*",2)
    if user_prompt then
      local dump, keep = string.match(user_prompt,"^\| prompt\(.+): Yes : (.+)\|$")
      if keep then
        note ("discovered prompt settings ..")
        wait.time(0.5)
        note ("backing up current prompt in 'alias #brutal' .. ")
        send ("alias #brutal set prompt " .. keep)
        wait.time(0.5)
        note "reconfiguring prompt for use for #brutal .."
        send ("set prompt " .. brutal_prompt )
        wait.time(0.5)
        so_whoami()
        wait.time(0.5)
        setup_brutal_environment (true,true)
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
