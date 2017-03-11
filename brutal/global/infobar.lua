function build_infobar()
  --tprint (ingame_prompt)
  --load global table into local variables
  local truehp = ingame_prompt["truehp"]
  local truesp = ingame_prompt["truesp"]
  local trueep = ingame_prompt["trueep"]
  local maxhp = ingame_prompt["maxhp"]
  local maxsp = ingame_prompt["maxsp"]
  local maxep = ingame_prompt["maxep"]
  local hp = string.format("%3s",ingame_prompt["hp"])
  local sp = string.format("%3s",ingame_prompt["sp"])
  local ep = string.format("%3s",ingame_prompt["ep"])

  --format health bars
  local info_hp = (hp .. "% " )
  local info_sp = (sp .. "% " )
  local info_ep = (ep .. "% " )

  bar_hp = tonumber(string.format("%i",tonumber(hp)/10))
  bar_sp = tonumber(string.format("%i",tonumber(sp)/10))
  bar_ep = tonumber(string.format("%i",tonumber(ep)/10))


  --clear infobar and set background and fonts
  InfoClear()
  InfoBackground(background)
  InfoFont(infobar_font,infobar_font_size,0)

  --set title in infobar
  InfoColour(cyan)
  Info("#")
  InfoColour(foreground)
  Info("brutal")

  --display hp
  Info (" hp:")
  InfoColour(ingame_prompt["hp_lite"])
  Info(info_hp)
  InfoColour(foreground)
  InfoFont(infobar_font,6,1)
  Info ("[")
  InfoColour(ingame_prompt["hp_lite"])
  local i = 0
  for i=1,10,1 do
    if i <= bar_hp then
      Info ("#")
    else
      Info (" ")
    end --if
  end -- for
  InfoColour(foreground)
  Info ("]")
  InfoFont(infobar_font,infobar_font_size,0)

  --display sp
  Info (" sp:")
  InfoColour(ingame_prompt["sp_lite"])
  Info(info_sp)
  InfoColour(foreground)
  InfoFont(infobar_font,6,1)
  Info ("[")
  InfoColour(ingame_prompt["sp_lite"])
  local i = 0
  for i=1,10,1 do
    if i <= bar_sp then
      Info ("#")
    else
      Info (" ")
    end --if
  end -- for
  InfoColour(foreground)
  Info ("]")
  InfoFont(infobar_font,infobar_font_size,0)

  --display ep
  Info (" ep:")
  InfoColour(ingame_prompt["ep_lite"])
  Info(info_ep)
  InfoColour(foreground)
  InfoFont(infobar_font,6,1)
  Info ("[")
  InfoColour(ingame_prompt["ep_lite"])
  local i = 0
  for i=1,10,1 do
    if i <= bar_ep then
      Info ("#")
    else
      Info (" ")
    end --if
  end -- for
  InfoColour(foreground)
  Info ("]")
  InfoFont(infobar_font,infobar_font_size,0)

end --function
