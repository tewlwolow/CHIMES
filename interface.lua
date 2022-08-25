-- IMPORTS --------------------------------------------------

local tracks = require("tew.CHIMES.tracks")

-------------------------------------------------------------

-- DIRECTORIES --

local CHIMES_DIR = "Data Files\\Music\\CHIMES\\"
local CHARTS_DIR = "Data Files\\MWSE\\mods\\tew\\CHIMES\\charts\\"

-------------------------------------------------------------

-- FUNCTION DEFINITIONS --

local function validateCharts()
	mwse.log("[CHIMES] Running initial chart validation.")
	for file in lfs.dir(CHARTS_DIR) do
		if not file == "." or not file == ".." then
			if string.endswith(file, ".json") then
				local chart = json.loadfile("mods\\tew\\CHIMES\\charts\\"..string.split(file, ".")[1])
				if not chart.chart then
					error(string.format("[CHIMES] No chart name found for file: [%s]", file))
				elseif not chart.data then
					error(string.format("[CHIMES] No chart data found for file: [%s]", file))
				end
			else
				mwse.log("[CHIMES] Non-JSON file found in charts folder. Skipping.")
			end
		end
	end
	mwse.log("[CHIMES] Charts validated.")
end

local function loadCharts()
	mwse.log("[CHIMES] Running chart import.")
	for file in lfs.dir(CHARTS_DIR) do
		if string.endswith(file, ".json") then
			local chart = json.loadfile("mods\\tew\\CHIMES\\charts\\"..string.split(file, ".")[1])
			tracks[chart.chart] = {}
			for _, item in pairs(chart.data) do
				if item.folder then
					tracks[chart.chart][item.folder] = {}
				else
					mwse.log(string.format("[CHIMES] No folder definition found for chart: [%s]. Skipping import.", chart.chart))
				end
			end
		end
	end
	mwse.log("Charts loaded.")
end

local function loadTracks()
	mwse.log("[CHIMES] Running track validation and import.")
	for path in lfs.walkdir(CHIMES_DIR) do
		local rawSplit = string.split(path, "\\")
		local split = {unpack(rawSplit, 4, #rawSplit)}
		if #split == 2 then
			if not tracks[split[1]] then
				mwse.log(string.format("[CHIMES] Found folder outside chart definitions: [%s]. Skipping.", split[1]))
				goto continue
			end
			tracks[split[1]] = split[2]
		elseif #split == 3 then
			if not tracks[split[1]] then
				mwse.log(string.format("[CHIMES] Found folder outside chart definitions: [%s]. Skipping.", split[1]))
				goto continue
			elseif not tracks[split[1]][split[2]] then
				mwse.log(string.format("[CHIMES] Found folder outside chart definitions: [%s]. Skipping.", split[1]))
				goto continue
			end
			tracks[split[1]][split[2]] = split[3]
		end
		::continue::
	end
	mwse.log("Tracks loaded.")
end

-------------------------------------------------------------

-- FUNCTION CALLS --

mwse.log("\n[CHIMES] Running interface functions.")
validateCharts()
loadCharts()
loadTracks()
mwse.log("[CHIMES] Interface functions finished.\n")


-------------------------------------------------------------

