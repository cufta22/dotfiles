
local wibox = require("wibox")
local lain = require("lain")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local H = {}

H.spacer = wibox.widget.textbox(" ")
H.spacerL = wibox.widget.textbox("   ")
H.spacerXL = wibox.widget.textbox("     ")

H.spacerline = wibox.widget.textbox(" | ")

-- Separators lain
local separators  = lain.util.separators
H.arrow_1 = function ( color ) return separators.arrow_right("alpha", color) end
H.arrow_2 = function ( color ) return separators.arrow_right(color, "alpha") end

H.widget_margin = function ( margin_left, margin_right, margin_top, margin_bottom, widget_1, widget_2 )
  return wibox.container.margin(
    wibox.widget { widget_1, widget_2, layout = wibox.layout.align.horizontal },
    margin_left,
    margin_right,
    margin_top,
    margin_bottom
  )
end

return H