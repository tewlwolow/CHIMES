local metadata = require("tew.CHIMES.metadata")
local version = metadata.version

local common = {}

function common.log(message)
	mwse.log(string.format("[CHIMES v%s] %s", version, message))
end

return common