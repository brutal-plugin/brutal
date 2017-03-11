function capture_prompt(name,line,wildcards,styles)
  --update global variable with new prompt
  for k, v in pairs (wildcards) do
    if not tonumber(k) then
      ingame_prompt[k] = v
     end --if
  end --for
  prompt_line = line
  prompt_styles = styles
  --extract lite colours for hp/sp/ep and add them to ingame prompt
  ingame_prompt["hp_lite"] = make_lite_colours(ingame_prompt["hp"])
  ingame_prompt["sp_lite"] = make_lite_colours(ingame_prompt["sp"])
  ingame_prompt["ep_lite"] = make_lite_colours(ingame_prompt["ep"])
  --format bar_lite colours
  ingame_prompt["bar_hp_lite"] =  make_bar_colours(ingame_prompt["hp"])
  ingame_prompt["bar_sp_lite"] =  make_bar_colours(ingame_prompt["sp"])
  ingame_prompt["bar_ep_lite"] =  make_bar_colours(ingame_prompt["ep"])
  --set source and time for update
  if name == "prompt_trigger" then
    ingame_prompt["source"] = "live"
    ingame_prompt["updated"] = os.time()
  end --if
  -- build infobar
  build_infobar()
end --function

function healthbar_update(name,line,wildcards)
  for k, v in pairs (wildcards) do
    if not tonumber(k) then
      ingame_prompt[k] = v
     end --if
     ingame_prompt["source"] = "update"
  end --for
  capture_prompt(name,prompt_line,ingame_prompt,prompt_styles)
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

function clear_prompt_status()
  ingame_prompt["st"] = " "
  capture_prompt("update",prompt_line,ingame_prompt,prompt_styles)
end --function

function fully_healed()
  ingame_prompt["hp"] = 100
  capture_prompt("update",prompt_line,ingame_prompt,prompt_styles)
end --function

function  fully_magical()
  ingame_prompt["hp"] = 100
  capture_prompt("update",prompt_line,ingame_prompt,prompt_styles)
end --function

function fully_rested()
  ingame_prompt["hp"] = 100
  capture_prompt("update",prompt_line,ingame_prompt,prompt_styles)
end --function
