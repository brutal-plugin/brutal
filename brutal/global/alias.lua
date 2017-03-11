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
      EnableTrigger ("prompt_trigger",false)
      note ("#brutal deactivated .. restoring prompt")
      send ("#brutal")
    else
      note ("checking for #brutal alias .." )
      send ("alias #brutal")
      local alias_check = wait.regexp("^\#brutal.+$",1)
      if alias_check then
          EnableTrigger ("prompt_trigger",true)
          if gag_ingame_prompt == true then
            SetTriggerOption("prompt","omit_from_output",1)
          else
            SetTriggerOption("prompt","omit_from_output",0)
          end --if
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

function extract_prompt()
  wait.make (function ()
    note ("setting terminal to " .. terminal)
    send ("term " .. terminal)
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
        note ("#brutal config done, type '#brutal' to activate/deactivate")
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
end --function
