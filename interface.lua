-- IMPORTS --

local tracks = require("tew.CHIMES.tracks")
local charts = require("tew.CHIMES.charts")
local log = require("tew.CHIMES.common").log
local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")
local errors = i18n("errors")


-------------------------------------------------------------

-- DIRECTORIES --

local CHIMES_DIR = "Data Files\\Music\\CHIMES\\"
local CHARTS_DIR = "Data Files\\MWSE\\mods\\tew\\CHIMES\\charts\\"

-------------------------------------------------------------

-- FUNCTION DEFINITIONS --

-- Validate charts initially --
local function validateCharts()
	log(messages.validateInit)
	for file in lfs.dir(CHARTS_DIR) do
		if not file == "." or not file == ".." then
			if string.endswith(file, ".json") then
				local chart = json.loadfile("mods\\tew\\CHIMES\\charts\\"..string.split(file, ".")[1])
				if not chart.chart then
					error(log(string.format("%s [%s]", errors.noChartNameFound, file)))
				elseif not chart.data then
					error(log(string.format("%s [%s]", errors.noChartDataFound, file)))
				end
			else
				log(messages.noJSONFound)
			end
		end
	end
	log(messages.validateFinished)
end

-- Load charts and create tracks structure --
-- Also copy over data to charts module for easy access --
local function loadCharts()
	log(messages.chartImportInit)
	for file in lfs.dir(CHARTS_DIR) do
		if string.endswith(file, ".json") then
			local chart = json.loadfile("mods\\tew\\CHIMES\\charts\\"..string.split(file, ".")[1])
			tracks[chart.chart] = {}
			for _, item in pairs(chart.data) do
				if item.folder then
					tracks[chart.chart][item.folder] = {}
				else
					log(string.format("%s [%s][%s]. %s", messages.noFolderFound, chart.chart, item.id, messages.skippingChartImport))
				end
			end
			charts[chart.chart] = chart
		end
	end
	log(messages.chartImportFinished)
end

-- Walk the CHIMES/Music directory and copy tracks over to tracks module --
local function loadTracks()
	log(messages.tracksInit)
	for path in lfs.walkdir(CHIMES_DIR) do
		local rawSplit = string.split(path, "\\")
		local split = {unpack(rawSplit, 4, #rawSplit)}
		if #split == 2 then
			if not tracks[split[1]] then
				log(string.format("%s [%s][%s]. %s", messages.fileOutOfChart, split[1], split[2], messages.skipping))
				goto continue
			end
			table.insert(tracks[split[1]], #tracks[split[1]]+1, split[2])
		elseif #split == 3 then
			if not tracks[split[1]][split[2]] then
				log(string.format("%s [%s][%s][%s]. %s", messages.fileOutOfChart, split[1], split[2], split[3], messages.skipping))
				goto continue
			end
			table.insert(tracks[split[1]][split[2]], #tracks[split[1]][split[2]]+1, split[3])
		end
		::continue::
	end
	log(messages.tracksFinished)
end

-------------------------------------------------------------

-- FUNCTION CALLS --

mwse.log("\n")
log(messages.interfaceInit)
validateCharts()
loadCharts()
loadTracks()
log(messages.interfaceFinished)

