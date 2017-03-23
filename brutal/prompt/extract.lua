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
