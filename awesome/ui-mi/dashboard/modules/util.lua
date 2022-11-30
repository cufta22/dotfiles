local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local awful = require("awful")
local gears = require("gears")

local color = require("ui-mi.theme.colors")

local util = {}

function util.make_card(children, background, apply_gaps)
    return wibox.widget {
        {
            children,
            margins = (apply_gaps == true and apply_gaps or (apply_gaps == nil and true or false)) and beautiful.useless_gap * 2 or 0,
            widget = wibox.container.margin,
        },
        id = 'background_role',
        bg = background and background or beautiful.bg_lighter,
        shape = helpers.mkroundedrect(),
        widget = wibox.container.background,

        set_active = function (self, is_active)
            local widget = self:get_children_by_id('background_role')[1]

            if is_active then
                widget.bg = background or color["blue700"]
            else
                widget.bg = color["gray800"]
            end
        end,
    }
end

function util.make_button(template, onclick)
    local button = wibox.widget {
        {
            template,
            top = 1,
            bottom = 1,
            left = 8,
            right = 8,
            widget = wibox.container.margin,
        },
        bg = beautiful.dimblack,
        shape = helpers.mkroundedrect(),
        widget = wibox.container.background,
    }

    button:add_button(awful.button({}, 1, function ()
        if onclick then
            onclick()
        end
    end))

    return button
end

function util.make_actionicon(icon, font)
    return wibox.widget {
        {
            {
                id = 'icon_role',
                image = icon,
                forced_height = 22,
                forced_width = 22,
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
        forced_height = 48,
        forced_width = 48,
        widget = wibox.container.background,

        set_active = function (self, is_active)
            local widget = self:get_children_by_id('background_role')[1]

            if is_active then
                widget.bg = color["blue700"]
            else
                widget.bg = color["gray800"]
            end
        end,
    }
end

return util