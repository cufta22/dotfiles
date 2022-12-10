local awful = require("awful")
local gfs = require("gears.filesystem")
local gcolor = require("gears.color")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")

local color = require("ui-mi.theme.colors")

awful.util = require("awful.util")

local dpi = xresources.apply_dpi
local themes_path = gfs.get_themes_dir()
local config_path = awful.util.getdir("config") .. "/ui-mi/theme/"

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- default variables

local theme = {}

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

theme.wallpaper          = RC.vars.wallpaper
theme.awesome_subicon    = config_path.."assets/bar/awesome.png"

theme.font          = RC.vars.font.."9" -- "sans 8"

theme.bg_normal     = color['gray850']
theme.bg_focus      = color['gray850']
theme.bg_urgent     = color['gray850']
theme.bg_minimize   = color['gray850']
theme.bg_systray    = color['gray850']

theme.fg_normal     = color['white']
theme.fg_focus      = color['white']
theme.fg_urgent     = color['white']
theme.fg_minimize   = color['white']

theme.useless_gap           = dpi(10)
theme.systray_icon_spacing  = dpi(4)
theme.border_width          = dpi(2)
theme.rounded               = dpi(8)

theme.border_normal = color['gray850']
theme.border_focus  = color['mi']
theme.border_marked = color['mi']

theme.taglist_bg_focus = color['gray850']
theme.taglist_fg_focus = color['gray850']

theme.tasklist_bg_normal = color['gray850']
theme.tasklist_bg_focus  = color['gray850']
theme.tasklist_fg_focus  = color['gray850']

theme.titlebar_bg_normal = color['gray850']
theme.titlebar_bg_focus  = color['gray850']
theme.titlebar_fg_focus  = color['gray850']

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, color['gray850']
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, color['gray850']
)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"

theme.menu_height = 20      -- dpi(15)
theme.menu_width  = 180     -- dpi(100)
--theme.menu_context_height = 20

theme.menu_bg_normal = color['gray850']
theme.menu_bg_focus  = color['gray850']
theme.menu_fg_focus  = color['white']

theme.menu_border_color = color['mi']
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
-- theme.layout_spiral   = config_path.."assets/layout/spiral.png"

theme.layout_floating  = gcolor.recolor_image(config_path.."assets/layout/float.png", color["green400"])
theme.layout_tile      = gcolor.recolor_image(config_path.."assets/layout/tile.png" , color["blue400"])

theme.fallback_notif_icon = config_path.."assets/other/notification.png"

-- Bar assets

theme.tag_1                      = config_path.."assets/bar/tag_1.png"
theme.tag_2                      = config_path.."assets/bar/tag_2.png"

-- theme.bar_power                  = config_path.."assets/bar/power.png"
theme.bar_logo                   = config_path.."assets/bar/mi.png"
theme.bar_dashboard              = config_path.."assets/bar/dashboard.png"
theme.bar_systray                = config_path.."assets/bar/systray.png"
theme.bar_systray2               = config_path.."assets/bar/systray2.png"

theme.bat_5                      = config_path.."assets/bar/bat_5.png"
theme.bat_4                      = config_path.."assets/bar/bat_4.png"
theme.bat_3                      = config_path.."assets/bar/bat_3.png"
theme.bat_2                      = config_path.."assets/bar/bat_2.png"
theme.bat_1                      = config_path.."assets/bar/bat_1.png"
theme.bat_plug                   = config_path.."assets/bar/bat_plug.png"

theme.sun                        = config_path.."assets/bar/sun.png"
theme.moon                       = config_path.."assets/bar/moon.png"

theme.headphones                 = config_path.."assets/dashboard/headset.png"

theme.dashboard_user             = config_path.."assets/dashboard/dashboard_user.png"

theme.dashboard_wifi             = config_path.."assets/dashboard/dashboard_wifi.png"
theme.dashboard_wifi_off         = config_path.."assets/dashboard/dashboard_wifi_off.png"
theme.dashboard_wifi_vpn         = config_path.."assets/dashboard/dashboard_wifi_vpn.png"

theme.dashboard_bluetooth        = config_path.."assets/dashboard/dashboard_bluetooth.png"
theme.dashboard_bluetooth_off    = config_path.."assets/dashboard/dashboard_bluetooth_off.png"

theme.dashboard_update           = config_path.."assets/dashboard/update_on.png"
theme.dashboard_update_off       = config_path.."assets/dashboard/update_off.png"

theme.dashboard_lock             = config_path.."assets/dashboard/dashboard_lock.png"

theme.mode_redshift              = config_path.."assets/dashboard/mode_redshift.png"
theme.mode_bedtime               = config_path.."assets/dashboard/mode_bedtime.png"
theme.mode_airplane              = config_path.."assets/dashboard/mode_airplane.png"
theme.action_screenshot          = config_path.."assets/dashboard/action_screenshot.png"
theme.action_info                = config_path.."assets/dashboard/action_info.png"
theme.action_symlink             = config_path.."assets/dashboard/action_symlink.png"
theme.action_vol                 = config_path.."assets/dashboard/action_vol.png"
theme.action_vol_off             = config_path.."assets/dashboard/action_vol_off.png"
theme.action_mic                 = config_path.."assets/dashboard/action_mic.png"
theme.action_mic_off             = config_path.."assets/dashboard/action_mic_off.png"

theme.redmi_buds_4_pro           = config_path.."assets/dashboard/redmi-buds-4-pro.png"
theme.redmi_buds_4               = config_path.."assets/dashboard/redmi-buds-4.png"
theme.redmi_buds_3_pro           = config_path.."assets/dashboard/redmi-buds-3-pro.png"
theme.redmi_buds_3_lite          = config_path.."assets/dashboard/redmi-buds-3-lite.png"

theme.xiaomi_buds_4_pro          = config_path.."assets/dashboard/xiaomi-buds-4-pro.png"
theme.xiaomi_buds_3t_pro         = config_path.."assets/dashboard/xiaomi-buds-3t-pro.png"
theme.xiaomi_buds_3              = config_path.."assets/dashboard/xiaomi-buds-3.png"
theme.xiaomi_flipbuds_pro        = config_path.."assets/dashboard/xiaomi-flipbuds-pro.png"

-- Custom variables

theme.ui_bar_width = dpi(50)

return theme

