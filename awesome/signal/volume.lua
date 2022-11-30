local gears = require 'gears'
local awful = require 'awful'
local helpers = require 'helpers'

local volume = {}

function volume.re_emit_muted_signal ()
    awful.spawn.easy_async_with_shell("amixer get Master", function (out)
        local vol_status = string.match(out, ".*%[([%l]*)")

        awesome.emit_signal('volume::muted', helpers.trim(vol_status) == 'on')
    end)
end

function volume.toggle_muted ()
    awful.spawn.easy_async_with_shell("amixer set Master toggle", function ()
        volume.re_emit_muted_signal()
    end)
end

gears.timer {
    timeout = 3,
    call_now = true,
    autostart = true,
    callback = volume.re_emit_muted_signal,
}

return volume