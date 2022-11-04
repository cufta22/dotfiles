local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local helpers = require "helpers"

local color = require("ui-cat.theme.colors")

local dpi = beautiful.xresources.apply_dpi

require 'ui-cat.powermenu.listener'

local username = wibox.widget {
    markup = '...',
    align = 'center',
    font = beautiful.font .. ' 20',
    widget = wibox.widget.textbox,
}

awful.spawn.easy_async_with_shell('whoami', function (whoami)
    username:set_markup_silently('Hey ' ..
        helpers.get_colorized_markup(helpers.capitalize(
            helpers.trim(whoami)
        ), color["blue"])
    .. '!')
end)

local function make_powerbutton (opts)
    local button = wibox.widget {
        {
            wibox.widget {
                image = gears.color.recolor_image(opts.image, opts.color),
                forced_width = 50,
                forced_height = 50,
                align  = "center",
                widget = wibox.widget.imagebox,
            },
            top = dpi(20),
            bottom = dpi(20),
            left = dpi(20),
            right = dpi(20),
            widget = wibox.container.margin,
        },
        widget = wibox.container.background,
        bg = color["base"],
        shape = gears.shape.circle,
    }

    -- add hover support just when background is bg_lighter
    -- if opts.bg == beautiful.bg_lighter then
    --     helpers.add_hover(button, beautiful.bg_lighter, beautiful.light_black)
    -- end

    button:add_button(awful.button({}, 1, function ()
        if opts.onclick then
            opts.onclick()
        end
    end))

    return button
end

local powerbuttons = wibox.widget {
    make_powerbutton {
        color = color["blue"],
        image = beautiful.powermenu_1,
        onclick = function ()
            awful.spawn.with_shell('doas poweroff')
        end,
    },
    make_powerbutton {
        color = color["red"],
        image = beautiful.powermenu_2,
        onclick = function ()
            awful.spawn.with_shell('doas reboot')
        end
    },
    make_powerbutton {
        color = color["peach"],
        image = beautiful.powermenu_3,
        onclick = function ()
            awesome.emit_signal('powermenu::toggle')
            awful.spawn.with_shell('i3lock-fancy')
        end
    },
    make_powerbutton {
        color = color["yellow"],
        image = beautiful.powermenu_4,
        onclick = function ()
            awful.spawn.with_shell('pkill awesome')
        end
    },
    spacing = dpi(18),
    layout = wibox.layout.fixed.horizontal,
}

awful.screen.connect_for_each_screen(function (s)
    s.powermenu = {}

    s.powermenu.widget = wibox.widget {
        {
            {
                markup = '',
                widget = wibox.widget.textbox,
            },
            bg = '#000000',
            widget = wibox.container.background,
            opacity = 0.12
        },
        {
            {
                {
                    {
                        {
                            image = beautiful.powermenu_main,
                            forced_height = 128,
                            forced_width = 128,
                            halign = 'center',
                            clip_shape = gears.shape.circle,
                            widget = wibox.widget.imagebox,
                        },
                        {
                            username,
                            {
                                markup = 'What do you want to do?',
                                align = 'center',
                                widget = wibox.widget.textbox,
                            },
                            spacing = dpi(2),
                            layout = wibox.layout.fixed.vertical,
                        },
                        {
                            powerbuttons,
                            widget = wibox.container.margin,
                            top = dpi(10),
                        },
                        spacing = dpi(7),
                        layout = wibox.layout.fixed.vertical,
                    },
                    margins = dpi(12),
                    widget = wibox.container.margin,
                },
                fg = color["text"],
                shape = helpers.mkroundedrect(),
                widget = wibox.container.background,
            },
            halign = 'center',
            valign = 'center',
            widget = wibox.container.margin,
            layout = wibox.container.place,
        },
        layout = wibox.layout.stack,
    }

    s.powermenu.splash = wibox {
        widget = s.powermenu.widget,
        screen = s,
        type = 'splash',
        visible = false,
        ontop = true,
        bg = color["crust"] .. "66",
        height = s.geometry.height,
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y,
    }

    local self = s.powermenu.splash

    function s.powermenu.toggle ()
        if self.visible then
            s.powermenu.hide()
        else
            s.powermenu.open()
        end
    end

    function s.powermenu.open ()
        self.visible = true
    end

    function s.powermenu.hide ()
        self.visible = false
    end
end)
