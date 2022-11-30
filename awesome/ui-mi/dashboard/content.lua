local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local card_user = require("ui-mi.dashboard.modules.card-user")
local card_wifi = require("ui-mi.dashboard.modules.card-wifi")
local card_update = require("ui-mi.dashboard.modules.card-update")
local card_bluetooth = require("ui-mi.dashboard.modules.card-bluetooth")

local action_brightness = require("ui-mi.dashboard.modules.action-brightness")
local action_controls = require("ui-mi.dashboard.modules.action-controls")

local widget_stats = require("ui-mi.dashboard.modules.stats")
local widget_earbuds = require("ui-mi.dashboard.modules.earbuds")

local dpi = beautiful.xresources.apply_dpi

local username = wibox.widget {
    markup = 'Hello',
    widget = wibox.widget.textbox,
}

awful.spawn.easy_async_with_shell('whoami', function (name)
    username:set_markup_silently('Hello ' .. helpers.capitalize(helpers.trim(name)))
end)

local mainbox = wibox.widget {
    {
        {
            {
                {
                    card_user,
                    card_bluetooth,
                    action_controls,
                    spacing = beautiful.useless_gap * 2,
                    layout = wibox.layout.fixed.vertical,
                },
                {
                    card_wifi,
                    card_update,
                    action_brightness,
                    spacing = beautiful.useless_gap * 2,
                    layout = wibox.layout.fixed.vertical,
                },
                spacing = beautiful.useless_gap * 2,
                layout = wibox.layout.flex.horizontal,
            },
            
            wibox.container.margin(nil, 0, 0, beautiful.useless_gap * 2, 0),
           
            {
                widget_stats,
                widget_earbuds,

                spacing = beautiful.useless_gap * 2,
                layout = wibox.layout.fixed.vertical,
            },

            layout = wibox.layout.align.vertical,
        },
        margins = beautiful.useless_gap * 2,
        widget = wibox.container.margin,
    },
    bg = beautiful.bg_normal,
    widget = wibox.container.background,
    shape = function (cr, w, h)
        return gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, dpi(14))
    end
}

local widget = {
    {
        mainbox,
        nil,
        layout = wibox.layout.align.vertical,
    },
    bg = beautiful.bg_lighter,
    widget = wibox.container.background,
}

return widget