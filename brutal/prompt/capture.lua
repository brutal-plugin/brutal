function capture_prompt(name,line,wildcards,styles)
  --update global variable with new prompt
  for k, v in pairs (wildcards) do
    if not tonumber(k) then
      ingame_prompt[k] = v
     end --if
  end --for
  --extract lite colours for hp/sp/ep and add them to ingame prompt
  ingame_prompt["hp_lite"] = make_lite_colours(ingame_prompt["hp"])
  ingame_prompt["sp_lite"] = make_lite_colours(ingame_prompt["sp"])
  ingame_prompt["ep_lite"] = make_lite_colours(ingame_prompt["ep"])
  --format bar_lite colours
  ingame_prompt["bar_hp_lite"] =  make_bar_colours(ingame_prompt["hp"])
  ingame_prompt["bar_sp_lite"] =  make_bar_colours(ingame_prompt["sp"])
  ingame_prompt["bar_ep_lite"] =  make_bar_colours(ingame_prompt["ep"])
  --update table used for tracking changes
  track_update["source"] = "capture"
  track_update["time"] = os.time()
  track_update["hp"] = false
  track_update["sp"] = false
  track_update["ep"] = false
  --build the infobar
  build_infobar()
  build_stat_window()
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

function  make_lite_colours(mypercent)
  local mypercent = tonumber(mypercent)
  if mypercent >= 100  then
    return (brightblack)
  elseif mypercent < 100 and mypercent >= 75 then
    return (brightgreen)
  elseif mypercent < 75 and mypercent >= 50 then
    return (green)
  elseif mypercent < 50 and mypercent >= 25 then
    return (brightyellow)
  elseif mypercent < 25 and mypercent >= 10 then
    return (brightred)
  elseif mypercent < 10 and mypercent >= 0 then
    return (red)
  end --if
end --function
