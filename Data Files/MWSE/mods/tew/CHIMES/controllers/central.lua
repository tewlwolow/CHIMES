local central = {}

local resolver = require("tew.CHIMES.util.resolver")

central.previousFolder = nil
central.currentFolder = nil

function central.check()
	local controller = resolver.resolveController()
	if controller then
		debug.log(controller.item)
		central.currentFolder = controller.folder
		debug.log()
	end
end

return central