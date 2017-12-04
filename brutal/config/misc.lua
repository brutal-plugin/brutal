function kilomili(number)
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
end --function kilomili

function OnPluginInstall()
  InfoClear()
  InfoBackground(background)
  InfoColour(foreground)
  ShowInfoBar (use_classic_infobar)
  brutal_logo()
  brutal_arguments()
  EnableTriggerGroup ("brutal_prompt_group",false)
  EnableTriggerGroup ("reset_status",false)
  EnableTriggerGroup ("brutal_comms_group",false)
  setup_gags()
  AddPartyTriggers()
  if GetOption("enable_speed_walk") == 1 then
    note ("#brutal alias may conflict with speedwalk prefix '#', temporary disable speedwalks to configure #brutal ..")
  end --if
  local mush_fonts = utils.getfontfamilies ()
  if not mush_fonts.Inconsolata then
    AddFont(brutal_path .. "theme\\Inconsolata-Regular.ttf")
    AddFont(brutal_path .. "theme\\Inconsolata-Bold.ttf")
  end --if
  if brutal_theme_enabled == true then
    set_brutal_theme()
  end --if
end --function OnPluginInstall

function setup_gags()
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
end --function setup_gags

  function OnPluginSaveState ()
  --save window current location for next time
  --movewindow.save_state (stats_win)
  --movewindow.save_state (comms_win)
end -- function OnPluginSaveState

function brutal_logo()
note ("")
note("   _  _   _                _        _ ")
note(" _| || |_| |              | |      | |")
note("|_  __  _| |__  _ __ _   _| |_ __ _| |")
note(" _| || |_| '_ \\| '__| | | | __/ _` | |")
note("|_  __  _| |_) | |  | |_| | || (_| | |")
note("  |_||_| |_.__/|_|   \\__,_|\\__\\__,_|_|")
note ("")
end -- function brutal_logo

function brutal_arguments ()
  note ("")
  note ("usage: #brutal (config | help)")
  note ("")
  note ("#brutal : activate/deactivate #brutal")
  note ("#brutal config : extract and backup current prompt, set new prompt for #brutal use")
  note ("#brutal help : will display this message")
  note ("")
end --function brutal_arguments
