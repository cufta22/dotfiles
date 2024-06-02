local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local color = require("ui.theme.colors")

-- listening awesomewm events
require("ui.solarcycle.listener")

local sun_widget = function(img)
    return wibox.widget{
        image         = img,
        forced_width  = 50,
        forced_height = 50,
        valign        = "center",
        align         = "center",
        widget        = wibox.widget.imagebox,
    }
end

awful.screen.connect_for_each_screen(function (s)
    s.solarcycle = {}

    s.solarcycle.popup = wibox {
        visible = false,
        ontop = true,
        width = 350,
        height = 130,
        bg = color["base"],
        fg = color["text"],
        x = beautiful.useless_gap * 2,
        y = beautiful.bar_height + beautiful.useless_gap * 2,
    }

    local self = s.solarcycle.popup

    self:setup {
        {
            {
                {
                    {
                        sun_widget(beautiful.bat_1),
                        sun_widget(beautiful.bat_2),
                        sun_widget(beautiful.bat_3),
                        sun_widget(beautiful.bat_4),
                        sun_widget(beautiful.bat_5),

                        spacing = 12,
                        layout = wibox.layout.fixed.horizontal
                    },
                    {
                        {
                            markup = 'Solar Cycle',
                            align  = 'center',
                            font   = RC.vars.font.."16",
                            widget = wibox.widget.textbox,
                        },

                        top = 12,
                        widget = wibox.container.margin,
                    },

                    layout = wibox.layout.fixed.vertical,
                },
                halign = 'center',
                valign = 'center',
                layout = wibox.container.place,
            },
            margins = 12,
            widget = wibox.container.margin,
        },
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        widget = wibox.container.background,
    }

    function s.solarcycle.toggle()
        if self.visible then
            s.solarcycle.hide()
        else
            s.solarcycle.show()
        end
    end

    function s.solarcycle.show()
        self.visible = true
    end

    function s.solarcycle.hide()
        self.visible = false
    end
end)