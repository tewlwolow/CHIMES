local resolver = {}

local priorityPath = "config\\CHIMES\\priority"

resolver.services = {
	CHIMESBiomesChart = require("tew.CHIMES.services.biomes"),
	CHIMESExploreChart = require("tew.CHIMES.services.explore"),
	CHIMESExteriorsChart = require("tew.CHIMES.services.exteriors"),
	CHIMESInteriorsChart = require("tew.CHIMES.services.interiors"),
	CHIMESTavernsChart = require("tew.CHIMES.services.taverns"),
	CHIMESWeathersChart = require("tew.CHIMES.services.weathers"),
}

function resolver.loadPriority()
	return json.loadfile(priorityPath)
end

function resolver.resolveService()
	local priority = resolver.loadPriority()
	assert(priority)

	for _, chart in ipairs(priority) do
		local service = resolver.services[chart.name]
		local relevant = service.isRelevant()

		if relevant then
			return service
		end
	end
end

return resolver