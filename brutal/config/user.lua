--[[
USER CONFIGURATION OPTIONS
----------------------------
]]--

-- load brutal colour theme (set to false to use default muschlient colours)
brutal_theme_enabled = true

-- change default muschlient options (only valid if brutal theme is active)
input_background_colour = BLACK     -- command prompt input bg colour, valid colour names in colours.lua
input_text_colour = WHITE           -- command prompt input fg colour, valid colour names in colours.lua
confirm_before_replacing_typing = 0 -- disable confirmation when pressing up arrow key
F1macro = 1                         -- F1 and F6 are macros, 0 disables (for some reason cant be use inside a plugin)
lower_case_tab_completion = 1       -- use lower case on tab complete
ErrorNotificationToOutputWindow = 1 -- print errors to output window instead of annoying textbox
max_output_lines = 50000            -- increase scrollback lines on output window
wrap_column = 150                   -- maximum number of characters per line for width in output window
echo_colour = 5                     -- echo my input in custom colour

-- create a standard theme for miniwindows, saved under a in a table.
-- Inconsolata font has been supplied with this plugin, and will install automatically as jail in mushclient

theme = {                                 -- start of theme table

    WINDOW_BACKGROUND = BLACK,            -- for miniwindow body
    WINDOW_BORDER = BRIGHTBLACK,          -- for miniwindow body
    TITLE_BACKGROUND = BRIGHTCYAN,        -- for miniwindo title area
    TITLE_HEIGHT = 17,                    -- for miniwindow title area
    TITLE_FONT_NAME = "Inconsolata",      -- for miniwindow title area
    TITLE_FONT_SIZE = 8,                 -- for miniwindow title area
    BODY_FONT_NAME = "Inconsolata",       -- for miniwindow default font
    BODY_FONT_SIZE = 8,                   -- for miniwindow default size
    BODY_FONT_COLOUR = BRIGHTWHITE,       -- for miniwindow default font colour
    INPUT_FONT_NAME = "Lucida Console",   -- for command window
    INPUT_FONT_SIZE = 9,                  -- for command window
    OUTPUT_FONT_NAME = "Lucida Console",  -- for main game window
    OUTPUT_FONT_SIZE = 9                  -- for main game window

}                                         -- end theme table

-- set ingame terminal settings size, recommended: off, ansi, 150x120
terminal_autodetect = "off"           -- ingame autodetect can do wierd things, better to set off
terminal_type = "ansi"                -- set to ansi.. xterm/freedom do wierd stuff
terminal_size = "150x120"             -- we want to avoid the -more- command, more lines the better

-- gag ingame prompt
gag_ingame_prompt = true              -- remove ingame prompt, and let the infobar handle this

-- gag ingame hp/sp/ep health bars
gag_color_bar = true                  -- remove ingame health guages, and let the infobar handle this

-- enable miniwindows
stats_win_enabled = true      -- enable healthbar and status mini floating window
buffs_win_enabled = true      -- enable miniwindow for displaying active buffs
comms_win_enabled = true      -- enable communications floating window
party_win_enabled = true      -- enable party placement miniwindow
use_classic_infobar = false   -- use classic modern infobar

--[[
End of user configuration options
]]--
