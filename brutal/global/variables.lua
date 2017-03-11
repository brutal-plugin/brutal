--set fonts and size, (feel free to experiment with these)
miniwindow_font = "consolas"
miniwindow_font_size = 8
infobar_font = "consolas"
infobar_font_size = 8

--set the terminal (ingame term (cols)x(rows), to avoid give problems with -more- when setting alias)
terminal = "180x100"

--gag output from main window
gag_ingame_prompt = true

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

--set brutal prompt, (for my refrence and global variables/tables, dont change these)
brutal_prompt = "[cyan]#[reset]brutal [cyan]hp [reset][hplite][truehp]:[truemaxhp]:[hp] [cyan]sp [reset][splite][truesp]:[truemaxsp]:[sp] [cyan]ep [reset][eplite][trueep]:[truemaxep]:[ep] [cyan]xp [reset][exp]:[exptolvl]:[protolvl] [cyan]ad [reset][exptoadv]:[protoadv] [cyan]df [reset][df] [cyan]$$ [reset][cash] [cyan]ph [reset][phase] [cyan]dt [reset][daytime] [cyan]hr [reset][hour] [cyan]st[reset] [status] :[nl]"
brutal_regex = "#brutal hp (?<truehp>(-\d+)|\d+)\:(?<maxhp>\d+)\:(?<hp>\d+) sp (?<truesp>(-\d+)|\d+)\:(?<maxsp>\d+)\:(?<sp>\d+) ep (?<trueep>(-\d+)|\d+)\:(?<maxep>\d+)\:(?<ep>\d+) xp (?<xp>(-\d+)|\d+)\:(?<exptolvl>(-\d+|\d+))\:(?<protolvl>(-\d+|\d+))\% ad (?<exptoadv>(-\d+|\d+))\:(?<protoadv>(-\d+|\d+))\% df (?<df>\d+) \$\$ (?<cash>\d+) ph (?<phase>\S+) dt (?<dt>\S+) hr (?<hr>.+) st(?<st>.+)\:$"
ingame_prompt = {}
prompt_line = ""
prompt_styles = {}
