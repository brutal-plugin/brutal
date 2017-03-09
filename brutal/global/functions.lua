--mushclient function alias
note = Note
send = SendNoEcho



function OnPluginInstall()
  ShowInfoBar (true)
  InfoClear()
  InfoBackground(background)
  InfoColour(foreground)
  InfoFont(infobar_font,infobar_font_size,0)
  brutal_logo()
  brutal_arguments()
  EnableTrigger ("prompt",false)
  if GetOption("enable_speed_walk") == 1 then
    note ("#brutal alias may conflict with speedwalk prefix '#', temporary disable speedwalks to configure #brutal ..")
  end --if
  wait.make (function ()
    Info ("#brutal has been installed successfully")
    wait.time (3)
    InfoClear()
  end) --wait
end --function
