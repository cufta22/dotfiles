local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local dpi = beautiful.xresources.apply_dpi
local util = require("ui-mi.dashboard.modules.util")
local color = require("ui-mi.theme.colors")

local bluetooth_signal = require 'signal.bluetooth'

local gfs = gears.filesystem

local buds_labels = require("ui-mi.dashboard.modules.earbuds-labels")

local icon_bluetooth_on = gears.color.recolor_image(beautiful.dashboard_bluetooth, color["white"])
local icon_bluetooth_off = gears.color.recolor_image(beautiful.dashboard_bluetooth_off, color["white"])

-- dynamic content
local bluetooth_name = wibox.widget {
    markup = 'Bluetooth',
    align = 'left',
    valign = 'center',
    font = RC.vars.font..'14',
    widget = wibox.widget.textbox,
}

-- dynamic content
local bluetooth_status = wibox.widget {
    markup = 'Off',
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox,
}

-- dynamic content
local bluetooth_icon = wibox.widget{
    image = icon_bluetooth_on,
    forced_width = 40,
    forced_height = 40,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.imagebox,
}

-- main widget
local bluetooth_card = util.make_card({
    {
        {
            {
                bluetooth_icon,
                {
                    {
                        bluetooth_name,
                        bluetooth_status,
                        layout = wibox.layout.fixed.vertical,
                    },
                    left = 14,
                    widget = wibox.container.margin,
                },
                nil,
                layout = wibox.layout.align.horizontal,
            },
            left   = beautiful.useless_gap * 2,
            right  = beautiful.useless_gap * 2,
            top    = beautiful.useless_gap * 3,
            bottom = beautiful.useless_gap * 3,
            widget = wibox.container.margin,
        },
        widget = wibox.container.background,

        shape = function (cr, w, h)
            return gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, dpi(7))
        end
    },
    layout = wibox.layout.fixed.vertical,
}, color["blue700"], false)

bluetooth_card:add_button(awful.button({}, 1, function ()
    bluetooth_signal.toggle()
end))

awesome.connect_signal('bluetooth::enabled', function (enabled)
    bluetooth_card.active = enabled

    awful.spawn.easy_async_with_shell("bluetoothctl info | grep 'Name' | cut -d ' ' -f2-", function (name)
        local trimmed_name = helpers.trim(name)
        local new_name = string.len(trimmed_name) > 1 and enabled and buds_labels[trimmed_name] or enabled and "On" or "Off"

        bluetooth_status:set_markup_silently(new_name)
    end)

    bluetooth_icon:set_image(enabled and icon_bluetooth_on or icon_bluetooth_off)
end)

return bluetooth_card