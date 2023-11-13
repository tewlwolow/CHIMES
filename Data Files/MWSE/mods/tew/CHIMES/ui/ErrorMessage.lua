local errorMessage = {}

local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")
local errors = i18n("errors")

local metadata = toml.loadMetadata("CHIMES")
local homepage = metadata.package.homepage

local openChartCalls = {
	{
		try = function(chartSourceFile) return os.execute(), string.format([[code "%s"]], chartSourceFile) end,
		finally = function(chartSourceFile) os.execute(string.format([[cmd /c start code "%s"]], chartSourceFile)) end,
	},
	{
		try = function(chartSourceFile) return os.execute(), string.format([[subl "%s"]], chartSourceFile) end,
		finally = function(chartSourceFile) os.execute(string.format([[cmd /c start subl "%s"]], chartSourceFile)) end,
	},
	{
		try = function(chartSourceFile) return os.execute(), string.format([[notepad++ "%s"]], chartSourceFile) end,
		finally = function(chartSourceFile) os.execute(string.format([[cmd /c start notepad++ "%s"]], chartSourceFile)) end,
	},
	{
		try = function(chartSourceFile) return os.execute(), string.format([[notepad "%s"]], chartSourceFile) end,
		finally = function(chartSourceFile) os.execute(string.format([[cmd /c start notepad "%s"]], chartSourceFile)) end,
	},
}

local function openChart(chartSourceFile)
	for _, call in ipairs(openChartCalls) do
		local suc = call.try(chartSourceFile)
		if suc then
			call.finally(chartSourceFile)
			goto finished
		end
	end
	:: finished ::
end

-- Private function to save us some code smell when creating blocks further down the line
local function createUIBlock(menu, id)
	local block = menu:createBlock(
		{
			id = tes3ui.registerID(id),
		}
	)
	block.autoHeight = true
	block.autoWidth = true
	block.widthProportional = 1.0
	block.flowDirection = "top_to_bottom"
	block.wrapText = true

	return block
end

local function overrideColours(element, colour)
	element.color = colour
	element.consumeMouseEvents = false
end

function errorMessage.show(errorData)
	-- Make sure we hide the main menu
	local mainMenu = tes3ui.findMenu(tes3ui.registerID("MenuOptions"))
	if (mainMenu) then
		mainMenu.visible = false
	end

	-- Create our menu
	local errorMenu = tes3ui.createMenu {
		id = tes3ui.registerID("CHIMES:Error"),
		fixedFrame = true,
	}

	-- Bring it up front
	tes3ui.enterMenuMode("CHIMES:Error")

	-- Main menu properties
	errorMenu.autoWidth = true
	errorMenu.flowDirection = "top_to_bottom"
	errorMenu.minWidth = 600
	errorMenu.minHeight = 500
	errorMenu.width = 1200
	errorMenu.height = 800
	errorMenu.positionX = errorMenu.width / -2
	errorMenu.positionY = errorMenu.height / 2

	-- Our main container block
	local container = createUIBlock(errorMenu, "CHIMES:Error_Container")
	container.flowDirection = "top_to_bottom"
	container.childAlignX = 0.5

	-- Header block to keep the image in
	local headerBlock = createUIBlock(container, "CHIMES:Error_HeaderBlock")
	headerBlock.childAlignX = 0.5
	headerBlock.borderAllSides = 5
	headerBlock.borderBottom = 8

	-- Create the image and colour it red
	local header = headerBlock:createImage { path = "Textures\\tew\\CHIMES\\chimes_logo.tga" }
	header.imageScaleX = 0.6
	header.imageScaleY = 0.6
	header.color = tes3ui.getPalette("health_npc_color")

	-- Our title block
	local titleBlock = createUIBlock(container, "CHIMES:Error_TitleBlock")
	titleBlock.borderAllSides = 8
	titleBlock.borderTop = 12
	titleBlock.childAlignX = 0.5
	local titleLabel = titleBlock:createLabel {
		id = tes3ui.registerID("CHIMES:Error_TitleBlock_Label"),
		text = errors.errorsFound,
	}
	titleLabel.color = { 1, 0, 0 }

	-- Scroll pane window to present the errors nicely
	local scrollBar = container:createVerticalScrollPane()
	scrollBar.height = 400
	scrollBar.minHeight = 400
	scrollBar.maxHeight = 400
	scrollBar.wrapText = true
	scrollBar:setPropertyBool("PartScrollPane_hide_if_unneeded", true)

	-- Log start message
	mwse.log("\n--- Errors detected in CHIMES schemas. ---\n\n")

	-- Loop over errors we got and create entries for them
	for file, errorsTable in pairs(errorData) do
		-- This is the block to hold the file tag
		local fileBlock = createUIBlock(scrollBar, "CHIMES:Error_FileBlock")
		local fileText = fileBlock:createTextSelect {
			id = tes3ui.registerID("CHIMES:Error_FileBlock_Label"),
			text = file .. "\n",
		}
		fileText.wrapText = true
		overrideColours(fileText, tes3ui.getPalette("normal_color"))

		-- Log the file tag
		mwse.log(file)

		-- Create the link to the file
		fileText.widget.idle = tes3ui.getPalette("link_color")
		fileText.widget.over = tes3ui.getPalette("link_over_color")
		fileText.widget.pressed = tes3ui.getPalette("link_pressed_color")

		local startIndex, _ = string.find(file, "mwse")
		local _, endIndex = string.find(file, ".lua")
		local chartSourceFile = "Data Files\\" .. string.sub(file, startIndex, endIndex)
		fileText:register("mouseClick", function()
			openChart(chartSourceFile)
		end)

		-- Loop over error container per file
		for _, error in pairs(errorsTable) do
			local errorBlock = createUIBlock(fileBlock, "CHIMES:Error_ErrorBlock")
			local errorText = errorBlock:createTextSelect {
				id = tes3ui.registerID("CHIMES:Error_ErrorBlock_Label"),
				text = error,
			}
			errorText.wrapText = true
			overrideColours(errorText, tes3ui.getPalette("health_color"))
			-- Log the error
			mwse.log(string.format("%s", error))
		end
	end

	-- This is the block to hold our reminder message
	local reminderBlock = createUIBlock(errorMenu, "CHIMES:Error_ReminderBlock")
	local reminderLabel = reminderBlock:createLabel {
		id = tes3ui.registerID("CHIMES:Error_ReminderBlock_Label"),
		text = string.format(
			"%s\n%s\n%s",
			errors.fixErrors,
			errors.reminder,
			errors.questions),
	}
	reminderLabel.wrapText = true
	reminderBlock.borderAllSides = 8

	-- Our URL block that points to the nexus page
	local urlBlock = createUIBlock(errorMenu, "CHIMES:Error_URLBlock")
	urlBlock.borderAllSides = 8
	urlBlock.childAlignX = 0.5
	urlBlock:createHyperlink {
		text = messages.nexusLink,
		url = homepage,
	}

	-- Button block
	local okBlock = createUIBlock(errorMenu, "CHIMES:Error_OkBlock")
	okBlock.childAlignX = 0.5
	okBlock.borderAllSides = 4

	local okButton = okBlock:createButton {
		id = tes3ui.registerID("CHIMES:ERROR_OkBlock_Button"),
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

	-- Update the main menu and the scroll pane widget
	errorMenu:updateLayout()
	errorMenu:updateLayout()
	errorMenu:updateLayout()
	scrollBar.widget:contentsChanged()
end

return errorMessage
