-- CHIMES - Communal Harmonic Immersive Music Extension System  --
--------------------------------------------------------------------------------------

-- Make sure we have all i18n data beforehand
dofile("tew.CHIMES.i18n.init")

local metadata = require("tew.CHIMES.metadata")
local version = metadata.version

local function init()
    mwse.log("[CHIMES] Version "..version.." initialised.")
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\interface.lua")
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\controller.lua")
end

-- Registers MCM menu --
event.register("modConfigReady", function()
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\mcm.lua")
end)


event.register("initialized", init)