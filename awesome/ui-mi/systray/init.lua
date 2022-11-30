local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

-- listening awesomewm events
require("ui-mi.systray.listener")

awful.screen.connect_for_each_screen(function (s)
    s.systray = {}

    local dimensions = {
        width = 200,
        height = 50,
    }

    s.systray.popup = wibox {
        visible = false,
        ontop = true,
        width = dimensions.width,
        height = dimensions.height,
        bg = beautiful.bg_normal .. '00',
        fg = beautiful.fg_normal,
        x = s.geometry.x + beautiful.ui_bar_width + beautiful.useless_gap * 2,
        y = s.geometry.height - s.geometry.height / 9 - dimensions.height - beautiful.useless_gap * 2,
    }

    local self = s.systray.popup

    self:setup {
        {
            {
                {
                    {
                        widget = wibox.widget.systray,
                        screen = s,
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.fixed.vertical,
            },
            margins = 12,
            widget = wibox.container.margin,
        },
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        widget = wibox.container.background,
    }

    function s.systray.toggle()
        if self.visible then
            s.systray.hide()
        else
            s.systray.show()
        end
    end

    function s.systray.show()
        self.visible = true
    end

    function s.systray.hide()
        self.visible = false
    end
end)