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
        --activate/deactivate #brutal
        return
      end --if
  end) --wait
end --function

function config_brutal_alias()
  wait.make (function()
      note ("checking for #brutal alias .." )
      wait.time(0.5)
      send ("alias #brutal")
      local check = wait.regexp("^The alias #brutal wasn't found\.$",1)
        if check then
          note ("trying to determine prompt from 'set' ..")
          wait.time(0.5)
          extract_prompt()
        else
          note ("ingame #brutal alias already exists .. type ''#brutal' to activate/deactivate")
        end --if
  end) --wait
end --function

function extract_prompt()
  wait.make (function ()
    send ("set")
    local user_prompt = wait.match("| prompt               : Yes :*",2)
    if user_prompt then
      local dump, keep = string.match(user_prompt,"^\| prompt\(.+): Yes : (.+)\|$")
      if keep then
        note ("ingame prompt settings discovered ..")
        wait.time(0.5)
        note ("backing up current prompt in ingame alias .. ")
        send ("alias #brutal set prompt  " .. keep)
        wait.time(0.5)
        note "changing ingame prompt for use for #brutal .."
        send ("set prompt " .. brutal_prompt )
        wait.time(0.5)
        note ("type '#brutal' to activate/deactivate #brutal")
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
