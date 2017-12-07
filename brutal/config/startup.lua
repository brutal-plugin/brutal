function brutal_alias(name,line)
  wait.make (function()
      if line == "#brutal help" then
        brutal_arguments()
        return
      end --if
      if line == "#brutal config" then
        config_brutal_alias(true)
        return
      end --if
      if line == "#brutal" then
        activate_brutal()
        return
      end --if
  end) --wait
end --function

function config_brutal_alias(do_check)
  wait.make (function()
    if do_check == true then
      note ("checking for #brutal alias .." )
      send ("alias #brutal")
      local check = wait.regexp("^The alias \\\#brutal wasn't found\\\.$",1)
      if check then
        extract_prompt()
      else
        note ("ingame #brutal alias exists ..")
        note ("type '#brutal' to activate/deactivate")
        note ("or unalias #brutal to reconfigure")
      end --if
    end --if
  end) --wait
end --function

function activate_brutal ()
  wait.make (function()
    --check if trigger name 'prompt_trigger' is enabled
    if GetTriggerInfo("prompt_trigger",8) == true then
      showHUD(false)
      note ("#brutal deactivated .. restoring prompt")
      send ("#brutal")
      InfoClear()
    else
      note ("checking #brutal alias has been created .." )
      send ("alias #brutal")
      local alias_check = wait.regexp("^(The alias \\\#brutal(.+)|\\\#brutal\\\s+set prompt(.+))$",1)
      if alias_check then
          if string.match (alias_check,"The alias") then
            note ("#brutal not configured, try '#brutal config' ..")
            showHUD(false)
            return
          else
            note ("#brutal alias detected ..")
            setup_brutal_environment (true,false)
            so_whoami()
            eval_terminal()
            note ("checking if we are in a party ..")
            CheckPartyStatus()
            GrabMyPrompt()
            --enable triggers
            showHUD(true)
            send ("")
            note ("#brutal activated .. ")
          end --if
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

function GrabMyPrompt()
  note ("grabbing prompt .. ")
  send ("")
  local prompt_check =  wait.regexp("^\\\#brutal(.+)$",1)
  if not prompt_check then
    send ("set prompt " .. brutal_prompt )
  end --if
end --function

function setup_brutal_environment(args)
  --setup theme if enabled
  if brutal_theme_enabled == true then
    set_brutal_theme()
  end --if
  createHUD(args)
end

function extract_prompt()
  wait.make (function ()
    eval_terminal()
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
        note ("#brutal configuration completed ..")
        note("type '#brutal' to activate/deactivate ..")
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
