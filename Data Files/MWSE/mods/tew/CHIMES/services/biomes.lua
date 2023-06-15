local biomes = {}

local catalogue = require("tew.CHIMES.cache.catalogue")

biomes.folder = nil

function biomes.isRelevant()
	local cell = tes3.player.cell
	if not cell then return end
	local region = cell.region
	if not region then return end
	local regionName = region.name
	if not regionName then regionName = "Wilderness" end

	local charts = catalogue.CHIMESBiomesChart
	for _, chart in ipairs(charts) do
		for _, item in ipairs(chart.data) do
			for _, str in ipairs(item.strings) do
				if str == regionName then
					biomes.folder = item.folder
					return true
				end
			end
		end
	end
end

return biomes