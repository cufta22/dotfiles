-- Standard awesome library
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local color = require("ui-mi.theme.colors")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Volume

local icon_brightness_dynamyc = wibox.widget{
    image         = gears.color.recolor_image(beautiful.sun, color["yellow300"]),
    forced_width  = 30,
    forced_height = 30,
    valign        = "center",
    align         = "center",
    widget        = wibox.widget.imagebox,
}

local widget_brightness = awful.widget.watch(
    "brightnessctl get",
    2, -- 2 sec
    function(widget, stdout)

        local new_img, new_txt = "", ""
        local max = 26666 -- Output of brightnessctl max
        local perc = string.format("%.0f", (stdout:gsub("%s+", "") / max) * 100)

        new_img = tonumber(perc) >= 50 and
            gears.color.recolor_image(beautiful.sun, color["yellow300"]) or
            gears.color.recolor_image(beautiful.moon, color["blueGray300"])

        new_txt = tonumber(perc) >= 50 and
            '<span color="'.. color["yellow300"] ..'">' .. perc.."%" .. '</span>' or
            '<span color="'.. color["blueGray300"] ..'">' .. perc.."%" .. '</span>'
        
        icon_brightness_dynamyc:set_image(new_img)
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
    ["icon"] = icon_brightness_dynamyc,
    ["perc"] = widget_brightness
}