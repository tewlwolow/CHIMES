-- IMPORTS --

local charts = require("tew.CHIMES.charts")
local ErrorMessage = require("tew.CHIMES.ui.ErrorMessage")

local log = require("tew.CHIMES.util.common").log

local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")
local errors = i18n("errors")


-------------------------------------------------------------

-- DIRECTORIES --

local CHIMES_DIR = "Data Files\\Music\\CHIMES\\"
local CHARTS_DIR = "Data Files\\MWSE\\mods\\tew\\CHIMES\\charts\\"


-------------------------------------------------------------

-- LOCALS --

local errorMessages = {}

-------------------------------------------------------------

-- FUNCTION DEFINITIONS --

-- TODO: replace with: https://mwse.github.io/MWSE/apis/table/?h=table.cop#tableempty
local function isTableEmpty(tab)
	local isEmpty = true
	local function walker(subtab)
		for _, v in pairs(subtab) do
			if v and type(v) ~= "table" then
				isEmpty = false
			elseif type(v) == "table" then
				walker(v)
			end
		end
	end
	walker(tab)
	return isEmpty
end

local function pruneTable(tab)
	for k, v in pairs(tab) do
		if not (v) or v and (type(v) == "table" and next(v) == nil) then
			tab[k] = nil
		elseif type(v) == "table" then
			pruneTable(v)
		end
	end
end

local function processErrors()
	event.register (
		tes3.event.uiActivated,
		function()
			ErrorMessage.show(errorMessages)
		end,
		{
			filter = "MenuOptions",
			doOnce = true,
		}
	)
	log(string.format("%s\n", errors.errorsFound))
	for file, errorContainer in pairs(errorMessages) do
		if file ~= "" and next(errorContainer) ~= nil then
			mwse.log(string.format("\t- [%s]", file))
			for def, error in pairs(errorContainer) do
				if type(error) == "string" then
					mwse.log(string.format("\t\t\t%s", error))
				end
				if type(error) == "table" and next(error) ~= nil then
					mwse.log(string.format("\t\t\t- <%s>", def))
					for _, v in ipairs(error) do
						mwse.log(string.format("\t\t\t\t\t%s", v))
					end
				end
			end
		end
	end
	mwse.log("\n")
end

local function validateChartData(chartFile, file)
	for _, item in ipairs(chartFile.data) do
		local itemId = item.id
		if not itemId then
			table.insert(errorMessages[file], #errorMessages[file]+1, errors.noIdFound)
			goto continue
		end
		errorMessages[file][itemId] = {}
		if not item.folder then
			if chartFile.chart == "weathers" and chartFile.disable == nil then
				log(string.format("%s [%s][%s]. %s", errors.noFolderFound, chartFile.chart, item.id, messages.skippingImport))
			else
				table.insert(errorMessages[file][itemId], #errorMessages[file][itemId]+1, errors.noFolderFound)
			end
		end
		if (chartFile.chart == "exteriors" or chartFile.chart == "interiors") and not (item.method) then
			table.insert(errorMessages[file][itemId], #errorMessages[file][itemId]+1, errors.noMethodFound)
		elseif (chartFile.chart == "exteriors" or chartFile.chart == "interiors" or chartFile.chart == "biomes") and item.strings == {} then
			log(string.format("%s [%s][%s].", messages.emptyStrings, file, item.id))
		end
		:: continue ::
	end
	if chartFile.chart then
		charts[chartFile.chart] = chartFile
	end
end

-- Validate charts and load them --
local function loadCharts()
	log(messages.validateInit)
	for file in lfs.dir(CHARTS_DIR) do

		if not (file) or (file and (file == "." or file == "..")) then goto continue end

		if string.endswith(file, ".json") then
			errorMessages[file] = {}
			local chartFile = json.loadfile("mods\\tew\\CHIMES\\charts\\"..string.split(file, ".")[1])

			if not chartFile then
				table.insert(errorMessages[file], #errorMessages[file]+1, string.format(errors.jsonLoadError))
				goto continue
			elseif not chartFile.chart then
				table.insert(errorMessages[file], #errorMessages[file]+1, string.format(errors.noChartNameFound))
				goto continue
			elseif not chartFile.data then
				table.insert(errorMessages[file], #errorMessages[file]+1, string.format(errors.noChartDataFound))
				goto continue
			end

			validateChartData(chartFile, file)
		else
			log(messages.nonJSONFileFound)
		end
		:: continue ::
	end
	pruneTable(errorMessages)
	if not isTableEmpty(errorMessages) then
		processErrors()
	end
	log(messages.validateFinished)
end

-- Walk the CHIMES/Music directory and copy tracks over to tracks module --
local function loadTracks()
	log(messages.tracksInit)
	for path in lfs.walkdir(CHIMES_DIR) do
		local rawSplit = string.split(path, "\\")
		local split = {unpack(rawSplit, 4, #rawSplit)}
		if #split == 2 then
			if not charts[split[1]].tracks then
				goto continue
			end
			charts[split[1]].tracks = charts[split[1]].tracks or {}
			table.insert(charts[split[1]].tracks, #charts[split[1]].tracks+1, split[2])
		elseif #split == 3 then
			if not charts[split[1]][split[2]] then
				log(string.format("%s [%s][%s][%s]. %s", messages.fileOutOfChart, split[1], split[2], split[3], messages.skipping))
				goto continue
			end
			charts[split[1]][split[2]].tracks = charts[split[1]][split[2]].tracks or {}
			table.insert(charts[split[1]][split[2].tracks], #charts[split[1]][split[2]].tracks+1, split[3])
		end
		:: continue ::
	end
	log(messages.tracksFinished)
end

-------------------------------------------------------------

-- FUNCTION CALLS --

mwse.log("\n")
log(messages.interfaceInit)
loadCharts()
loadTracks()
log(messages.interfaceFinished)

