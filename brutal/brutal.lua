--[[

GLOBAL CONFIGURATIONS
---------------------

]]--

--load mushclient functions
require "wait"
require "tprint"
require "commas"

--mushclient function alias
note = Note
send = SendNoEcho

--load plugin script files
require "xml-import.aliases"
require "xml-import.triggers"
require "config.variables"
require "config.help"
require "global.alias"
require "prompt.extract"
require "prompt.capture"
require "prompt.update"
require "config.infobar"
require "config.misc"


--[[

USER CONFIGURATION OPTIONS
----------------------------

]]--

--load brutal colour theme (uncomment the line below)
--require "xml-import.theme"

--infobar font and size
infobar_font = "consolas"
infobar_font_size = 8

--set ingame terminal
terminal = "180x100"


--gag ingame prompt
gag_ingame_prompt = true

--gag ingame hp/sp/ep health bars
gag_color_bar = true
