local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local brightness_signal = require("signal.brightness")
local color = require("ui-mi.theme.colors")

-- helper
local function mkslider()
    return wibox.widget {
        {
            id = 'slider_role',
            value = 100,
            handle_shape = gears.shape.circle,
            handle_color = color["gray400"],
            handle_width = 0,
            bar_border_width = 0,
            bar_active_color = color["gray400"],
            bar_color = color["gray900"],
            bar_shape = helpers.mkroundedrect(),
            widget = wibox.widget.slider,
            bar_height = 58,
            forced_height = 58,
        },
        {
            {
                {
                    image = gears.color.recolor_image(beautiful.sun, color["white"]),
                    align = 'start',
                    valign = 'center',
                    forced_height = 10,
                    forced_width = 10,
                    widget = wibox.widget.imagebox,
                },
                left = beautiful.useless_gap * 2,
                top = 14,
                bottom = 14,
                widget = wibox.container.margin,
            },
            fg = beautiful.bg_normal,
            widget = wibox.container.background,
        },
        layout = wibox.layout.stack,
        get_slider = function (self)
            return self:get_children_by_id('slider_role')[1]
        end,
        set_value = function (self, val)
            self.slider.value = val
        end,
    }
end


local brightness = mkslider()

brightness.slider:connect_signal('property::value', function (_, value)
    brightness_signal.set(value)
end)

awesome.connect_signal('brightness::value', function (br_value)
    brightness.value = br_value
end)

-- main widget
return wibox.widget {
    brightness,
    id = 'background_role',
    shape = helpers.mkroundedrect(),
    widget = wibox.container.background,
}