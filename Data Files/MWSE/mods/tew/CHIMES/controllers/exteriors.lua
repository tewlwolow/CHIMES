local exteriors = {}

local catalogue = require("tew.CHIMES.cache.catalogue")
local cellParser = require("tew.CHIMES.util.cellParser")

exteriors.item = nil

function exteriors.isRelevant()
	local cell = tes3.player.cell
	if not cell then return end
	if not cell.isOrBehavesAsExterior then return end

	local charts = catalogue.CHIMESExteriorsChart
	for _, chart in ipairs(charts) do
		for _, item in ipairs(chart.data) do
			local valid = cellParser.isValidCell(item, cell)
			if valid then
				exteriors.item = item
				return true
			end
		end
	end
end

return exteriors