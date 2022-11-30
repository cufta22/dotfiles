local wibox = require 'wibox'
local helpers = require 'helpers'
local awful = require 'awful'
local beautiful = require 'beautiful'

local time = wibox.widget {
    format = '%H:%M',
    align = 'center',
    font = RC.vars.font..'11',
    widget = wibox.widget.textclock,
}

local date = wibox.widget {
    format = '%b %d',
    align = 'center',
    font = RC.vars.font..'8',
    widget = wibox.widget.textclock,
}

local widget_clock = wibox.widget {
    {
        {
            {
                time,
                date,
                spacing = 1,
                layout = wibox.layout.fixed.vertical,
            },
            top = 5,
            bottom = 5,
            left = 1,
            right = 1,
            widget = wibox.container.margin,
        },
        shape = helpers.mkroundedrect(),
        widget = wibox.container.background,
        bg = beautiful.black,
    },
    left = 5,
    right = 5,
    widget = wibox.container.margin,
}

-- widget_clock:add_button(awful.button({}, 1, function ()
--     awesome.emit_signal('calendar::toggle')
-- end))

return widget_clock