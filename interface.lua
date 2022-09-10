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

-- CONSTANTS --

NEXUS_URL = "https://www.nexusmods.com"

-------------------------------------------------------------

-- FUNCTION DEFINITIONS --

local function showErrorMessageBox(message)
	local mainMenu = tes3ui.findMenu(tes3ui.registerID("MenuOptions"))
	if (mainMenu) then
		mainMenu.visible = false
	end
	local errorMenuId = tes3ui.registerID("CHIMES:Error")
	local errorMenu = tes3ui.createMenu{id = errorMenuId, fixedFrame = true}
	tes3ui.enterMenuMode(errorMenuId)

	local headerBlock = errorMenu:createBlock({id=tes3ui.registerID("CHIMES:Error_HeaderBlock")})
	headerBlock.widthProportional = 1.0
	headerBlock.autoHeight = true
	headerBlock.childAlignX = 0.5
	headerBlock.flowDirection = "left_to_right"

	local header = headerBlock:createImage{path = "Textures\\tew\\CHIMES\\chimes_logo.tga"}
	header.borderAllSides = 5
	header.imageScaleX=0.6
	header.imageScaleY=0.6

	local titleBlock = errorMenu:createBlock({id=tes3ui.registerID("CHIMES:Error_TitleBlock")})
	local titleLabel = titleBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_TitleBlock_Label"), text = string.format("%s", errors.errorsFound)})
	titleBlock.borderTop = 15
	titleBlock.autoHeight = true
	titleBlock.autoWidth = true
	titleBlock.widthProportional = 1.0
	titleBlock.childAlignX = 0.5
	titleBlock.flowDirection = "left_to_right"
	titleBlock.wrapText = true
	titleLabel.color = {1,0,0}

	local descrBlock = errorMenu:createBlock({id=tes3ui.registerID("CHIMES:Error_DescriptionBlock")})
	local descrLabel = descrBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_DescriptionBlock_Label"), text = string.format("%s", message)})
	descrBlock.autoHeight = true
	descrBlock.autoWidth = true
	descrBlock.flowDirection = "left_to_right"
	descrBlock.wrapText = true
	descrLabel.color = tes3ui.getPalette("disabled_color")

	local reminderBlock = errorMenu:createBlock({id=tes3ui.registerID("CHIMES:Error_ReminderBlock")})
	local reminderLabel = reminderBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_ReminderBlock_Label"), text = string.format("%s", errors.reminder)})
	reminderBlock.autoHeight = true
	reminderBlock.autoWidth = true
	reminderBlock.flowDirection = "left_to_right"
	reminderBlock.wrapText = true
	reminderLabel.color = tes3ui.getPalette("health_npc_color")

	local urlBlock = errorMenu:createBlock({id=tes3ui.registerID("CHIMES:Error_URLBlock")})
	urlBlock.autoHeight = true
	urlBlock.autoWidth = true
	urlBlock.borderAllSides = 8
	urlBlock.widthProportional = 1.0
	urlBlock.childAlignX = 0.5
	urlBlock.flowDirection = "left_to_right"
	urlBlock.wrapText = true
	urlBlock:createHyperlink{
		text = messages.nexusLink,
		url = NEXUS_URL,
	}

	local okBlock = errorMenu:createBlock({id=tes3ui.registerID("CHIMES:ERROR_CancelBlock")})
	okBlock.widthProportional = 1.0
	okBlock.autoHeight = true
	okBlock.autoWidth = true
	okBlock.childAlignX = 0.5
	okBlock.borderAllSides = 4
    okBlock.flowDirection = "top_to_bottom"

    local okButtonId = tes3ui.registerID("CHIMES:ERROR_CancelBlock_Button")
    local okButton = okBlock:createButton{
        id = okButtonId,
        text = tes3.findGMST(tes3.gmst.sOK).value,
    }

    okButton:register("mouseClick", function()
            tes3ui.leaveMenuMode()
            errorMenu:destroy()
			if (mainMenu) then
				mainMenu.visible = true
			end
        end
    )
end

-- Validate charts and load them --
local function loadCharts()
	log(messages.validateInit)
	local errorMessages = {}
	for file in lfs.dir(CHARTS_DIR) do
		if not (file) or (file and (file == "." or file == "..")) then goto continue end
		if string.endswith(file, ".json") then
			local chart = json.loadfile("mods\\tew\\CHIMES\\charts\\"..string.split(file, ".")[1])
			if not chart then
				table.insert(errorMessages, #errorMessages+1, string.format("- %s\n\t\t[%s]", errors.jsonLoadError, file))
			elseif not chart.chart then
				table.insert(errorMessages, #errorMessages+1, string.format("- %s\n\t\t[%s]", errors.noChartNameFound, file))
			elseif not chart.data then
				table.insert(errorMessages, #errorMessages+1, string.format("- %s\n\t\t[%s]", errors.noChartDataFound, file))
			else
				for _, item in pairs(chart.data) do
					if (chart.chart == "exteriors" or chart.chart == "interiors") and not (item.method) then
						table.insert(errorMessages, #errorMessages+1, string.format("- %s\n\t\t[%s]\n\t\t\t- %s\n\t\t\t\t[%s]", errors.noMethodFound, file, errors.chartItemId, item.id))
					elseif (chart.chart == "exteriors" or chart.chart == "interiors" or chart.chart == "biomes") and item.strings == {} then
						log(string.format("%s [%s][%s].", messages.emptyStrings, file, item.id))
					end
				end

				log(string.format("%s [%s]", messages.chartImportInit, file))
				tracks[chart.chart] = {}
				for _, item in pairs(chart.data) do
					if item.folder then
						tracks[chart.chart][item.folder] = {}
					else
						if chart.chart == "weathers" and chart.disabled ~= nil then
							log(string.format("%s [%s][%s]. %s", messages.noFolderFound, chart.chart, item.id, messages.skippingImport))
						else
							table.insert(errorMessages, #errorMessages+1, string.format("- %s\n\t\t[%s]\n\t\t\t- %s\n\t\t\t\t[%s]", messages.noFolderFound, file, errors.chartItemId, item.id))
						end
					end
				end
				charts[chart.chart] = chart
				log(messages.chartImportFinished)
			end
		else
			log(messages.noJSONFound)
		end
		:: continue ::
	end
	if errorMessages ~= {} then
		local message = ""
		for _, v in ipairs(errorMessages) do
			if v ~= "" then
				message = string.format("%s\n%s\n", message, v)
			end
		end
		event.register(
			tes3.event.uiActivated,
			function()
				showErrorMessageBox(message)
			end,
			{filter = "MenuOptions"}
		)
		error(log(string.format("%s\n%s", errors.errorsFound, message)), 0)
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

