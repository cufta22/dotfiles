local gears = require("gears")
local awful = require("awful")

gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function ()
        awful.spawn.easy_async_with_shell("brightnessctl get", function (out)
            local max = RC.vars.max_brightness
            local perc = string.format("%.0f", (out:gsub("%s+", "") / max) * 100)

            awesome.emit_signal('brightness::value', tonumber(perc))
        end)
    end
}

local function set(val)
    awful.spawn('brightnessctl s ' .. tonumber(val) .. "%")
end

return { set = set }