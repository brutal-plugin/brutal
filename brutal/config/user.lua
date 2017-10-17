--[[

USER CONFIGURATION OPTIONS
----------------------------

]]--

-- load brutal colour theme (set to false to use default muschlient colours)
brutal_theme_enabled = true

-- main output window font and size
-- if the theme is enabled, the Inconsolata font will self install
-- change it if theme is disabled, or font is not installed on system
-- brutal_output_font = "Lucida Console" --for example
brutal_output_font = "Inconsolata"
brutal_output_font_size = 10

-- infobar font and size
-- infobar_font = "Lucida Console" --for example
infobar_font = brutal_output_font ---we just equating to brutal_output_font
infobar_font_size = 8

-- miniwindow font and size
-- miniwindow_font = "Lucida Console" --for example
miniwindow_font = brutal_output_font --we just equating to brutal_output_font
miniwindow_font_size = 9

-- set ingame terminal
terminal = "180x100" --we want to avoid the -more- command, more lines the better

-- gag ingame prompt
gag_ingame_prompt = true

-- gag ingame hp/sp/ep health bars
gag_color_bar = true

comms_win_enabled = false
