local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local color = require("ui-mi.theme.colors")
local utils = require("ui-mi.bar.utils")


local widgets = {
  logo           = require("ui-mi.bar.modules.logo"),

  get_taglist    = require("ui-mi.bar.modules.tags"),
  get_tasklist   = require("ui-mi.bar.modules.tasks"),
  get_layoutbox  = require("ui-mi.bar.modules.layoutbox"),

  clock          = require("ui-mi.bar.modules.clock"),

  dashboard      = require("ui-mi.bar.modules.dashboard"),

  systray        = require("ui-mi.bar.modules.systray")
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Wibar

awful.screen.connect_for_each_screen(function(s)
  -- Tags
  awful.tag({'', '', '', '', ''}, s, awful.layout.layouts[1] )

  -- Create the wibox
  s.wibox = awful.wibar({
    position = "left",
    type     = "toolbar",
    screen   = s,
    width    = beautiful.ui_bar_width,
    height   = s.geometry.height - beautiful.useless_gap * 4,
    bg       = color["gray850"],
    shape    = helpers.mkroundedrect(beautiful.useless_gap)
  })

  -- Gap at the left
  s.wibox.x = beautiful.useless_gap

  -- Add widgets to the wibox
  s.wibox:setup {
    layout = wibox.layout.align.vertical,

    { -- Left widgets
      layout = wibox.layout.fixed.vertical,

      utils.widget_margin(10, 10, 20, 30, widgets.logo),
    },

    -- nil, -- Nothing in the middle

    {-- Middle widget
      layout = wibox.container.place,
      align = "center",

      utils.widget_margin(0,  0,  0,  0, widgets.get_taglist(s)),
    },


    { -- Right widgets
      layout = wibox.layout.fixed.vertical,

      utils.widget_margin(10, 10,  0,  5, widgets.dashboard),

      utils.widget_margin(10, 10,  5, 10, widgets.systray),

      utils.widget_margin( 0,  0,  0,  0, widgets.clock),

      utils.widget_margin(10, 10, 20, 20, widgets.get_layoutbox(s)),
    },
  }
end)

