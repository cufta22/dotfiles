local gears = require 'gears'
local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local naughty = require 'naughty'
local dpi = beautiful.xresources.apply_dpi

local helpers = {}

-- create a rounded rect using a custom radius
function helpers.mkroundedrect(radius)
    radius = radius or dpi(7)
    return function (cr, w, h)
        return gears.shape.rounded_rect(cr, w, h, radius)
    end
end


-- colorize a text using pango markup
function helpers.get_colorized_markup(content, fg)
    fg = fg or beautiful.blue
    content = content or ''

    return '<span foreground="' .. fg .. '">' .. content .. '</span>'
end


-- trim strings
function helpers.trim(input)
    local result = input:gsub("%s+", "")
    return string.gsub(result, "%s+", "")
end


-- capitalize a string
function helpers.capitalize (txt)
    return string.upper(string.sub(txt, 1, 1))
        .. string.sub(txt, 2, #txt)
end


return helpers