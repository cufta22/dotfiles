local gears = require 'gears'
local awful = require 'awful'

local fs = gears.filesystem

local bedtime = {}

bedtime.script_adjust = fs.get_configuration_dir() .. 'scripts/redshift-adjust.sh'
bedtime.script_off = fs.get_configuration_dir() .. 'scripts/bedtime-off.sh'

-- You can go even lover if you want
local bedtime_amount = 3500

function bedtime.re_emit_active_signal ()
    awful.spawn.easy_async_with_shell(bedtime.script_adjust .. ' -p2', function (out)
        awesome.emit_signal('bedtime::active', out == "")
    end)
end

function bedtime.toggle_active ()
    awful.spawn.easy_async_with_shell(bedtime.script_adjust .. ' -p2', function (out)
        if naughty.is_suspended() then
            naughty.resume()
        else
            naughty.suspend()
        end
        
        local toggle_script = out == "" and bedtime.script_adjust .. ' -s2 ' .. bedtime_amount or bedtime.script_off

        awful.spawn.easy_async_with_shell(toggle_script, function ()
            bedtime.re_emit_active_signal()
        end)
    end)
end

gears.timer {
    timeout = 3,
    call_now = true,
    autostart = true,
    callback = bedtime.re_emit_active_signal,
}

return bedtime