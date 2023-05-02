local awful = require("awful")

tag.connect_signal("request::default_layouts", function()
    -- Table of layouts to cover with awful.layout.inc, order matters.
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,             -- 1:
        awful.layout.suit.floating,         -- 2:
    })
end)