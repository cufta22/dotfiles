local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local color = require("ui.theme.colors")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local tags = {
    [1] = "1",
    [2] = "1",
    [3] = "3",
    [4] = "1",
    [5] = "2",
    [6] = "2",
    [7] = "3",
    [8] = "1",
    [9] = "2",
}

-- Function to update the tags
local update_tags = function(self, c3, index)
	local tagicon = self:get_children_by_id('icon_role')[1]
    local new_icon, new_color = beautiful.tag_2, color['crust']

    if tags[index] == "1" then
        new_icon = beautiful.tag_1
    elseif tags[index] == "2" then
        new_icon = beautiful.tag_2
    else
        new_icon = beautiful.tag_3
	end

    if c3.selected then
        new_color = color['peach']
    elseif #c3:clients() > 0 then
        new_color = color['blue']
    else
        new_color = color['crust']
    end

    tagicon.image = gears.color.recolor_image(new_icon, new_color)
end

local get_taglist = function(s)
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            spacing = 4,
            layout = wibox.layout.fixed.horizontal,
        },
        style = {
            shape = gears.shape.rectangle,
        },
        buttons = gears.table.join(
            awful.button({}, 1, function (t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
            awful.button({}, 4, function (t) awful.tag.viewprev(t.screen) end),
            awful.button({}, 5, function (t) awful.tag.viewnext(t.screen) end)
        ),
        widget_template = {
            {
                {
                    id = 'icon_role',
                    image = beautiful.tag_1,
                    valign = 'center',
                    halign = 'center',
                    widget = wibox.widget.imagebox,
                },
                top  = 10,
                bottom = 10,
                left = 0,
                right = 0,
                widget = wibox.container.margin
            },
            widget = wibox.container.background,
            shape = gears.shape.rectangle,

            create_callback = function(self, c3, index) update_tags(self, c3, index) end,

            update_callback = function(self, c3, index) update_tags(self, c3, index) end
        }
    }
end

return get_taglist