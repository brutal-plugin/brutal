--set brutal prompt, (for my refrence and global variables/tables, dont change these)
brutal_prompt = "[cyan]#[reset]brutal [cyan]hp [reset][hplite][truehp]:[truemaxhp]:[hp] [cyan]sp [reset][splite][truesp]:[truemaxsp]:[sp] [cyan]ep [reset][eplite][trueep]:[truemaxep]:[ep] [cyan]xp [reset][exp]:[exptolvl]:[protolvl] [cyan]ad [reset][exptoadv]:[protoadv] [cyan]df [reset][df] [cyan]$$ [reset][cash] [cyan]ph [reset][phase] [cyan]dt [reset][daytime] [cyan]hr [reset][hour] [cyan]st[reset] [status] :[nl]"
brutal_regex = "#brutal hp (?<truehp>(-\d+)|\d+)\:(?<maxhp>\d+)\:(?<hp>\d+) sp (?<truesp>(-\d+)|\d+)\:(?<maxsp>\d+)\:(?<sp>\d+) ep (?<trueep>(-\d+)|\d+)\:(?<maxep>\d+)\:(?<ep>\d+) xp (?<xp>(-\d+)|\d+)\:(?<exptolvl>(-\d+|\d+))\:(?<protolvl>(-\d+|\d+))\% ad (?<exptoadv>(-\d+|\d+))\:(?<protoadv>(-\d+|\d+))\% df (?<df>\d+) \$\$ (?<cash>\d+) ph (?<phase>\S+) dt (?<dt>\S+) hr (?<hr>.+) st(?<st>.+)\:$"
--define global vaiables and tables
ingame_prompt = {}
track_update = {}
whoami = ""
--create containers for each miniwindow
decor_win = "decor_" .. GetPluginID()
stats_win = "stats_" .. GetPluginID()
comms_win = "comms_" .. GetPluginID()
party_win = "party_" .. GetPluginID()
minfo_win = "minfo_" .. GetPluginID()
buffs_win = "buffs_" .. GetPluginID()
--create empty containers for each of the different font styles.
body_font = "body_font"
title_font = "title_font"
font_normal = "font_normal"
font_strike = "font_strike"
--define the window width and heights and text inset from the borders
--windowWidth = 570
--windowHeight = 300
TEXT_INSET = 5
--create emtpy container to load all the sprites, and define their size (32x32)
sprites = {}
sprite_width = 32
sprite_height = 32
