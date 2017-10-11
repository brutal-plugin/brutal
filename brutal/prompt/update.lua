function healthbar_update(name,line,wildcards)
  for k, v in pairs (wildcards) do
    if not tonumber(k) then
      if ingame_prompt[k] ~= v then
        ingame_prompt[k] = v
        track_update["source"] = "update"
        track_update[k] = true
      end --if
     end --if
  end --for
  build_infobar()
  build_stats_win()
end --function

function clear_prompt_status()
  ingame_prompt["st"] = " "
  track_update["source"] = "status"
  build_infobar()
  build_stats_win()
end --function

function fully_healed()
  ingame_prompt["hp"] = 100
  ingame_prompt["hp_lite"] = brightblack
  ingame_prompt["bar_hp_lite"] = brightblack
  track_update["source"] = "update"
  track_update["hp"] = true
  build_infobar()
  build_stats_win()
end --function

function  fully_magical()
  ingame_prompt["sp"] = 100
  ingame_prompt["sp_lite"] = brightblack
  ingame_prompt["bar_sp_lite"] = brightblack
  track_update["source"] = "update"
  track_update["sp"] = true
  build_stats_win()
  build_infobar()
end --function

function fully_rested()
  ingame_prompt["ep"] = 100
  ingame_prompt["ep_lite"] = brightblack
  ingame_prompt["bar_ep_lite"] = brightblack
  track_update["source"] = "update"
  track_update["ep"] = true
  build_infobar()
  build_stats_win()
end --function
