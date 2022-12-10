local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local dpi = beautiful.xresources.apply_dpi
local util = require("ui-mi.dashboard.modules.util")
local color = require("ui-mi.theme.colors")

local gfs = gears.filesystem

-- dynamic content
local profile_username = wibox.widget {
    markup = 'Welcome',
    align = 'left',
    valign = 'center',
    font = RC.vars.font..'14',
    widget = wibox.widget.textbox,
}

awful.spawn.easy_async_with_shell('whoami', function (name)
    profile_username:set_markup_silently('Welcome ' .. helpers.trim(name))
end)

local uptime = wibox.widget {
    markup = 'Uptime',
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox,
}

-- update uptime lol
gears.timer {
    timeout = 10,
    call_now = true,
    autostart = true,
    callback = function ()
        awful.spawn.easy_async_with_shell('uptime -p', function (time)            
            uptime:set_markup_silently(
                helpers.capitalize(string.gsub(time, "\n", ""))
            )
        end)
    end
}

-- main widget
local user_card = util.make_card({
    {
        {
            {
                {
                    image = gears.color.recolor_image(beautiful.dashboard_user, color["white"]),
                    forced_width = 40,
                    forced_height = 40,
                    align = 'center',
                    valign = 'center',
                    widget = wibox.widget.imagebox,
                },
                {
                    {
                        profile_username,
                        uptime,
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
        bg = beautiful.bg_lighter,
        widget = wibox.container.background,
        shape = function (cr, w, h)
            return gears.shape.partially_rounded_rect(cr, w, h, false, false, true, true, dpi(7))
        end
    },
    layout = wibox.layout.fixed.vertical,
}, color["green700"], false)

return user_card