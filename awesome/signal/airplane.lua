local gears = require("gears")
local naughty = require("naughty")

local airplane = {}

function airplane.re_emit_muted_signal ()
    awesome.emit_signal('airplane::active', not naughty.is_suspended())
end

function airplane.toggle_active ()
    if naughty.is_suspended() then
		naughty.resume()
	else
		naughty.suspend()
	end

    airplane.re_emit_muted_signal()
end

gears.timer {
    timeout = 3,
    call_now = true,
    autostart = true,
    callback = airplane.re_emit_muted_signal,
}

return airplane