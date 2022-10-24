local awful = require("awful")
local gfs = require("gears.filesystem")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")

local color = require("theme.colors")

awful.util = require("awful.util")

local dpi = xresources.apply_dpi
local themes_path = gfs.get_themes_dir()
local config_path = awful.util.getdir("config") .. "/theme/"

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- default variables

local theme = {}

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

theme.wallpaper          = RC.vars.wallpaper
theme.awesome_subicon    = config_path.."assets/lol.png"

theme.font          = RC.vars.font.."9" -- "sans 8"

theme.bg_normal     = color['mantle']
theme.bg_focus      = color['sapphire']
theme.bg_urgent     = color['sapphire']
theme.bg_minimize   = color['mantle']
theme.bg_systray    = color['base']

theme.fg_normal     = color['text']
theme.fg_focus      = color['text']
theme.fg_urgent     = color['text']
theme.fg_minimize   = color['text']

theme.useless_gap           = dpi(10)
theme.systray_icon_spacing  = dpi(4)
theme.border_width          = dpi(2)
theme.rounded               = dpi(8)

theme.border_normal = color['crust']
theme.border_focus  = color['sapphire']
theme.border_marked = color['sapphire']

theme.taglist_bg_focus = color['crust']
theme.taglist_fg_focus = color['crust']

theme.tasklist_bg_normal = color['crust']
theme.tasklist_bg_focus  = color['crust']
theme.tasklist_fg_focus  = color['crust']

theme.titlebar_bg_normal = color['crust']
theme.titlebar_bg_focus  = color['crust']
theme.titlebar_fg_focus  = color['crust']

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, color['crust']
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, color['crust']
)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"

theme.menu_height = 20      -- dpi(15)
theme.menu_width  = 180     -- dpi(100)
--theme.menu_context_height = 20

theme.menu_bg_normal = color['crust']
theme.menu_bg_focus  = color['surface0']
theme.menu_fg_focus  = color['text']

theme.menu_border_color = color['xgold4']
theme.menu_border_width = 1


-- You can use your own layout icons like this:
-- theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
-- theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
-- theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
-- theme.layout_max = themes_path.."default/layouts/maxw.png"
-- theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
-- theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
-- theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
-- theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
-- theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
-- theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
-- theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
-- theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
-- theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

theme.layout_spiral   = config_path.."assets/layout/spiral.png"
theme.layout_floating = config_path.."assets/layout/float.png"
theme.layout_tile     = config_path.."assets/layout/tile.png"

-- Bar assets

theme.tag_normal             = config_path.."assets/bar/tag_normal.png"
theme.tag_clients            = config_path.."assets/bar/tag_clients.png"
theme.tag_selected           = config_path.."assets/bar/tag_selected.png"

theme.bar_power              = config_path.."assets/bar/power.png"
theme.bar_dashboard          = config_path.."assets/bar/awesome.png"

theme.bat_5                  = config_path.."assets/bar/bat_5.png"
theme.bat_4                  = config_path.."assets/bar/bat_4.png"
theme.bat_3                  = config_path.."assets/bar/bat_3.png"
theme.bat_2                  = config_path.."assets/bar/bat_2.png"
theme.bat_1                  = config_path.."assets/bar/bat_1.png"
theme.bat_plug               = config_path.."assets/bar/bat_plug.png"

theme.vol                    = config_path.."assets/bar/vol.png"
theme.vol_mute               = config_path.."assets/bar/vol_mute.png"

theme.sun                    = config_path.."assets/bar/sun.png"
theme.moon                   = config_path.."assets/bar/moon.png"

theme.powermenu_4            = config_path.."assets/powermenu/powermenu_4.png"
theme.powermenu_3            = config_path.."assets/powermenu/powermenu_3.png"
theme.powermenu_2            = config_path.."assets/powermenu/powermenu_2.png"
theme.powermenu_1            = config_path.."assets/powermenu/powermenu_1.png"
theme.powermenu_main         = config_path.."assets/powermenu/main.png"

return theme

