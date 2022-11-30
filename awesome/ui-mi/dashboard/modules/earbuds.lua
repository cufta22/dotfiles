local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local dpi = beautiful.xresources.apply_dpi
local util = require("ui-mi.dashboard.modules.util")
local color = require("ui-mi.theme.colors")

local buds_labels = require("ui-mi.dashboard.modules.earbuds-labels")
local buds_data = {
    ["RedmiBuds4Pro"]     = beautiful.redmi_buds_4_pro,
    ["RedmiBuds4"]         = beautiful.redmi_buds_4,
    ["RedmiBuds3Pro"]     = beautiful.redmi_buds_3_pro,
    ["RedmiBuds3Lite"]    = beautiful.redmi_buds_3_lite,

    ["XiaomiBuds4Pro"]    = beautiful.xiaomi_buds_4_pro,
    ["XiaomiBuds3TPro"]   = beautiful.xiaomi_buds_3t_pro,
    ["XiaomiBuds3"]        = beautiful.xiaomi_buds_3,
    ["XiaomiFlipBudsPro"]  = beautiful.xiaomi_flipbuds_pro
}

-- dynamic content
local earbuds_icon = wibox.widget{
    image = buds_data["XiaomiBuds4Pro"],
    forced_height = 180,
    -- align = 'center',
    -- valign = 'center',
    widget = wibox.widget.imagebox,
}

local earbuds_text = wibox.widget{
    markup = 'Not connected',
    align = 'center',
    font = RC.vars.font.."18",
    widget = wibox.widget.textbox,
}

local earbuds_widget = wibox.widget{
    {
        {
            {
                earbuds_icon,

                halign = 'center',
                valign = 'center',
                layout = wibox.container.place,
            },

            top = beautiful.useless_gap * 3,
            bottom = beautiful.useless_gap * 1,
            widget = wibox.container.margin,
        },
        {
            earbuds_text,

            bottom = beautiful.useless_gap * 4,
            widget = wibox.container.margin,
        },

        layout = wibox.layout.align.vertical,
    },
    shape = helpers.mkroundedrect(),
    bg = color["gray900"],

    widget = wibox.widget.background
}

awesome.connect_signal('bluetooth::enabled', function (enabled)
    earbuds_widget.visible = enabled

    awful.spawn.easy_async_with_shell("bluetoothctl info | grep 'Name' | cut -d ' ' -f2-", function (name)
        local trimmed_name = helpers.trim(name)
        local new_name = buds_labels[trimmed_name]

        earbuds_icon:set_image(buds_data[trimmed_name])
        earbuds_text:set_markup_silently(new_name and new_name or "Not connected")

        earbuds_icon.visible = new_name and true or false
    end)
end)

return earbuds_widget