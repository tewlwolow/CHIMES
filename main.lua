-- CHIMES - Communal Harmonic Immersive Music Extension System  --
--------------------------------------------------------------------------------------

local metadata = require("tew.CHIMES.metadata")
local version = metadata.version

local function init()
    mwse.log("[CHIMES] Version "..version.." initialised.")
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\charts\\biomes.lua")
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\charts\\explore.lua")
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\charts\\exteriors.lua")
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\charts\\interiors.lua")
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\charts\\taverns.lua")
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\charts\\weathers.lua")
end

-- Registers MCM menu --
event.register("modConfigReady", function()
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\ui\\mcm.lua")
end)


event.register("initialized", init)