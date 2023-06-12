
local config = require("tew.CHIMES.options.config")
local debugLogOn = config.debugLogOn

local common = {}

common.classNames = {
	CHIMESBiomesChart = "Biomes",
	CHIMESExploreChart = "Explore",
	CHIMESExteriorsChart = "Exteriors",
	CHIMESInteriorsChart = "Interiors",
	CHIMESTavernsChart = "Taverns",
	CHIMESWeathersChart = "Weathers"
}

-- Basic logger
function common.log(message)
	local metadata = toml.loadMetadata("CHIMES")
	local version = metadata.package.version
	if debugLogOn then
		local info = debug.getinfo(2, "Sl")
		local module = info.short_src:match("^.+\\(.+).lua$")
		local prepend = ("[CHIMES.%s.%s:%s]:"):format(version, module, info.currentline)
		local aligned = ("%-36s"):format(prepend)
		mwse.log(aligned .. " -- " .. string.format("%s", message))
	end
end

-- Ensure missing metadata file is caught --
function common.metadataMissing()
	local errorMessage = "Error! CHIMES-metadata.toml file is missing. Please install."
	tes3.messageBox{
		message = errorMessage
	}
	error(errorMessage)
end

return common