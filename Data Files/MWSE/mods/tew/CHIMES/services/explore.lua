local explore = {}

local catalogue = require("tew.CHIMES.cache.catalogue")

explore.folder = nil

function explore.isRelevant()
	local charts = catalogue.CHIMESExploreChart
	for _, chart in ipairs(charts) do
		explore.folder = chart.data[1].folder
		return true
	end
end

return explore