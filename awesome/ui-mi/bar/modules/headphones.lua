local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local color = require("ui-mi.theme.colors")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Headphones

local icon_headphones = wibox.widget{
    image         = gears.color.recolor_image(beautiful.headphones, color["purple300"]),
    forced_width  = 30,
    forced_height = 30,
    valign        = "center",
    align         = "center",
    widget        = wibox.widget.imagebox,
}

local widget_headphones = awful.widget.watch(
    "bluetoothctl info | grep 'Percentage' | cut -d ' ' -f3-",
    3, -- 3 sec
    function(widget, stdout)

        -- local bat_perc = string.match(stdout, "*%[([%l]*)")

        local new_txt = '<span color="'.. color["purple300"] ..'">' .. "24".."%" .. '</span>'

        widget:set_markup(new_txt)
    end,
    wibox.widget{
        markup = '',
        font   = RC.vars.font.."11",
        valign = "center",
        widget = wibox.widget.textbox,
    }
)

return {
    ["icon"] = icon_headphones,
    ["perc"] = widget_headphones
}