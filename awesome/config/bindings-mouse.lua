local awful = require "awful"

awful.mouse.append_global_mousebindings {
    awful.button({ }, 3, function () RC.mainmenu:toggle() end),   -- Right click menu
    -- awful.button({ }, 4, awful.tag.viewnext),                    -- Scroll to change tag
    -- awful.button({ }, 5, awful.tag.viewprev)                     -- Scroll to change tag
}

client.connect_signal("request::default_mousebindings", function ()
    awful.mouse.append_client_mousebindings {
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move" }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize" }
        end)
    }
end)


