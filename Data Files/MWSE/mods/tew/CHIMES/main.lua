-- CHIMES - Communal Harmonic Immersive Music Extension System  --
--------------------------------------------------------------------------------------

local metadata = toml.loadMetadata("CHIMES")
local common = require("tew.CHIMES.util.common")

local errorMessage
local schemaErrors

local function init()
    if not (metadata) then
		common.metadataMissing()
    else
        mwse.log("[" .. metadata.package.name .."] Version " .. metadata.package.version .. " initialised.")
	end
end

if (metadata) then
    errorMessage = require("tew.CHIMES.ui.errorMessage")
    schemaErrors = require("tew.CHIMES.cache.schemaErrors")

    local function checkForErrors()
        if not table.empty(schemaErrors) then
            errorMessage.show(schemaErrors)
        end
    end

    -- Registers MCM menu --
    event.register(tes3.event.modConfigReady, function()
        dofile("Data Files\\MWSE\\mods\\tew\\CHIMES\\ui\\mcm.lua")
    end)

    event.register (tes3.event.uiActivated, checkForErrors, { filter = "MenuOptions", doOnce = true, })
end

event.register(tes3.event.initialized, init)