local wibox = require("wibox")
local gears = require("gears")
local color = require("ui.theme.colors")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local H = {}

H.spacer = wibox.widget.textbox(" ")
H.spacerL = wibox.widget.textbox("   ")
H.spacerXL = wibox.widget.textbox("     ")

H.widget_margin = function ( margin_left, margin_right, margin_top, margin_bottom, widget_1, widget_2 )
  return wibox.container.margin(
    wibox.widget { widget_1, widget_2, layout = wibox.layout.align.horizontal },
    margin_left,
    margin_right,
    margin_top,
    margin_bottom
  )
end

H.widget_wrapper = function ( margin_left, margin_right, margin_top, margin_bottom, widget )
  return wibox.widget {
    {
      {
        widget,
        left   = 12,
        top    = 4,
        bottom = 4,
        right  = 12,
        widget = wibox.container.margin,
      },
      bg            = color["base"],
      shape         = gears.shape.rounded_rect,
      shape_clip    = true,
      shape_border_width    = 1,
      shape_border_color    = color["surface0"],
      widget        = wibox.container.background,
    },
    left   = margin_left,
    top    = margin_top,
    bottom = margin_bottom,
    right  = margin_right,
    widget = wibox.container.margin,
  }
end

return H