--set brutal prompt, (for my refrence and global variables/tables, dont change these)
brutal_prompt = "[cyan]#[reset]brutal [cyan]hp [reset][hplite][truehp]:[truemaxhp]:[hp] [cyan]sp [reset][splite][truesp]:[truemaxsp]:[sp] [cyan]ep [reset][eplite][trueep]:[truemaxep]:[ep] [cyan]xp [reset][exp]:[exptolvl]:[protolvl] [cyan]ad [reset][exptoadv]:[protoadv] [cyan]df [reset][df] [cyan]$$ [reset][cash] [cyan]ph [reset][phase] [cyan]dt [reset][daytime] [cyan]hr [reset][hour] [cyan]st[reset] [status] :[nl]"
brutal_regex = "#brutal hp (?<truehp>(-\d+)|\d+)\:(?<maxhp>\d+)\:(?<hp>\d+) sp (?<truesp>(-\d+)|\d+)\:(?<maxsp>\d+)\:(?<sp>\d+) ep (?<trueep>(-\d+)|\d+)\:(?<maxep>\d+)\:(?<ep>\d+) xp (?<xp>(-\d+)|\d+)\:(?<exptolvl>(-\d+|\d+))\:(?<protolvl>(-\d+|\d+))\% ad (?<exptoadv>(-\d+|\d+))\:(?<protoadv>(-\d+|\d+))\% df (?<df>\d+) \$\$ (?<cash>\d+) ph (?<phase>\S+) dt (?<dt>\S+) hr (?<hr>.+) st(?<st>.+)\:$"
ingame_prompt = {}
track_update = {}
decor_win = "decor_" .. GetPluginID()
stats_win = "stats_" .. GetPluginID()
comms_win = "comms_" .. GetPluginID()
party_win = "party_" .. GetPluginID()
font_normal = "font_normal"
font_strike = "font_strike"
font_under = "font_under"
windowWidth = 570
windowHeight = 300
TEXT_INSET = 5
sprites = {}
sprite_width = 32
sprite_height = 32
SCROLL_BAR_SIZE = 5
SCROLL_THUMB_HOTSPOT = "thumb"
SCROLL_WHEEL_HOTSPOT = "ScrollWheelHotspot"
brutal_comms = {}

--colours extracted from mushclient under game -> configure -> ansi colours
black = RGBColourToName(GetNormalColour(1))
red = RGBColourToName(GetNormalColour(2))
green = RGBColourToName(GetNormalColour(3))
yellow = RGBColourToName(GetNormalColour(4))
blue = RGBColourToName(GetNormalColour(5))
magenta = RGBColourToName(GetNormalColour(6))
cyan = RGBColourToName(GetNormalColour(7))
white = RGBColourToName(GetNormalColour(8))
brightblack = RGBColourToName(GetBoldColour(1))
brightred = RGBColourToName(GetBoldColour(2))
brightgreen = RGBColourToName(GetBoldColour(3))
brightyellow = RGBColourToName(GetBoldColour(4))
brightblue = RGBColourToName(GetBoldColour(5))
brightmagenta = RGBColourToName(GetBoldColour(7))
brightcyan = RGBColourToName(GetBoldColour(7))
brightwhite = RGBColourToName(GetBoldColour(8))
foreground = white
background = black

BLACK = ColourNameToRGB (black)
RED = ColourNameToRGB (red)
GREEN = ColourNameToRGB (green)
YELLOW = ColourNameToRGB (yellow)
BLUE = ColourNameToRGB (blue)
MAGENTA = ColourNameToRGB (magenta)
CYAN = ColourNameToRGB (cyan)
WHITE = ColourNameToRGB (white)
BRIGHTBLACK = ColourNameToRGB (brightblack)
BRIGHTRED = ColourNameToRGB (brightred)
BRIGHTGREEN = ColourNameToRGB (brightgreen)
BRIGHTYELLOW = ColourNameToRGB (brightyellow)
BRIGHTBLUE = ColourNameToRGB (brightblue)
BRIGHTMAGENTA = ColourNameToRGB (brightmagenta)
BRIGHTCYAN = ColourNameToRGB (brightcyan)
BRIGHTWHITE = ColourNameToRGB (brightwhite)
FOREGROUND = BRIGHTWHITE
BACKGROUND = BRIGHTBLACK

--[[
--modify mushclient default colours to below, check init_window_decorations() function
SetNormalColour (1,ColourNameToRGB("black"))
SetNormalColour (2,ColourNameToRGB("crimson"))
SetNormalColour (3,ColourNameToRGB("forestgreen"))
SetNormalColour (4,ColourNameToRGB("chocolate"))
SetNormalColour (5,ColourNameToRGB("dodgerblue"))
SetNormalColour (6,ColourNameToRGB("magenta"))
SetNormalColour (7,ColourNameToRGB("cadetblue"))
SetNormalColour (8,ColourNameToRGB("lightgrey"))
SetBoldColour (1,ColourNameToRGB("gray"))
SetBoldColour (2,ColourNameToRGB("red"))
SetBoldColour (3,ColourNameToRGB("chartreuse"))
SetBoldColour (4,ColourNameToRGB("yellow"))
SetBoldColour (5,ColourNameToRGB("mediumblue"))
SetBoldColour (6,ColourNameToRGB("mediumvioletred"))
SetBoldColour (7,ColourNameToRGB("teal"))
SetBoldColour (8,ColourNameToRGB("white"))
]]--
