local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local color = require("ui-mi.theme.colors")

local dashboard_button = wibox.widget {
    image = gears.color.recolor_image(beautiful.bar_dashboard, color["red400"]),
    valign = 'center',
    widget = wibox.widget.imagebox,
}

dashboard_button:add_button(awful.button({}, 1, function ()
    awesome.emit_signal('dashboard::toggle')
end))

return wibox.widget {
    dashboard_button,
    halign = 'center',
    layout = wibox.container.place,
}