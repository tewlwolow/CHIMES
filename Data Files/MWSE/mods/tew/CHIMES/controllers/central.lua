local central = {}

local resolver = require("tew.CHIMES.util.resolver")

local previousFolder, currentFolder

function central.check()
	local service = resolver.resolveService()
	if service then
		debug.log(service.folder)
	end
end

return central