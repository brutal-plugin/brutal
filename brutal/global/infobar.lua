function build_infobar()
  --load global table into local variables
  local hp = string.format("%3s",ingame_prompt["hp"])
  local sp = string.format("%3s",ingame_prompt["sp"])
  local ep = string.format("%3s",ingame_prompt["ep"])

  --format health bars
  local info_hp = (hp .. "% " )
  local info_sp = (sp .. "% " )
  local info_ep = (ep .. "% " )

  --calculate number of # required
  local bar_hp = tonumber(string.format("%i",tonumber(hp)/10))
  local bar_sp = tonumber(string.format("%i",tonumber(sp)/10))
  local bar_ep = tonumber(string.format("%i",tonumber(ep)/10))

  --clear infobar and set background and fonts
  InfoClear()
  InfoBackground(background)
  InfoFont(infobar_font,infobar_font_size,0)

  --set title in infobar
  infobar_display_title()

  --display hp/sp/ep
  infobar_display_hp(info_hp,bar_hp)
  infobar_display_sp(info_sp,bar_sp)
  infobar_display_ep(info_ep,bar_ep)

  --grab exp, cash, df values
  local xp = kilomili(ingame_prompt["xp"])
  local protolvl = ingame_prompt["protolvl"] .. "%"
  local cash = kilomili(ingame_prompt["cash"])
  local df = kilomili(ingame_prompt["df"])

  --display exp, cash, df
  Info("\t")
  infobar_display_xp(xp,protolvl)
  infobar_display_cash(cash)
  infobar_display_df(df)

end --function

function infobar_display_title()
  InfoColour(cyan)
  Info("#")
  InfoColour(foreground)
  Info("brutal")
end --function

function infobar_display_hp(info_hp,bar_hp)
  Info (" hp:")
  InfoColour(ingame_prompt["hp_lite"])
  Info(info_hp)
  InfoColour(foreground)
  InfoFont(infobar_font,6,1)
  Info ("[")
  InfoColour(ingame_prompt["hp_lite"])
  local i = 0
  for i=1,10,1 do
    if bar_hp > 10 then
      bar_hp = 10
    elseif bar_hp < 0 then
      bar_hp = 0
    end --if
    if i <= bar_hp then
      Info ("#")
    else
      Info (" ")
    end --if
  end -- for
  InfoColour(foreground)
  Info ("]")
  InfoFont(infobar_font,infobar_font_size,0)
end --function

function infobar_display_sp(info_sp,bar_sp)
  Info (" sp:")
  InfoColour(ingame_prompt["sp_lite"])
  Info(info_sp)
  InfoColour(foreground)
  InfoFont(infobar_font,6,1)
  Info ("[")
  InfoColour(ingame_prompt["sp_lite"])
  local i = 0
  for i=1,10,1 do
    if bar_sp > 10 then
      bar_sp = 10
    elseif bar_sp < 0 then
      bar_sp = 0
    end --if
    if i <= bar_sp then
      Info ("#")
    else
      Info (" ")
    end --if
  end -- for
  InfoColour(foreground)
  Info ("]")
  InfoFont(infobar_font,infobar_font_size,0)
end --function

function infobar_display_ep(info_ep,bar_ep)
  Info (" ep:")
  InfoColour(ingame_prompt["ep_lite"])
  Info(info_ep)
  InfoColour(foreground)
  InfoFont(infobar_font,6,1)
  Info ("[")
  InfoColour(ingame_prompt["ep_lite"])
  local i = 0
  for i=1,10,1 do
    if bar_ep > 10 then
      bar_ep = 10
    elseif bar_ep < 0 then
      bar_ep = 0
    end --if
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

function  infobar_display_xp(xp,protolvl)
  Info (" xp ")
  InfoColour(cyan)
  Info (xp .. " \(" .. protolvl .. "\)")
  InfoColour(foreground)
end --function
function  infobar_display_cash(cash)
  Info (" \$\$ ")
  InfoColour(cyan)
  Info (cash)
  InfoColour(foreground)
end --function
function  infobar_display_df(df)
  Info (" df ")
  InfoColour(cyan)
  Info (df)
  InfoColour(foreground)
end --function
