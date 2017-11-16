function build_infobar()
  --check if we are using classic or new version of infobar
  if use_classic_infobar == false then
    ShowInfoBar (false)
  end --if
  --load global table into local variables
  local hp = string.format("%3s",ingame_prompt["hp"])
  local sp = string.format("%3s",ingame_prompt["sp"])
  local ep = string.format("%3s",ingame_prompt["ep"])
  local truehp = ingame_prompt["truehp"]
  local truesp = ingame_prompt["truesp"]
  local trueep = ingame_prompt["trueep"]
  local maxhp = ingame_prompt["maxhp"]
  local maxsp = ingame_prompt["maxsp"]
  local maxep = ingame_prompt["maxep"]

  --format health bars
  local info_hp = (truehp .. "\/".. maxhp)
  local info_sp = (truesp .. "\/".. maxsp)
  local info_ep = (trueep .. "\/".. maxep)

  --format percentages
  local per_hp =  (hp .. "%")
  local per_sp =  (sp .. "%")
  local per_ep =  (ep .. "%")

  --calculate number of # required
  local bar_hp = tonumber(string.format("%i",tonumber(hp)/10))
  local bar_sp = tonumber(string.format("%i",tonumber(sp)/10))
  local bar_ep = tonumber(string.format("%i",tonumber(ep)/10))

  --grab exp, cash, df values
  local xp = kilomili(ingame_prompt["xp"])
  local protolvl = ingame_prompt["protolvl"] .. "%"
  local cash = kilomili(ingame_prompt["cash"])
  local df = kilomili(ingame_prompt["df"])

  --grab daytime, hour, phase, status values
  local dt = ingame_prompt["dt"]
  local hr = string.lower(ingame_prompt["hr"])
  local ph = ingame_prompt["phase"]
  local st = ingame_prompt["st"]

  --check if we are going to be using a modern or classic look
  if use_classic_infobar == true then
    ShowInfoBar (true)
    WindowShow (minfo_win, false)
    draw_classic_infobar(info_hp,bar_hp,per_hp,info_sp,bar_sp,per_sp,info_ep,bar_ep,per_ep,xp,protolvl,cash,df,dt,hr,ph,st)
  else
    ShowInfoBar (false)
    draw_modern_infobar(info_hp,bar_hp,per_hp,info_sp,bar_sp,per_sp,info_ep,bar_ep,per_ep,xp,protolvl,cash,df,dt,hr,st,ph)
  end --if
end --function build_infobar

function draw_modern_infobar(info_hp,bar_hp,per_hp,info_sp,bar_sp,per_sp,info_ep,bar_ep,per_ep,xp,protolvl,cash,df,dt,hr,st,ph)
  --blank out old window
  check (WindowRectOp (minfo_win, 2, 0, 0, 0, 0, theme.WINDOW_BACKGROUND))
  check (WindowRectOp (minfo_win, 1, 0, 0, 0, 0, theme.WINDOW_BORDER))

  --update track objects to determine if strike-thru fonts will be used
  if track_update["source"] == "update" and os.difftime(os.time(), track_update["time"]) > 10 and track_update["hp"] == true then
    track_update["hpFont"] = font_strike
  end --if

  if track_update["source"] == "update" and os.difftime(os.time(), track_update["time"]) > 10 and track_update["sp"] == true then
    track_update["spFont"] = font_strike
  end --if

  if track_update["source"] == "update" and os.difftime(os.time(), track_update["time"]) > 10 and track_update["ep"] == true then
    track_update["epFont"] = font_strike
  end --if

  --draw the #brutal logo
  local myText = "#"
  local myPosY = 2 * TEXT_INSET
  WindowText(minfo_win,body_font,myText,TEXT_INSET, myPosY, 0, 0,BRIGHTCYAN)
  local myPosX = TEXT_INSET + WindowTextWidth (minfo_win,body_font,myText)

  myText = "brutal hp "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  --add the hp info
  myText = info_hp
  WindowText(minfo_win,track_update["hpFont"],myText,myPosX, myPosY, 0, 0,ColourNameToRGB(ingame_prompt["hp_lite"]))
  myPosX =  myPosX + WindowTextWidth (minfo_win,track_update["hpFont"],myText)

  myText = " ["
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = ""
  local i = 0
  for i=1,10,1 do
    if bar_hp > 10 then
      bar_hp = 10
    elseif bar_hp < 0 then
      bar_hp = 0
    end --if
    if i <= bar_hp then
      myText = myText .. "#"
    else
      myText = myText .. " "
    end --if
  end -- for
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,ColourNameToRGB(ingame_prompt["bar_hp_lite"]))
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = "] "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = per_hp
  WindowText(minfo_win,track_update["hpFont"],myText,myPosX, myPosY, 0, 0,ColourNameToRGB(ingame_prompt["hp_lite"]))
  myPosX =  myPosX + WindowTextWidth (minfo_win,track_update["hpFont"],myText)

  --add the sp info
  myText = " sp "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = info_sp
  WindowText(minfo_win,track_update["spFont"],myText,myPosX, myPosY, 0, 0,ColourNameToRGB(ingame_prompt["sp_lite"]))
  myPosX =  myPosX + WindowTextWidth (minfo_win,track_update["spFont"],myText)

  myText = " ["
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = ""
  local i = 0
  for i=1,10,1 do
    if bar_sp > 10 then
      bar_sp = 10
    elseif bar_sp < 0 then
      bar_sp = 0
    end --if
    if i <= bar_sp then
      myText = myText .. "#"
    else
      myText = myText .. " "
    end --if
  end -- for
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,ColourNameToRGB(ingame_prompt["bar_sp_lite"]))
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = "] "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = per_sp
  WindowText(minfo_win,track_update["spFont"],myText,myPosX, myPosY, 0, 0,ColourNameToRGB(ingame_prompt["sp_lite"]))
  myPosX =  myPosX + WindowTextWidth (minfo_win,track_update["spFont"],myText)

  --add the ep info
  myText = " ep "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = info_ep
  WindowText(minfo_win,track_update["epFont"],myText,myPosX, myPosY, 0, 0,ColourNameToRGB(ingame_prompt["ep_lite"]))
  myPosX =  myPosX + WindowTextWidth (minfo_win,track_update["epFont"],myText)

  myText = " ["
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = ""
  local i = 0
  for i=1,10,1 do
    if bar_ep > 10 then
      bar_ep = 10
    elseif bar_ep < 0 then
      bar_ep = 0
    end --if
    if i <= bar_ep then
      myText = myText .. "#"
    else
      myText = myText .. " "
    end --if
  end -- for
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,ColourNameToRGB(ingame_prompt["bar_ep_lite"]))
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = "] "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = per_ep
  WindowText(minfo_win,track_update["epFont"],myText,myPosX, myPosY, 0, 0,ColourNameToRGB(ingame_prompt["ep_lite"]))
  myPosX =  myPosX + WindowTextWidth (minfo_win,track_update["epFont"],myText)

  --add the xp info
  myText = " xp "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = xp .. " \(" .. protolvl .. "\)"
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,BACKGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  --add the cash info
  myText = " $$ "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = cash
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,BACKGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  --add the df info
  myText = " df "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = df
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,BACKGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  --add the dt info
  myText = " dt "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = dt .. ", " .. hr
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,BACKGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  --add the ph info
  myText = " ph "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = ph
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,BACKGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  --add the st info
  myText = " status "
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,FOREGROUND)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)

  myText = st
  WindowText(minfo_win,body_font,myText,myPosX, myPosY, 0, 0,BRIGHTRED)
  myPosX =  myPosX + WindowTextWidth (minfo_win,body_font,myText)
end --function draw_modern_infobar

function draw_classic_infobar(info_hp,bar_hp,per_hp,info_sp,bar_sp,per_sp,info_ep,bar_ep,per_ep,xp,protolvl,cash,df,dt,hr,ph,st)
  --clear infobar and set background and fonts
  InfoClear()
  InfoBackground(background)
  InfoFont(theme.BODY_FONT_NAME,theme.BODY_FONT_SIZE,0)

  --set title in infobar
  infobar_display_title()

  --display hp/sp/ep
  infobar_display_hp(info_hp,bar_hp,per_hp)
  infobar_display_sp(info_sp,bar_sp,per_sp)
  infobar_display_ep(info_ep,bar_ep,per_ep)

  --display exp, cash, df
  infobar_display_xp(xp,protolvl)
  infobar_display_cash(cash)
  infobar_display_df(df)

  --display daytime, hour, status
  infobar_display_dt(dt, hr)
  infobar_display_st(st)
end --function draw_infobar

function infobar_display_title()
  InfoColour(cyan)
  Info("#")
  InfoColour(foreground)
  Info("brutal")
end --function infobar_display_title

function infobar_display_hp(info_hp,bar_hp,per_hp)
  Info (" hp ")
  if track_update["source"] == "update" and os.difftime(os.time(), track_update["time"]) > 10 and track_update["hp"] == true then
    InfoFont(theme.BODY_FONT_NAME,theme.BODY_FONT_SIZE,8)
    track_update["hpFont"] = font_strike
  end --if
  InfoColour(ingame_prompt["hp_lite"])
  Info(info_hp)
  InfoColour(foreground)
  InfoFont(theme.BODY_FONT_NAME,theme.BODY_FONT_SIZE,0)
  Info (" [")
  InfoColour(ingame_prompt["bar_hp_lite"])
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
  Info ("] ")
  InfoColour(ingame_prompt["hp_lite"])
  Info (per_hp)
  InfoColour(foreground)
  InfoFont(theme.BODY_FONT_NAME,theme.BODY_FONT_SIZE,0)
end --function infobar_display_hp

function infobar_display_sp(info_sp,bar_sp,per_sp)
  Info (" sp ")
  if track_update["source"] == "update" and os.difftime(os.time(), track_update["time"]) > 10 and track_update["sp"] == true then
    InfoFont(theme.BODY_FONT_NAME,theme.BODY_FONT_SIZE,8)
    track_update["spFont"] = font_strike
  end --if
  InfoColour(ingame_prompt["sp_lite"])
  Info(info_sp)
  InfoColour(foreground)
  InfoFont(theme.BODY_FONT_NAME,theme.BODY_FONT_SIZE,0)
  Info (" [")
  InfoColour(ingame_prompt["bar_sp_lite"])
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
  Info ("] ")
  InfoColour(ingame_prompt["sp_lite"])
  Info (per_sp)
  InfoColour(foreground)
  InfoFont(theme.BODY_FONT_NAME,theme.BODY_FONT_SIZE,0)
end --function infobar_display_sp

function infobar_display_ep(info_ep,bar_ep,per_ep)
  Info (" ep ")
  if track_update["source"] == "update" and os.difftime(os.time(), track_update["time"]) > 10 and track_update["ep"] == true then
    InfoFont(theme.BODY_FONT_NAME,theme.BODY_FONT_SIZE,8)
    track_update["epFont"] = font_strike
  end --if
  InfoColour(ingame_prompt["ep_lite"])
  Info(info_ep)
  InfoColour(foreground)
  InfoFont(theme.BODY_FONT_NAME,theme.BODY_FONT_SIZE,0)
  Info (" [")
  InfoColour(ingame_prompt["bar_ep_lite"])
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
  Info ("] ")
  InfoColour(ingame_prompt["ep_lite"])
  Info (per_ep)
  InfoColour(foreground)
  InfoFont(theme.BODY_FONT_NAME,theme.BODY_FONT_SIZE,0)
end --function infobar_display_ep

function  infobar_display_xp(xp,protolvl)
  Info (" xp ")
  InfoColour(brightblack)
  Info (xp .. " \(" .. protolvl .. "\)")
  InfoColour(foreground)
end --function infobar_display_xp

function  infobar_display_cash(cash)
  Info (" \$\$ ")
  InfoColour(brightblack)
  Info (cash)
  InfoColour(foreground)
end --function infobar_display_cash

function  infobar_display_df(df)
  Info (" df ")
  InfoColour(brightblack)
  Info (df)
  InfoColour(foreground)
end --function infobar_display_df

function infobar_display_dt(dt, hr)
  Info (" daytime ")
  InfoColour(brightblack)
  Info (dt .. ", " .. hr)
  InfoColour(foreground)
end --function infobar_display_dt

function infobar_display_st(st)
  Info (" status ")
  InfoColour(brightred)
  Info (st)
  InfoColour(foreground)
end --function infobar_display_st
