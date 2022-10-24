local beautiful = require("beautiful")
local lain = require("lain")
local wibox = require("wibox")
local gears = require("gears")
local color = require("theme.colors")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Volume

local icon_volume_dynamyc = wibox.widget{
    image        = gears.color.recolor_image(beautiful.vol, color["blue"]),
    forced_width = 22,
    valign       = "center",
    align        = "center",
    widget       = wibox.widget.imagebox,
}

local widget_volume = lain.widget.alsa({
    timeout = 2,
    settings = function()

        local new_img = gears.color.recolor_image(beautiful.vol, color["blue"])
        local new_txt = '<span color="'.. color["sapphire"] ..'">' .. "  " .. volume_now.level .. "% " .. '</span>'

        if volume_now.status == "off" then
            new_txt = '<span color="'.. color["green"] ..'">' .. "   " ..  "- - -   " .. '</span>'
            new_img = gears.color.recolor_image(beautiful.vol_mute, color["green"])
        end

        icon_volume_dynamyc:set_image(new_img)
        widget:set_markup(new_txt)

    end
})

return {
    ["icon"] = icon_volume_dynamyc,
    ["perc"] = widget_volume
}