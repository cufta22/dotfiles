local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local awful = require("awful")
local color = require("ui-mi.theme.colors")
local naughty = require("naughty")

local volume_signal = require("signal.volume")

-- helper
local function mkactionicon(image)
    return wibox.widget {
        {
            {
                id = 'icon_role',
                image = gears.color.recolor_image(image, color["white"]),
                forced_width = 26,
                forced_height = 26,
                widget = wibox.widget.imagebox,
            },
            halign = 'center',
            valign = 'center',
            layout = wibox.container.place,
        },
        id = 'background_role',
        fg = beautiful.fg_normal,
        bg = beautiful.dimblack,
        shape = gears.shape.circle,
        forced_height = 58,
        forced_width = 58,
        widget = wibox.container.background,

        set_active = function (self, is_active)
            local widget = self:get_children_by_id('background_role')[1]

            if is_active then
                widget.bg = color["blue700"]
            else
                widget.bg = color["gray800"]
            end
        end,

        set_icon = function (self, icon)
            local widget = self:get_children_by_id('icon_role')[1]

            widget:set_image(gears.color.recolor_image(icon, color["white"]))
        end,
    }
end


-- Volume icon

local icon_volume = mkactionicon(beautiful.vol_mute)

icon_volume:add_button(awful.button({}, 1, function ()
    volume_signal.toggle_muted()
end))

awesome.connect_signal('volume::muted', function (is_muted)
    icon_volume.active = not is_muted
    icon_volume.icon = is_muted and beautiful.vol or beautiful.vol_mute
end)

-- main widget
return wibox.widget {
    icon_volume,
    icon_volume,
    icon_volume,

    id = 'background_role',
    shape = helpers.mkroundedrect(),
    widget = wibox.container.background,
    spacing = beautiful.useless_gap * 3,
    layout = wibox.layout.fixed.horizontal,
}