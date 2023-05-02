local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")

local color = require("ui.theme.colors")
local utils = require("ui.bar.utils")

local widgets = {
    get_layoutbox  = require("ui.bar.widgets.layoutbox"),
    get_tasklist    = require("ui.bar.widgets.tasks"),
    get_taglist    = require("ui.bar.widgets.tags"),
    dashboard      = require("ui.bar.widgets.dashboard"),
    systray        = require("ui.bar.widgets.systray"),
    battery        = require("ui.bar.widgets.battery"),
    clock          = require("ui.bar.widgets.clock"),
    music          = require("ui.bar.widgets.music"),
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Wibar

screen.connect_signal("request::desktop_decoration", function(s)
    -- Tags
    awful.tag({'', '', '', '', '', '', '', '', ''}, s, awful.layout.layouts[1] )

    -- Create the wibox
    s.wibox = awful.wibar({
        position = "top",
        type     = "toolbar",
        screen   = s,
        width    = s.geometry.width - beautiful.useless_gap * 4,
        height   = beautiful.bar_height,
        margins = { top = beautiful.useless_gap },
        bg       = color["base"],
        shape    = helpers.mkroundedrect(beautiful.useless_gap)
    })

    -- Add widgets to the wibox
    s.wibox:setup {
        layout = wibox.layout.align.horizontal,

        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,

            utils.widget_margin(20, 20, 8, 8, widgets.battery),

            utils.widget_margin(0, 0, 0, 0, widgets.get_taglist(s)),

            utils.widget_wrapper(20, 20, 5, 5, widgets.get_tasklist(s))
        },

        -- nil, -- Nothing in the middle

        {-- Middle widget
            layout = wibox.container.place,
            align = "center",

            {
                utils.widget_margin(0,   0,  8,  8, widgets.music['graph']),
                -- utils.widget_margin(10,  0,  0,  0, widgets.music['icon']),
                utils.widget_margin(10,  0,  8,  8, widgets.music['name']),

                layout = wibox.layout.fixed.horizontal,
            }
        },


        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,

            utils.widget_wrapper(20, 20, 5, 5, widgets.systray),

            utils.widget_margin( 0, 0, 0, 0, widgets.clock),

            utils.widget_margin(20, 20, 6, 6, widgets.get_layoutbox(s)),
        },
    }
end)