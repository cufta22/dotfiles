local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "ui-" .. RC.vars.global_theme .. "/theme/theme.lua")

-- if (RC.vars.wallpaper) then
--     local wallpaper = RC.vars.wallpaper
--     if awful.util.file_readable(wallpaper) then theme.wallpaper = wallpaper end
-- end

-- -- Wallpaper
-- if beautiful.wallpaper then
--     for s = 1, screen.count() do
--         gears.wallpaper.maximized(beautiful.wallpaper, s, true)
--     end
-- end
