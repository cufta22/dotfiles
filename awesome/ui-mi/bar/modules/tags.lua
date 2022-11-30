local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local color = require("ui-mi.theme.colors")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Function to update the tags
local update_tags = function(self, c3, index)
	local tagicon = self:get_children_by_id('icon_role')[1]
    local new_icon = beautiful.tag_1
    local new_color = color['gray600']

    -- if #c3:clients() > 0 then
    --     new_icon = beautiful.tag_clients
    -- else
    --     new_icon = beautiful.tag_normal
	-- end

    if c3.selected then
        new_color = color['mi']
        new_icon = beautiful.tag_2
    end

    tagicon.image = gears.color.recolor_image(new_icon, new_color)
end

local get_taglist = function(s)
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
            spacing = 4,
            layout = wibox.layout.fixed.vertical,
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
                    image = beautiful.tag_selected,
                    valign = 'center',
                    halign = 'center',
                    widget = wibox.widget.imagebox,
                },
                top  = 2,
                bottom = 2,
                left = 15,
                right = 15,
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
