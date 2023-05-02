local naughty = require("naughty")
local beautiful = require("beautiful")
local helpers = require("helpers")
local color = require("ui.theme.colors")

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
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        shape = helpers.mkroundedrect(),
        minimum_width = dpi(260),
        maximum_width = dpi(260),
        widget_template = helpers.get_notification_widget(n),
        border_width = 0,
    }
end)