local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

local fs = gears.filesystem

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Battery

local widget_battery = awful.widget.watch(
    fs.get_configuration_dir() .. 'scripts/battery.sh',
    10, -- 10 sec
    function(widget, stdout)
        local new_img, perc = beautiful.bat_1, tonumber(stdout) or 0

        if perc <= 10 then
            new_img = beautiful.bat_5
            naughty.notify({ title = "Battery critical", message = "Connect charger" })
        elseif perc <= 30 then
            new_img = beautiful.bat_4
        elseif perc <= 50 then
            new_img = beautiful.bat_3
        elseif perc <= 70 then
            new_img = beautiful.bat_2
        else
            new_img = beautiful.bat_1
        end

        widget:set_image(new_img)
    end,
    wibox.widget{
        image         = beautiful.bat_1,
        forced_width  = 30,
        forced_height = 30,
        valign        = "center",
        align         = "center",
        widget        = wibox.widget.imagebox,
    }
)

widget_battery:add_button(awful.button({}, 1, function ()
    awesome.emit_signal('solarcycle::toggle')
end))

return widget_battery