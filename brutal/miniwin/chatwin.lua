function init_chat_win()
  --shamelessly modified from nick gammon

  WINDOW_WIDTH = 300
  WINDOW_HEIGHT = 210
  BORDER_COLOUR = BRIGHTBLACK

  local x, y, mode, flags =
     tonumber (GetVariable ("windowx")) or 0,
     tonumber (GetVariable ("windowy")) or 0,
     tonumber (GetVariable ("windowmode")) or 8, -- bottom right
     tonumber (GetVariable ("windowflags")) or 4

  -- make miniwindow so I can grab the font info
  check (WindowCreate (chat_win,
                x, y, WINDOW_WIDTH, WINDOW_HEIGHT,
                mode,
                flags,
                BACKGROUND) )

end --function

  function brutal_write (name,line,wildcards,styles)
--[[
      local filename
  		local chat_win
  		 for k, v in pairs (GetWorldIdList ()) do
  			for i,j in pairs (GetWorldIdList(v)) do
  				if string.match (j, "0488219bfdba7dbbb35669c2") then
  					chat_win =  GetWorldById(j)
  				end
  			end
  		end
  		if not chat_win then
  			filename = (GetInfo(67).."ice-chat-logs.mcl")
  			assert (Open (filename))
  			chat_win = GetWorldById("0488219bfdba7dbbb35669c2")
  		end --if
  		for _, v in ipairs (styles) do
  			chat_win:ColourTell (RGBColourToName (v.textcolour), RGBColourToName (v.backcolour), v.text)
  		end -- for each style run
  		chat_win:Note ("")  -- wrap up line
  		local logdate = os.date ("%d/%m/%Y %H:%M")
  		filename = (GetInfo(67).."ice-chat-logs.txt")
  		local f = assert (io.open (filename,"a+"))
  		f:write (logdate," ",line,"\n")
  		f:close ()
]]--
  end --function

    function brutal_tell(name,line,wildcards,styles)
      brutal_write (name,line,wildcards,styles)
    end --function

    function brutal_channel_msg (name,line,wildcards,styles)
    --trigger ^(\[|\{|\<)(?<channel>\S+)(\]|}|\>):(?<emote>.+$)
    --trigger = ^(?<player>\S+) (\{|\[|\<)(?<channel>\S+)(\}|]|\>): (?<text>.+)
    	if (not string.match (wildcards[1],":") and string.match (name,"msg")) or
    	   (not string.match (wildcards[2],":") and string.match (name,"emote")) then
    	   if string.match (line,"alert") or string.match (line,"music") then
    			return
    		end
    	   brutal_write(name,line,wildcards,styles)
    	end --if
    end --function
