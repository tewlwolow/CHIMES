local resolver = {}

local priorityPath = "config\\CHIMES\\priority"

resolver.controllers = {
	CHIMESBiomesChart = require("tew.CHIMES.controllers.biomes"),
	CHIMESExploreChart = require("tew.CHIMES.controllers.explore"),
	CHIMESInteriorsChart = require("tew.CHIMES.controllers.interiors"),
	CHIMESTavernsChart = require("tew.CHIMES.controllers.taverns"),
	CHIMESWeathersChart = require("tew.CHIMES.controllers.weathers"),
	CHIMESTownsChart = require("tew.CHIMES.controllers.towns"),
}

function resolver.loadPriority()
	return json.loadfile(priorityPath)
end

function resolver.resolveController()
	local priority = resolver.loadPriority()
	assert(priority)

	for _, chart in ipairs(priority) do
		local controller = resolver.controllers[chart.name]
		local relevant = controller.isRelevant()

		if relevant then
			return controller
		end
	end
end

return resolver