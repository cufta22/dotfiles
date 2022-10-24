local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful") -- for awesome.icon

local M = {}  -- menu
local _M = {} -- module

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

M.awesome = {
  { "hotkeys",         function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual",          RC.vars.terminal .. " -e man awesome" },
  { "edit config",     RC.vars.editor_gui .. " " .. awful.util.getdir("config") },
  { "restart awesome", awesome.restart },
  { "quit awesome",    function() awesome.quit() end }
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()

  -- Main Menu
  local menu_items = {
    { "awesome", M.awesome, beautiful.awesome_subicon },
    { "terminal", RC.vars.terminal },
    { "logout", "pkill -KILL -u " .. RC.vars.username },
    { "shutdown", "shutdown now" },

  }

  return menu_items
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
