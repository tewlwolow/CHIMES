-- CHIMES - Communal Harmonic Immersive Music Extension System  --
--------------------------------------------------------------------------------------

local metadata = require("tew.CHIMES.metadata")
local version = metadata.version
local ErrorMessage = require("tew.CHIMES.ui.ErrorMessage")
local schemaErrors = require("tew.CHIMES.util.schemaErrors")

local function init()
    mwse.log("[CHIMES] Version "..version.." initialised.")
end

-- Registers MCM menu --
event.register("modConfigReady", function()
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\ui\\mcm.lua")
end)

local function checkForErrors()
    if not table.empty(schemaErrors) then
        ErrorMessage.show(schemaErrors)
    end
end

event.register (tes3.event.uiActivated, checkForErrors, { filter = "MenuOptions", doOnce = true, })


event.register("initialized", init)