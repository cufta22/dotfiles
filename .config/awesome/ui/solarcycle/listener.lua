local awful = require("awful")

local function _()
    return awful.screen.focused().solarcycle
end

awesome.connect_signal('solarcycle::toggle', function ()
    _().toggle()
end)

awesome.connect_signal('solarcycle::visibility', function (v)
    if v then
        _().show()
    else
        _().hide()
    end
end)