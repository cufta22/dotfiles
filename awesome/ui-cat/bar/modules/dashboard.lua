local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'

local dashboard_button = wibox.widget {
    image = beautiful.bar_dashboard,
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