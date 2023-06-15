local exteriors = {}

local catalogue = require("tew.CHIMES.cache.catalogue")
local cellParser = require("tew.CHIMES.util.cellParser")

exteriors.folder = nil

function exteriors.isRelevant()
	local cell = tes3.player.cell
	if not cell then return end

	local charts = catalogue.CHIMESExteriorsChart
	for _, chart in ipairs(charts) do
		for _, item in ipairs(chart.data) do
			local folder = cellParser.getCellType(item, cell)
			if folder then
				exteriors.folder = folder
				return true
			end
		end
	end
end

return exteriors