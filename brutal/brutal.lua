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
require "config.user"
require "config.help"
require "config.misc"
require "config.alias"
require "prompt.extract"
require "prompt.capture"
require "prompt.update"
require "miniwin.infobar"
require "miniwin.status"
