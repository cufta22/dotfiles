local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local dpi = beautiful.xresources.apply_dpi
local util = require("ui-mi.dashboard.modules.util")
local color = require("ui-mi.theme.colors")

local icon_update_on = gears.color.recolor_image(beautiful.dashboard_update, color["white"])
local icon_update_off = gears.color.recolor_image(beautiful.dashboard_update_off, color["white"])

-- dynamic content
local update_name = wibox.widget {
    markup = 'Update available',
    align = 'left',
    valign = 'center',
    font = RC.vars.font..'14',
    widget = wibox.widget.textbox,
}

-- dynamic content
local update_status = wibox.widget {
    markup = 'Click to update now',
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox,
}

-- dynamic content
local update_icon = wibox.widget{
    image = icon_update_on,
    forced_width = 40,
    forced_height = 40,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.imagebox,
}

-- main widget
local update_card = util.make_card({
    {
        {
            {
                update_icon,
                {
                    {
                        update_name,
                        update_status,
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
}, color["yellow800"], false)

update_card:add_button(awful.button({}, 1, function ()
    -- Check for update
    -- run pacman -Syyu if available
end))

gears.timer {
    timeout = 100,
    call_now = true,
    autostart = true,
    callback = function ()
        awful.spawn.easy_async_with_shell("nmcli -t -f NAME connection show --active", function (name)
            -- Check for update
            -- change text
            update_card.active = true
        end)
    end
}

return update_card