local explore = {}

local catalogue = require("tew.CHIMES.cache.catalogue")

explore.item = nil

function explore.isRelevant()
	local charts = catalogue.CHIMESExploreChart
	for _, chart in ipairs(charts) do
		explore.item = chart.data[1]
		return true
	end
end

return explore
