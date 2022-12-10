local awful = require("awful")
local gears = require("gears")
local helpers = require("helpers")

local fs = gears.filesystem

local mic = {}

mic.script_path = fs.get_configuration_dir() .. 'scripts/mic.sh'

function mic.re_emit_muted_signal ()
    awful.spawn.easy_async_with_shell(mic.script_path .. " state", function (out)
        awesome.emit_signal('mic::muted', helpers.trim(out) == 'no')
    end)
end

function mic.toggle_active ()
    awful.spawn.easy_async_with_shell(mic.script_path .. " toggle", function ()
        mic.re_emit_muted_signal()
    end)
end

gears.timer {
    timeout = 3,
    call_now = true,
    autostart = true,
    callback = mic.re_emit_muted_signal,
}

return mic