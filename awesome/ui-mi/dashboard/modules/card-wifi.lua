local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local dpi = beautiful.xresources.apply_dpi
local util = require("ui-mi.dashboard.modules.util")
local color = require("ui-mi.theme.colors")

local gfs = gears.filesystem

local icon_wifi_on = gears.color.recolor_image(beautiful.dashboard_wifi, color["white"])
local icon_wifi_off = gears.color.recolor_image(beautiful.dashboard_wifi_off, color["white"])

-- dynamic content
local wifi_name = wibox.widget {
    markup = 'Wi-Fi',
    align = 'left',
    valign = 'center',
    font = RC.vars.font..'14',
    widget = wibox.widget.textbox,
}

-- dynamic content
local wifi_status = wibox.widget {
    markup = 'Connected',
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox,
}

-- dynamic content
local wifi_icon = wibox.widget{
    image = icon_wifi_on,
    forced_width = 40,
    forced_height = 40,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.imagebox,
}

-- main widget
local wifi_card = util.make_card({
    {
        {
            {
                wifi_icon,
                {
                    {
                        wifi_name,
                        wifi_status,
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

wifi_card:add_button(awful.button({}, 1, function ()
    awful.spawn('bash ' .. gfs.get_configuration_dir() .. 'scripts/toggle-network.sh')
end))

awesome.connect_signal('network::connected', function (is_connected)
    wifi_card.active = is_connected

    awful.spawn.easy_async_with_shell("nmcli -t -f NAME connection show --active", function (name)
        local trimmed_name = helpers.trim(name):gsub("-", "")
        local new_name = string.len(trimmed_name) > 1 and trimmed_name or "Wi-Fi"

        wifi_name:set_markup_silently(new_name)
    end)

    wifi_icon:set_image(is_connected and icon_wifi_on or icon_wifi_off)
    wifi_status:set_markup_silently(is_connected and "Connected" or "Off")
end)

return wifi_card