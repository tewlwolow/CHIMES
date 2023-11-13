local weathers = {}

local catalogue = require("tew.CHIMES.cache.catalogue")

weathers.item = nil

function weathers.isRelevant()
	local cell = tes3.player.cell
	if not cell then return end
	if not cell.isOrBehavesAsExterior then return end

	local currentWeather = tes3.getCurrentWeather().name:lower()
	local wc = tes3.worldController.weatherController
	if not wc then return end
	local nextWeather = wc.nextWeather and wc.nextWeather.name:lower()
	local relevantWeather = nextWeather or currentWeather

	local charts = catalogue.CHIMESWeathersChart
	for _, chart in ipairs(charts) do
		for _, item in ipairs(chart.data) do
			if item.id:lower() == relevantWeather then
				weathers.item = item
				return true
			end
		end
	end
end

return weathers
