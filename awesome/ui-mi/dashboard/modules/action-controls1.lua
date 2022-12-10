local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local awful = require("awful")
local color = require("ui-mi.theme.colors")
local utils = require("ui-mi.dashboard.modules.util")

local bedtime_signal = require("signal.bedtime")
local redshift_signal = require("signal.redshift")
local airplane_signal = require("signal.airplane")
local bluetooth_signal = require("signal.bluetooth")

local gfs = gears.filesystem

-- Bedtime icon

local icon_bedtime = utils.make_actionicon(beautiful.mode_bedtime, color["blue700"])

icon_bedtime:add_button(awful.button({}, 1, function ()
    bedtime_signal.toggle_active()
end))

awesome.connect_signal('bedtime::active', function (is_active)
    icon_bedtime.active = not is_active
end)

-- Redshift icon

local icon_redshift = utils.make_actionicon(beautiful.mode_redshift, color["yellow800"])

icon_redshift:add_button(awful.button({}, 1, function ()
    redshift_signal.toggle_active()
end))

awesome.connect_signal('redshift::active', function (is_active)
    icon_redshift.active = not is_active
end)

-- Airplane icon

local icon_airplane = utils.make_actionicon(beautiful.mode_airplane, color["blue700"])

icon_airplane:add_button(awful.button({}, 1, function ()
    airplane_signal.toggle_active()

    awful.spawn('bash ' .. gfs.get_configuration_dir() .. 'scripts/toggle-network.sh')
    bluetooth_signal.toggle()
end))

awesome.connect_signal('airplane::active', function (is_active)
    icon_airplane.active = not is_active
end)

-- main widget
return wibox.widget {
    icon_bedtime,
    icon_redshift,
    icon_airplane,

    id = 'background_role',
    shape = helpers.mkroundedrect(),
    widget = wibox.container.background,
    spacing = beautiful.useless_gap * 3,
    layout = wibox.layout.fixed.horizontal,
}