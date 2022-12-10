local gears = require 'gears'
local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local naughty = require 'naughty'
local dpi = beautiful.xresources.apply_dpi

local helpers = {}

-- create a rounded rect using a custom radius
function helpers.mkroundedrect(radius)
    radius = radius or dpi(7)
    return function (cr, w, h)
        return gears.shape.rounded_rect(cr, w, h, radius)
    end
end


-- colorize a text using pango markup
function helpers.get_colorized_markup(content, fg)
    fg = fg or beautiful.fg_normal
    content = content or ''

    return '<span foreground="' .. fg .. '">' .. content .. '</span>'
end


-- trim strings
function helpers.trim(input)
    local result = input:gsub("%s+", "")
    return string.gsub(result, "%s+", "")
end


-- capitalize a string
function helpers.capitalize (txt)
    return string.upper(string.sub(txt, 1, 1))
        .. string.sub(txt, 2, #txt)
end

-- a fully capitalizing helper.
function helpers.complex_capitalizing (s)
    local r, i = '', 0
    for w in s:gsub('-', ' '):gmatch('%S+') do
        local cs = helpers.capitalize(w)
        if i == 0 then
            r = cs
        else
            r = r .. ' ' .. cs
        end
        i = i + 1
    end

    return r
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
                            markup = '<b>' .. helpers.complex_capitalizing(n.title) .. '</b>',
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
                {
                    {
                        {
                            markup = '',
                            widget = wibox.widget.textbox,
                        },
                        top = 1,
                        widget = wibox.container.margin,
                    },
                    bg = beautiful.light_black,
                    widget = wibox.container.background,
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
            {
                {
                    notification = n,
                    base_layout = wibox.widget {
                        spacing = dpi(12),
                        layout = wibox.layout.flex.horizontal,
                    },
                    widget_template = {
                        {
                            {
                                {
                                    id = 'text_role',
                                    widget = wibox.widget.textbox,
                                },
                                widget = wibox.container.place,
                            },
                            top = dpi(7),
                            bottom = dpi(7),
                            left = dpi(4),
                            right = dpi(4),
                            widget = wibox.container.margin,
                        },
                        shape = gears.shape.rounded_bar,
                        bg = beautiful.black,
                        widget = wibox.container.background,
                    },
                    widget = naughty.list.actions,
                },
                margins = dpi(5),
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