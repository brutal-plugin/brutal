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
    if GetTriggerInfo("prompt_trigger",8) == true then
      EnableTriggerGroup ("brutal_plugin_triggers",false)
      --WindowShow (status_win, false)
      note ("#brutal deactivated .. restoring prompt")
      send ("#brutal")
      InfoClear()
    else
      so_whoami()
      note ("checking for #brutal alias .." )
      send ("alias #brutal")
      local alias_check = wait.regexp("^\#brutal.+$",1)
      if alias_check then
          EnableTriggerGroup ("brutal_plugin_triggers",true)
          --WindowShow (status_win, true)
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
    end --if
  end --if
end --function
