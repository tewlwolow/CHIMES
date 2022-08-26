-- IMPORTS --------------------------------------------------

local tracks = require("tew.CHIMES.tracks")
local log = require("tew.CHIMES.common").log

-------------------------------------------------------------

-- DIRECTORIES --

local CHIMES_DIR = "Data Files\\Music\\CHIMES\\"
local CHARTS_DIR = "Data Files\\MWSE\\mods\\tew\\CHIMES\\charts\\"

-------------------------------------------------------------

-- FUNCTION DEFINITIONS --

local function validateCharts()
	log("Running initial chart validation.")
	for file in lfs.dir(CHARTS_DIR) do
		if not file == "." or not file == ".." then
			if string.endswith(file, ".json") then
				local chart = json.loadfile("mods\\tew\\CHIMES\\charts\\"..string.split(file, ".")[1])
				if not chart.chart then
					error(string.format("No chart name found for file: [%s]", file))
				elseif not chart.data then
					error(string.format("No chart data found for file: [%s]", file))
				end
			else
				log("Non-JSON file found in charts folder. Skipping.")
			end
		end
	end
	log("Charts validated.")
end

local function loadCharts()
	log("Running chart import.")
	for file in lfs.dir(CHARTS_DIR) do
		if string.endswith(file, ".json") then
			local chart = json.loadfile("mods\\tew\\CHIMES\\charts\\"..string.split(file, ".")[1])
			tracks[chart.chart] = {}
			for _, item in pairs(chart.data) do
				if item.folder then
					tracks[chart.chart][item.folder] = {}
				else
					log(string.format("No folder definition found for chart: [%s][%s]. Skipping chart import.", chart.chart, item.id))
				end
			end
		end
	end
	log("Charts loaded.")
end

local function loadTracks()
	log("Running track validation and import.")
	for path in lfs.walkdir(CHIMES_DIR) do
		local rawSplit = string.split(path, "\\")
		local split = {unpack(rawSplit, 4, #rawSplit)}
		if #split == 2 then
			if not tracks[split[1]] then
				log(string.format("Found file outside chart definitions: [%s][%s]. Skipping.", split[1], split[2]))
				goto continue
			end
			table.insert(tracks[split[1]], #tracks[split[1]]+1, split[2])
		elseif #split == 3 then
			if not tracks[split[1]][split[2]] then
				log(string.format("Found file outside chart definitions: [%s][%s][%s]. Skipping.", split[1], split[2], split[3]))
				goto continue
			end
			table.insert(tracks[split[1]][split[2]], #tracks[split[1]][split[2]]+1, split[3])
		end
		::continue::
	end
	log("Tracks loaded.")
end

-------------------------------------------------------------

-- FUNCTION CALLS --

mwse.log("\n")
log("Running interface functions.")
validateCharts()
loadCharts()
loadTracks()
log("Interface functions finished.\n")


-------------------------------------------------------------

