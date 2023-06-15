local interiors = {}

local catalogue = require("tew.CHIMES.cache.catalogue")
local cellParser = require("tew.CHIMES.util.cellParser")

interiors.folder = nil

function interiors.isRelevant()
	local cell = tes3.player.cell
	if not cell then return end

	local charts = catalogue.CHIMESInteriorsChart
	for _, chart in ipairs(charts) do
		for _, item in ipairs(chart.data) do
			local folder = cellParser.getCellType(item, cell)
			if folder then
				interiors.folder = folder
				return true
			end
		end
	end
end

return interiors