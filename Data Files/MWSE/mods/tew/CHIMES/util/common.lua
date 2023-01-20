local metadata = require("tew.CHIMES.metadata")
local version = metadata.version

local config = require("tew.CHIMES.config")
local debugLogOn = config.debugLogOn

local common = {}

function common.log(message)
	if debugLogOn then
		local info = debug.getinfo(2, "Sl")
		local module = info.short_src:match("^.+\\(.+).lua$")
		local prepend = ("[CHIMES.%s.%s:%s]:"):format(version, module, info.currentline)
		local aligned = ("%-36s"):format(prepend)
		mwse.log(aligned .. " -- " .. string.format("%s", message))
	end
end

return common