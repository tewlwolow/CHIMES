local towns = {}

local catalogue = require("tew.CHIMES.cache.catalogue")
local cellParser = require("tew.CHIMES.util.cellParser")

towns.item = nil

function towns.isRelevant()
	local cell = tes3.player.cell
	if not cell then return end

	local charts = catalogue.CHIMESTownsChart
	for _, chart in ipairs(charts) do
		for _, item in ipairs(chart.data) do
			local valid = cellParser.getTown(item, cell)
			if valid then
				towns.item = item
				return true
			end
		end
	end
end

return towns
