local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local color = require("ui.theme.colors")
local naughty = require("naughty")

local fs = gears.filesystem

-- Music
local music_values = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 }
local graph_capacity = 8

local music_graph = wibox.widget{
    step_spacing     = 2,
    step_width       = 2,
    border_width     = 0,
    background_color = color["base"],
    color            = color["green"],
    max_value        = 20,
    min_value        = 0,
    forced_width     = 36,
    capacity         = graph_capacity,
    widget           = wibox.widget.graph,
}

local music_icon = wibox.widget{
    image         = nil,
    forced_width  = 28,
    forced_height = 28,
    valign        = "center",
    align         = "center",
    widget        = wibox.widget.imagebox,
}

local music_widget = awful.widget.watch(
    fs.get_configuration_dir() .. 'scripts/music.sh',
    0.3, -- .3 sec
    function(widget, stdout)
        if string.len(stdout) < 2 then
            music_icon:set_image(nil)
            music_graph:add_value(0)
        else
            music_icon:set_image(beautiful.song_on)
            for i = 1, graph_capacity, 1 do
                music_graph:add_value(music_values[ math.random( #music_values ) ])
            end
        end

        widget:set_markup(stdout)
    end,
    wibox.widget{
        markup = '',
        font   = RC.vars.font.."10",
        valign = "center",
        halign = "center",
        widget = wibox.widget.textbox,
    }
)

return {
    ["graph"] = music_graph,
    ["icon"] = music_icon,
    ["name"] = music_widget
}