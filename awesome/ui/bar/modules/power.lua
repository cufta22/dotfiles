local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'

local power_button = wibox.widget {
    image = beautiful.bar_power,
    valign = 'center',
    widget = wibox.widget.imagebox,
}

power_button:add_button(awful.button({}, 1, function ()
    awesome.emit_signal('powermenu::toggle')
end))

return wibox.widget {
    power_button,
    halign = 'center',
    layout = wibox.container.place,
}