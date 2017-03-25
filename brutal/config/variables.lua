--set brutal prompt, (for my refrence and global variables/tables, dont change these)
brutal_prompt = "[cyan]#[reset]brutal [cyan]hp [reset][hplite][truehp]:[truemaxhp]:[hp] [cyan]sp [reset][splite][truesp]:[truemaxsp]:[sp] [cyan]ep [reset][eplite][trueep]:[truemaxep]:[ep] [cyan]xp [reset][exp]:[exptolvl]:[protolvl] [cyan]ad [reset][exptoadv]:[protoadv] [cyan]df [reset][df] [cyan]$$ [reset][cash] [cyan]ph [reset][phase] [cyan]dt [reset][daytime] [cyan]hr [reset][hour] [cyan]st[reset] [status] :[nl]"
brutal_regex = "#brutal hp (?<truehp>(-\d+)|\d+)\:(?<maxhp>\d+)\:(?<hp>\d+) sp (?<truesp>(-\d+)|\d+)\:(?<maxsp>\d+)\:(?<sp>\d+) ep (?<trueep>(-\d+)|\d+)\:(?<maxep>\d+)\:(?<ep>\d+) xp (?<xp>(-\d+)|\d+)\:(?<exptolvl>(-\d+|\d+))\:(?<protolvl>(-\d+|\d+))\% ad (?<exptoadv>(-\d+|\d+))\:(?<protoadv>(-\d+|\d+))\% df (?<df>\d+) \$\$ (?<cash>\d+) ph (?<phase>\S+) dt (?<dt>\S+) hr (?<hr>.+) st(?<st>.+)\:$"
ingame_prompt = {}
track_update = {}
stat_win = GetPluginID() .. ":stat_win"
font_normal = "font_normal"
font_strike = "font_strike"
font_under = "font_under"

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
foreground = brightwhite
background = black

BLACK = GetNormalColour(1)
RED = GetNormalColour(2)
GREEN = GetNormalColour(3)
YELLOW = GetNormalColour(4)
BLUE = GetNormalColour(5)
MAGENTA = GetNormalColour(6)
CYAN = GetNormalColour(7)
WHITE = GetNormalColour(8)
BRIGHTBLACK = GetBoldColour(1)
BRIGHTRED = GetBoldColour(2)
BRIGHTGREEN = GetBoldColour(3)
BRIGHTYELLOW = GetBoldColour(4)
BRIGHTBLUE = GetBoldColour(5)
BRIGHTMAGENTA = GetBoldColour(7)
BRIGHTCYAN = GetBoldColour(7)
BRIGHTWHITE = GetBoldColour(8)
FOREGROUND = BRIGHTWHITE
BACKGROUND = BLACK
