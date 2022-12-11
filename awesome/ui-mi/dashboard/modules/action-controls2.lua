local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local awful = require("awful")
local naughty = require("naughty")
local color = require("ui-mi.theme.colors")
local utils = require("ui-mi.dashboard.modules.util")

-- Screenshot icon

local icon_screenshot = utils.make_actionicon(beautiful.action_screenshot, color["blue700"])

icon_screenshot:add_button(awful.button({}, 1, function ()
    awesome.emit_signal('dashboard::toggle')
    awful.spawn.with_shell('flameshot gui -d 500')
    icon_screenshot.active = true
end))

gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function ()
        icon_screenshot.active = false
    end,
}


-- Lock icon

local icon_lock = utils.make_actionicon(beautiful.dashboard_lock, color["blue700"])

icon_lock:add_button(awful.button({}, 1, function ()
    awful.spawn.with_shell('i3lock-fancy')
    icon_lock.active = true
end))

gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function ()
        icon_lock.active = false
    end,
}

-- Symlink icon

local icon_symlink = utils.make_actionicon(beautiful.action_symlink, color["blue700"])

icon_symlink:add_button(awful.button({}, 1, function ()
    awful.spawn.with_shell(RC.vars.terminal .. ' -e sh ~/dotfiles/symlink.sh')
    icon_symlink.active = true
end))

gears.timer {
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = function ()
        icon_symlink.active = false
    end,
}

-- main widget
return wibox.widget {
    icon_screenshot,
    icon_symlink,
    icon_lock,

    id = 'background_role',
    shape = helpers.mkroundedrect(),
    widget = wibox.container.background,
    spacing = beautiful.useless_gap * 3,
    layout = wibox.layout.fixed.horizontal,
}