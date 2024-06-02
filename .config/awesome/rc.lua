--[[
 _____ __ _ __ _____ _____ _____ _______ _____
|     |  | |  |  ___|  ___|     |       |  ___|
|  -  |  | |  |  ___|___  |  |  |  | |  |  ___|
|__|__|_______|_____|_____|_____|__|_|__|_____|
=============== @author cufta22 ===============
========= https://github.com/cufta22 ==========
--]]

-- awesome_mode: api-level=4:screen=on

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local menubar = require("menubar")
local awful = require("awful")
require("awful.autofocus")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("config.variables")
modkey = RC.vars.modkey
menubar.utils.terminal = RC.vars.terminal

-- Theme
require("ui.theme")

-- Config
require("config.layouts")
require("config.bindings-mouse")
require("config.bindings-keys")
require("config.rules")

-- UI
require("ui.bar")
require("ui.solarcycle")

require("ui.wallpaper")
require("ui.notifications")
-- require("ui.titlebar")

-- Create a laucher widget and a main menu
local menu = require("ui.menu")
RC.mainmenu = awful.menu({ items = menu() }) -- Used in globalkeys

-- Signals
require("config.signals")

-- Autostart applications
awful.spawn.with_shell("~/dotfiles/.config/awesome/scripts/autostart.sh")