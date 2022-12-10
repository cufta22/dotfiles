local gears = require("gears")
local awful = require("awful")
local helpers = require("helpers")

local fs = gears.filesystem

local redshift = {}

redshift.script_adjust = fs.get_configuration_dir() .. 'scripts/redshift-adjust.sh'
redshift.script_off = fs.get_configuration_dir() .. 'scripts/redshift-off.sh'

-- You can go even lover if you want
local redshift_amount = 4000

function redshift.re_emit_active_signal ()
    awful.spawn.easy_async_with_shell(redshift.script_adjust .. ' -p1', function (out)
        awesome.emit_signal('redshift::active', helpers.trim(out) == "")
    end)
end

function redshift.toggle_active ()
    awful.spawn.easy_async_with_shell(redshift.script_adjust .. ' -p1', function (out)
        local toggle_script = out == "" and redshift.script_adjust .. ' -s1 ' .. redshift_amount or redshift.script_off

        awful.spawn.easy_async_with_shell(toggle_script, function ()
            redshift.re_emit_active_signal()
        end)
    end)
end

gears.timer {
    timeout = 3,
    call_now = true,
    autostart = true,
    callback = redshift.re_emit_active_signal,
}

return redshift