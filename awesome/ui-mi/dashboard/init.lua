
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- call opening listeners
require("ui-mi.dashboard.listener")

local content = require("ui-mi.dashboard.content")

awful.screen.connect_for_each_screen(function (s)
    s.dashboard = {}

    s.dashboard.popup = wibox {
        screen = s,
        ontop = true,
        visible = false,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        width = 530,
        height = s.geometry.height - beautiful.useless_gap * 4,
        x = s.geometry.x + beautiful.useless_gap * 2 + beautiful.ui_bar_width,
        y = s.geometry.y + beautiful.useless_gap * 2,
    }

    s.dashboard.popup:setup(content)

    local self = s.dashboard.popup

    function s.dashboard.open()
        self.visible = true
    end

    function s.dashboard.hide()
        self.visible = false
    end

    function s.dashboard.toggle()
        if self.visible then
            s.dashboard.hide()
        else
            s.dashboard.open()
        end
    end
end)