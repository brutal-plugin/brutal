function capture_prompt(name,line,wildcards,styles)
  --update global variable with new prompt
  for k, v in pairs (wildcards) do
    if not tonumber(k) then
      ingame_prompt[k] = v
     end --if
  end --for
  --extract lite colours for hp/sp/ep and add them to ingame prompt
  local hp_pos = GetStyle (styles, (string.find(line," hp ") + 5))
  local sp_pos = GetStyle (styles, (string.find(line," sp ") + 5))
  local ep_pos = GetStyle (styles, (string.find(line," ep ") + 5))
  ingame_prompt["hp_lite"] = RGBColourToName (hp_pos["textcolour"])
  ingame_prompt["sp_lite"] = RGBColourToName (sp_pos["textcolour"])
  ingame_prompt["ep_lite"] = RGBColourToName (ep_pos["textcolour"])
  --format bar_lite colours
  ingame_prompt["bar_hp_lite"] =  make_bar_colours(ingame_prompt["hp"])
  ingame_prompt["bar_sp_lite"] =  make_bar_colours(ingame_prompt["sp"])
  ingame_prompt["bar_ep_lite"] =  make_bar_colours(ingame_prompt["ep"])
  --set source and time for update
  ingame_prompt["source"] = "live"
  ingame_prompt["updated"] = os.time()
  -- build infobar
  build_infobar()
end --function

function make_bar_colours (mypercent)
  local mypercent = tonumber(mypercent)
  if mypercent >= 100  then
    return (brightblack)
  elseif mypercent < 100 and mypercent >= 85 then
    return (brightblue)
  elseif mypercent < 85 and mypercent >= 60 then
    return (green)
  elseif mypercent < 60 and mypercent >= 25 then
    return (magenta)
  elseif mypercent < 25 and mypercent >= 0 then
    return (red)
  end --if
end --if
