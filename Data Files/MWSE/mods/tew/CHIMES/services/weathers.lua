local weathers = {}

local catalogue = require("tew.CHIMES.cache.catalogue")

weathers.folder = nil

function weathers.isRelevant()
	local currentWeather = tes3.getCurrentWeather().name:lower()
	local wc = tes3.worldController.weatherController
	if not wc then return end
	local nextWeather = wc.nextWeather and wc.nextWeather.name:lower()
	local relevantWeather = nextWeather or currentWeather

	local charts = catalogue.CHIMESWeathersChart
	for _, chart in ipairs(charts) do
		for _, item in ipairs(chart.data) do
			if item.disable then
				if item.id == relevantWeather then
					weathers.folder = "tew\\CHIMES\\Special\\silence"
					return true
				end
			else
				if item.id == relevantWeather then
					weathers.folder = item.folder
					return true
				end
			end
		end
	end
end

return weathers