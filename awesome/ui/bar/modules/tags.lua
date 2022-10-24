local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local color = require('theme.colors')

local tag_colors = {
    ['1'] = color['peach'],
    ['2'] = color['mauve'],
    ['3'] = color['red'],
    ['4'] = color['blue'],
    ['5'] = color['green'],
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Function to update the tags
local update_tags = function(self, c3, index)
	local tagicon = self:get_children_by_id('icon_role')[1]
    local new_icon = ""

    if c3.selected then
        new_icon = beautiful.tag_selected
    elseif #c3:clients() > 0 then
        new_icon = beautiful.tag_clients
    else
        new_icon = beautiful.tag_normal
	end

    tagicon.image = gears.color.recolor_image(new_icon, tag_colors[tostring(index)])
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
            shape = gears.shape.circle,
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
                top  = 6,
                bottom = 6,
                widget = wibox.container.margin
            },
            widget = wibox.container.background,
            shape = gears.shape.circle,

            create_callback = function(self, c3, index) update_tags(self, c3, index) end,

            update_callback = function(self, c3, index) update_tags(self, c3, index) end
        }
    }
end

return get_taglist
