--mushclient functions
require "wait"
require "tprint"
require "commas"

--mushclient function alias
note = Note
send = SendNoEcho

--plugin startup functions
require "global.init"
require "infobar.init"
require "chatwin.init"

function OnPluginInstall()
  ShowInfoBar (true)
  InfoClear()
  InfoBackground(background)
  InfoColour(foreground)
  brutal_logo()
  brutal_arguments ()
end --function
