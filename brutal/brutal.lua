--[[

GLOBAL CONFIGURATIONS
---------------------

]]--

--load mushclient functions
require "wait"
require "tprint"
require "commas"
require "movewindow"
require "serialize"
require "copytable"

--mushclient function alias
note = Note
send = SendNoEcho

--load plugin script files
require "xml-import.aliases"
require "xml-import.triggers"
require "xml-import.channels"
require "config.colours"            --import colours.lua file, #brutal name variables
require "config.static"             --import static.lua file, #brutal global variables
require "config.user"
require "config.misc"
require "config.startup"
require "prompt.capture"
require "prompt.update"
require "miniwin.decorations"
require "miniwin.infobar"
require "miniwin.status"
require "miniwin.comms"
require "miniwin.party"
require "miniwin.buffs"
