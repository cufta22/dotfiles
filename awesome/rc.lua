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

local awful = require("awful")
local menubar = require("menubar")

RC = {} -- global namespace, on top before require any modules
RC.vars = require("config.variables")
modkey = RC.vars.modkey

-- Notifications
require("config.notifications")

-- Theme
require("theme")

-- Layouts
require("config.layouts")

-- Menu
-- Create a laucher widget and a main menu
local menu = require("ui.menu")
RC.mainmenu = awful.menu({ items = menu() }) -- Used in globalkeys

-- Menubar configuration
menubar.utils.terminal = RC.vars.terminal

-- Mouse and Key bindings
require("config.bindings-mouse")
require("config.bindings-keys")

-- Rules
require("config.rules")

-- UI
require("ui.bar")
require("ui.powermenu")
require("ui.wallpaper")

-- Signals
require("config.signals")

-- Autostart applications
require("config.autostart")
