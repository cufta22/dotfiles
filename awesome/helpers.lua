---@diagnostic disable: undefined-global
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


-- add transition to background
function helpers.apply_transition(opts)
    opts = opts or {}

    local bg = opts.bg or beautiful.bg_lighter
    local hbg = opts.hbg or beautiful.black

    local element = opts.element
    local prop = opts.prop

    local background = color.color { hex = bg }
    local hover_background = color.color { hex = hbg }

    local transition = color.transition(background, hover_background, color.transition.RGB)

    local fading = rubato.timed {
        duration = 0.30,
    }

    fading:subscribe(function (pos)
        element[prop] = transition(pos / 100).hex
    end)

    return {
        on = function ()
            fading.target = 100
        end,
        off = function ()
            fading.target = 0
        end
    }
end


-- add hover support to wibox.container.background-based elements
function helpers.add_hover(element, bg, hbg)
    local transition = helpers.apply_transition {
        element = element,
        prop    = 'bg',
        bg      = bg,
        hbg     = hbg,
    }

    element:connect_signal('mouse::enter', transition.on)
    element:connect_signal('mouse::leave', transition.off)
end

return helpers