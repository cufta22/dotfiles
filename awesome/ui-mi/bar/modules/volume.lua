local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local color = require("ui-mi.theme.colors")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Volume

local icon_volume_dynamyc = wibox.widget{
    image         = gears.color.recolor_image(beautiful.vol, color["blue300"]),
    forced_width  = 30,
    forced_height = 30,
    valign        = "center",
    align         = "center",
    widget        = wibox.widget.imagebox,
}

local widget_volume = awful.widget.watch(
    "amixer get Master",
    3, -- 3 sec
    function(widget, stdout)

        local vol_level, vol_status = string.match(stdout, "([%d]+)%%.*%[([%l]*)")
        local vol_level = tonumber(vol_level)

        local new_img = gears.color.recolor_image(beautiful.vol, color["blue300"])
        local new_txt = '<span color="'.. color["blue300"] ..'">' .. vol_level.."%"  .. '</span>'

        if vol_status == "off" then
            new_txt = '<span color="'.. color["green300"] ..'">' ..  "---" .. '</span>'
            new_img = gears.color.recolor_image(beautiful.vol_mute, color["green300"])
        end

        icon_volume_dynamyc:set_image(new_img)
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
    ["icon"] = icon_volume_dynamyc,
    ["perc"] = widget_volume
}