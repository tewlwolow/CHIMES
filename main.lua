-- CHIMES - Communal Harmonic Immersive Music Extension System  --
--------------------------------------------------------------------------------------

local metadata = require("tew.CHIMES.metadata")
local version = metadata.version
local errorMessage = require("tew.CHIMES.ui.errorMessage")
local schemaErrors = require("tew.CHIMES.util.schemaErrors")

local function init()
    mwse.log("[CHIMES] Version "..version.." initialised.")
end

local function checkForErrors()
    if not table.empty(schemaErrors) then
        errorMessage.show(schemaErrors)
    end
end

-- Registers MCM menu --
event.register("modConfigReady", function()
    dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\ui\\mcm.lua")
end)

event.register (tes3.event.uiActivated, checkForErrors, { filter = "MenuOptions", doOnce = true, })
event.register("initialized", init)