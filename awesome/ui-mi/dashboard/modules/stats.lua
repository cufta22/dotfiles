local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local dpi = beautiful.xresources.apply_dpi
local util = require("ui-mi.dashboard.modules.util")
local color = require("ui-mi.theme.colors")

local utils = require("ui-mi.bar.utils")

local widgets = {
  volume         = require("ui-mi.bar.modules.volume"),
  battery        = require("ui-mi.bar.modules.battery"),
  brightness     = require("ui-mi.bar.modules.brightness"),
  headphones     = require("ui-mi.bar.modules.headphones"),
}

local stats_widget = wibox.widget{
    {
        {
            utils.widget_margin(
                0,  0,  20,  20,
                widgets.battery.icon,
                utils.widget_margin(4, 0, 0, 0, widgets.battery.perc)
            ),
            utils.widget_margin(
                0,  0,  20,  20,
                widgets.volume.icon,
                utils.widget_margin(4, 0, 0, 0, widgets.volume.perc)
            ),
            utils.widget_margin(
                0,  0,  20,  20,
                widgets.brightness.icon,
                utils.widget_margin(4, 0, 0, 0, widgets.brightness.perc)
            ),

            spacing = beautiful.useless_gap * 6,
            layout = wibox.layout.fixed.horizontal,
        },

        valign = "center",
        halign = "center",
        spacing = beautiful.useless_gap * 0,
        layout = wibox.container.place,
    },

    shape = helpers.mkroundedrect(),
    bg = color["gray900"],

    widget = wibox.widget.background
}

return stats_widget