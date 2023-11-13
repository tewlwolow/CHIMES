local interiors = {}

local catalogue = require("tew.CHIMES.cache.catalogue")
local cellParser = require("tew.CHIMES.util.cellParser")

interiors.item = nil

function interiors.isRelevant()
	local cell = tes3.player.cell
	if not cell then return end
	if cell.isOrBehavesAsExterior then return end

	local charts = catalogue.CHIMESInteriorsChart
	for _, chart in ipairs(charts) do
		for _, item in ipairs(chart.data) do
			local valid = cellParser.isValidCell(item, cell)
			if valid then
				interiors.item = item
				return true
			end
		end
	end
end

return interiors
