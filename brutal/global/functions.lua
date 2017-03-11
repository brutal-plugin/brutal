--mushclient function alias
note = Note
send = SendNoEcho



function OnPluginInstall()
  ShowInfoBar (true)
  InfoClear()
  InfoBackground(background)
  InfoColour(foreground)
  brutal_logo()
  brutal_arguments()
  EnableTriggerGroup ("brutal_plugin_triggers",false)
  
  if gag_ingame_prompt == true then
    SetTriggerOption("prompt_trigger","omit_from_output",1)
  else
    SetTriggerOption("prompt_trigger","omit_from_output",0)
  end --if

  if gag_color_bar == true then
    SetTriggerOption("healthbar_trigger","omit_from_output",1)
  else
    SetTriggerOption("healthbar_trigger","omit_from_output",0)
  end --if

  if GetOption("enable_speed_walk") == 1 then
    note ("#brutal alias may conflict with speedwalk prefix '#', temporary disable speedwalks to configure #brutal ..")
  end --if
end --function

function kilomili(number)
  local number = tonumber(number)
  if string.len(number) < 5 then
    number = commas(number)
  elseif string.len(number) > 4 and string.len(number) < 7 then
    number = string.format("%.2f",(number / 10^3)) .. "k"
  elseif string.len(number) > 6 and string.len(number) < 10 then
    number = string.format("%.2f",(number / 10^6)) .. "m"
  elseif string.len(number) >  9 then
    number = string.format("%.2f",(number / 10^9)) .. "b"
  end --if
  return (number)
end --function
