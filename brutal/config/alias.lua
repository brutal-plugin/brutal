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
      switch_triggers(false)
      note ("#brutal deactivated .. restoring prompt")
      send ("#brutal")
      InfoClear()
    else
      so_whoami()
      note ("checking for #brutal alias .." )
      send ("alias #brutal")
      local alias_check = wait.regexp("^\#brutal.+$",1)
      if alias_check then
          switch_triggers (true)
          note ("#brutal activated .. ")
          send ("")
          local prompt_check =  wait.regexp("^\#brutal.+$",1)
          if not prompt_check then
            note ("capturing prompt .. ")
            send ("set prompt " .. brutal_prompt )
          end --if
          return
      else
        note ("try '#brutal config'")
      end --if
    end --if
  end) --wait
end --if

function so_whoami()
  if not whoami then
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

function helo()
  print("hello")
end

function switch_triggers(args)

  LoadAllSprites()
  init_window_decorations()
  EnableTriggerGroup ("brutal_prompt_group",args)
  EnableTriggerGroup ("reset_status",args)
  WindowShow (decor_win, args)
  init_stats_win()
  WindowShow (stats_win, args)
  if comms_win_enabled == true then
    init_comms_win()
    EnableTriggerGroup ("brutal_comms_group",args)
    WindowShow (comms_win, args)
  end --if
end
