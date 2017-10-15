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

--mushclient function alias
note = Note
send = SendNoEcho

--load plugin script files
require "xml-import.aliases"
require "xml-import.triggers"
require "xml-import.channels"
require "config.variables"
require "config.user"
require "config.help"
require "config.misc"
require "config.alias"
require "prompt.extract"
require "prompt.capture"
require "prompt.update"
require "miniwin.decorations"
require "miniwin.infobar"
require "miniwin.status"
require "miniwin.comms"
