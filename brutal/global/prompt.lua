function capture_prompt(name,line,wildcards,styles)
  --update global variable with new prompt
  ingame_prompt = wildcards
  --extract lite colours for hp/sp/ep and add them to ingame prompt
  local hp_pos = GetStyle (styles, (string.find(line," hp ") + 5))
  local sp_pos = GetStyle (styles, (string.find(line," sp ") + 5))
  local ep_pos = GetStyle (styles, (string.find(line," ep ") + 5))
  ingame_prompt["hp_lite"] = RGBColourToName (hp_pos["textcolour"])
  ingame_prompt["sp_lite"] = RGBColourToName (sp_pos["textcolour"])
  ingame_prompt["ep_lite"] = RGBColourToName (ep_pos["textcolour"])
  -- build infobar
  build_infobar()
end --function
