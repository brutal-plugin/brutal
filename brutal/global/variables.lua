--set fonts
miniwindow_font = "consolas"
miniwindow_font_size = 9
infobar_font = "consolas"
infobar_font_size = 9

--set the terminal (ingame term (cols)x(rows))
terminal = "180x100"

--set brutal prompt
brutal_prompt = "[reset][cyan]#[reset]brutal [cyan]hp [reset][hplite][truehp]:[truemaxhp]:[hp][reset] [cyan]sp [reset][splite][truesp]:[truemaxsp]:[sp][reset] [cyan]ep [reset][eplite][trueep]:[truemaxep]:[ep][reset] [cyan]xp[reset] [exp]:[exptolvl]:[protolvl] [cyan]ad[reset] [exptoadv]:[protoadv] [cyan]df[reset] [df] [cyan]$$[reset] [cash] [cyan]ph[reset] [phase] [cyan]dt[reset] [daytime] [cyan]hr[reset] [hour][reset] [cyan]st[reset] [status] :[nl]"
brutal_regex = "^#brutal hp (?<truehp>\d+):(?<maxhp>\d+):(?<hp>\d+) sp (?<truesp>\d+):(?<maxsp>\d+):(?<sp>\d+) ep (?<trueep>\d+):(?<maxep>\d+):(?<ep>\d+) xp (?<exp>\d+):(?<exptolvl>\d+):(?<pertolvl>\d+)\% ad (?<adtolvl>(\-\d+)|(\d+)):(?<protoadv>\d+)\% df (?<df>\d+) \$\$ (?<cash>\d+) ph (?<phase>\S+) dt (?<dt>\S+) hr (?<hr>.+) st(?<status>.+) :$"

--ansi colours extracted from mushclient
black = RGBColourToName(GetNormalColour(1))
red = RGBColourToName(GetNormalColour(2))
green = RGBColourToName(GetNormalColour(3))
yellow = RGBColourToName(GetNormalColour(4))
blue = RGBColourToName(GetNormalColour(5))
magenta = RGBColourToName(GetNormalColour(6))
cyan = RGBColourToName(GetNormalColour(7))
white = RGBColourToName(GetNormalColour(8))
brightblack = RGBColourToName(GetNormalColour(9))
brightred = RGBColourToName(GetNormalColour(10))
brightgreen = RGBColourToName(GetNormalColour(11))
brightyellow = RGBColourToName(GetNormalColour(12))
brightblue = RGBColourToName(GetNormalColour(13))
brightmagenta = RGBColourToName(GetNormalColour(14))
brightcyan = RGBColourToName(GetNormalColour(15))
brightwhite = RGBColourToName(GetNormalColour(16))
foreground = white
background = black

ingame_prompt = {}
