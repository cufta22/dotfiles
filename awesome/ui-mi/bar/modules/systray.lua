local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local color = require("ui-mi.theme.colors")

local systray_button = wibox.widget {
    image = gears.color.recolor_image(beautiful.bar_systray, color["teal400"]),
    valign = 'center',
    widget = wibox.widget.imagebox,
}

systray_button:add_button(awful.button({}, 1, function ()
    awesome.emit_signal('systray::toggle')
end))

return wibox.widget {
    systray_button,
    halign = 'center',
    layout = wibox.container.place,
}