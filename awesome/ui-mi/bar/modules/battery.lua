local wibox = require("wibox")
local beautiful = require("beautiful")
local lain = require("lain")
local gears = require("gears")
local color = require("ui-mi.theme.colors")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Battery

local icon_battery_dynamyc = wibox.widget{
    image         = beautiful.bat_4,
    forced_width  = 30,
    forced_height = 30,
    valign        = "center",
    align         = "center",
    widget        = wibox.widget.imagebox,
}

local widget_battery_perc = wibox.widget{
    markup = '',
    font   = RC.vars.font.."11",
    valign = "center",
    widget = wibox.widget.textbox,
}

lain.widget.bat({
    timeout = 3, -- Refresh rate
    settings = function()
        local new_img, perc = "", tonumber(bat_now.perc) or 0
        local new_txt = perc

        if perc <= 20 then
            new_img = beautiful.bat_1
        elseif perc <= 40 then
            new_img = beautiful.bat_2
        elseif perc <= 60 then
            new_img = beautiful.bat_3
        elseif perc <= 80 then
            new_img = beautiful.bat_4
        else
            new_img = beautiful.bat_5
        end

        -- If charging
        if bat_now.ac_status == 1 then
            new_img = beautiful.bat_plug
            new_txt = perc.."%"
        end

        -- If loading
        if bat_now.ac_status == "N/A" and perc == 0 then
            new_img = beautiful.bat_5
            new_txt = "---"
        end

        icon_battery_dynamyc:set_image(gears.color.recolor_image(new_img, color["red300"]))
        widget_battery_perc:set_markup('<span color="'.. color["red300"] ..'">' .. new_txt .. '</span>')
    end
})

return {
    ["icon"] = icon_battery_dynamyc,
    ["perc"] = widget_battery_perc
}