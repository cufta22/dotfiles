local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local awful = require("awful")
local color = require("ui-mi.theme.colors")
local utils = require("ui-mi.dashboard.modules.util")

local volume_signal = require("signal.volume")
local mic_signal = require("signal.mic")

-- Volume icon

local icon_volume = utils.make_actionicon(beautiful.action_vol, color["blue700"])

icon_volume:add_button(awful.button({}, 1, function ()
    volume_signal.toggle_muted()
end))

awesome.connect_signal('volume::muted', function (is_muted)
    icon_volume.active = not is_muted
    icon_volume.icon = is_muted and beautiful.action_vol or beautiful.action_vol_off
end)

-- Mic icon

local icon_mic = utils.make_actionicon(beautiful.action_mic, color["blue700"])

icon_mic:add_button(awful.button({}, 1, function ()
    mic_signal.toggle_active()
end))

awesome.connect_signal('mic::muted', function (is_muted)
    icon_mic.active = not is_muted
    icon_mic.icon = is_muted and beautiful.action_mic or beautiful.action_mic_off
end)

-- Info icon

local icon_info = utils.make_actionicon(beautiful.action_info, color["blue700"])

icon_info:add_button(awful.button({}, 1, function ()
    awful.spawn.with_shell(RC.vars.terminal_hold .. " neofetch")
    icon_info.active = true
end))

gears.timer {
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = function ()
        icon_info.active = false
    end,
}

-- main widget
return wibox.widget {
    icon_volume,
    icon_mic,
    icon_info,

    id = 'background_role',
    shape = helpers.mkroundedrect(),
    widget = wibox.container.background,
    spacing = beautiful.useless_gap * 3,
    layout = wibox.layout.fixed.horizontal,
}