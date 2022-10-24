local naughty = require("naughty")
local beautiful = require('beautiful')
local helpers = require('helpers')
local color = require('theme.colors')

local dpi = beautiful.xresources.apply_dpi

-- display errors
naughty.connect_signal('request::display_error', function (message, startup)
    naughty.notification {
        urgency = 'critical',
        title = 'An error happened' .. (startup and ' during startup' or ''),
        message = message,
    }
end)

-- display notification
naughty.connect_signal('request::display', function (n)
    naughty.layout.box {
        notification = n,
        position = 'top_right',
        -- border_width = 3,
        -- border_color = color["surface0"],
        bg = color["base"],
        fg = color["text"],
        shape = helpers.mkroundedrect(8),
        minimum_width = dpi(240),
        y = 30,
        x = 50
    }
end)