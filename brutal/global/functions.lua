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
  EnableTrigger ("prompt_trigger",false)
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
