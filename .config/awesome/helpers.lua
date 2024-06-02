local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local naughty = require("naughty")
local color = require("ui.theme.colors")
local dpi = beautiful.xresources.apply_dpi

local helpers = {}

-- create a rounded rect using a custom radius
function helpers.mkroundedrect(radius)
    radius = radius or dpi(7)
    return function (cr, w, h)
        return gears.shape.rounded_rect(cr, w, h, radius)
    end
end


-- notifications
function helpers.get_notification_widget(n)
    return {
        {
            {
                {
                    {
                        {
                            image = n.icon or gears.color.recolor_image(beautiful.fallback_notif_icon, beautiful.fg_normal),
                            forced_height = 32,
                            forced_width = 32,
                            valign = 'center',
                            align = 'center',
                            clip_shape = gears.shape.circle,
                            widget = wibox.widget.imagebox,
                        },
                        n.title == '' and nil or {
                            markup = '<b>' .. n.title .. '</b>',
                            align = 'center',
                            valign = 'center',
                            widget = wibox.widget.textbox,
                        },
                        spacing = dpi(10),
                        layout = wibox.layout.fixed.horizontal,
                    },
                    margins = dpi(10),
                    widget = wibox.container.margin,
                },
                layout = wibox.layout.fixed.vertical,
            },
            {
                {
                    {
                        markup = n.title == '' and '<b>' .. n.message .. '</b>' or n.message,
                        -- align = 'center',
                        -- valign = 'center',
                        widget = wibox.widget.textbox,
                    },
                    spacing = 0,
                    layout = wibox.layout.fixed.vertical,
                },
                top = dpi(4),
                left = dpi(12),
                right = dpi(12),
                bottom = dpi(10),
                widget = wibox.container.margin,
            },
            spacing = dpi(5),
            layout = wibox.layout.align.vertical,
        },
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        shape = helpers.mkroundedrect(),
        widget = wibox.container.background,
    }
end

return helpers