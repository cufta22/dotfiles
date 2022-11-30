local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local color = require("ui-mi.theme.colors")

local logo = wibox.widget {
    image = gears.color.recolor_image(beautiful.bar_logo, color["mi"]),
    valign = 'center',
    widget = wibox.widget.imagebox,
}

return wibox.widget {
    logo,
    halign = 'center',
    layout = wibox.container.place,
}