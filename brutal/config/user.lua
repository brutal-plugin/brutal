--[[

USER CONFIGURATION OPTIONS
----------------------------

]]--

-- load brutal colour theme (set to false to use default muschlient colours)
brutal_theme_enabled = true
--change default muschlient options (only valid if brutal theme is active)
input_background_colour = BLACK     --command prompt input bg colour, valid colour names in variables.lua
input_text_colour = WHITE           --command prompt input fg colour, valid colour names in variables.lua
confirm_before_replacing_typing = 0 --disable confirmation when pressing up arrow key
F1macro = 1                         --F1 and F6 are macros, 0 disables
ErrorNotificationToOutputWindow = 1 --print errors to output window instead of annoying textbox
max_output_lines = 50000            --increase scrollback lines on output window
wrap_column = 140                   --maximum number of characters per line for width in output window

-- main output window font and size
-- if the theme is enabled, the Inconsolata font will self install
-- change it if theme is disabled, or font is not installed on system
-- brutal_output_font = "Lucida Console" --for example
brutal_output_font = "Inconsolata"
brutal_output_font_size = 10

-- infobar font and size
-- infobar_font = "Lucida Console"   --for example
infobar_font = brutal_output_font    --we just equating to brutal_output_font
infobar_font_size = 8

-- miniwindow font and size
-- miniwindow_font = "Lucida Console" --for example
miniwindow_font = brutal_output_font  --we just equating to brutal_output_font
miniwindow_font_size = 9

-- set ingame terminal size, will send "term 180x100" to the game for example
terminal = "180x100"                  --we want to avoid the -more- command, more lines the better

-- gag ingame prompt
gag_ingame_prompt = true              --remove prompt, infobar and miniwindow will have these stats

-- gag ingame hp/sp/ep health bars
gag_color_bar = true                  --infobar  and miniwindow will keep track of this instead

--enable communications floating window (still in development, set it to false.)
comms_win_enabled = false
