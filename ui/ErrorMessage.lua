local ErrorMessage = {}

local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")
local errors = i18n("errors")

local metadata = require("tew.CHIMES.metadata")
local nexusUrl = metadata.nexusUrl

-- Private function to save us some code smell when creating blocks further down the line
local function createUIBlock(menu, id)
	local block = menu:createBlock(
		{
			id = tes3ui.registerID(id)
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

function ErrorMessage.show(errorData)
	local mainMenu = tes3ui.findMenu(tes3ui.registerID("MenuOptions"))
	if (mainMenu) then
		mainMenu.visible = false
	end
	local errorMenuId = tes3ui.registerID("CHIMES:Error")
	local errorMenu = tes3ui.createMenu{id = errorMenuId, fixedFrame = true}
	tes3ui.enterMenuMode(errorMenuId)
	errorMenu.autoHeight = true
	errorMenu.autoWidth = true
	errorMenu.flowDirection = "top_to_bottom"

	errorMenu.minWidth = 600
	errorMenu.minHeight = 500
	errorMenu.width = 1200
	errorMenu.height = 800
	errorMenu.positionX = errorMenu.width / -2
	errorMenu.positionY = errorMenu.height / 2

	local container = createUIBlock(errorMenu, "CHIMES:Error_Container")
	container.flowDirection = "top_to_bottom"
	container.childAlignX = 0.5

	local headerBlock = createUIBlock(container, "CHIMES:Error_HeaderBlock")
	headerBlock.childAlignX = 0.5
	headerBlock.borderAllSides = 5
	headerBlock.borderBottom = 8

	local header = headerBlock:createImage{path = "Textures\\tew\\CHIMES\\chimes_logo.tga"}
	header.imageScaleX=0.6
	header.imageScaleY=0.6
	header.color = tes3ui.getPalette("health_npc_color")

	local titleBlock = createUIBlock(container, "CHIMES:Error_TitleBlock")
	titleBlock.borderAllSides = 8
	titleBlock.borderTop = 12
	titleBlock.childAlignX = 0.5
	local titleLabel = titleBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_TitleBlock_Label"), text = errors.errorsFound})
	titleLabel.color = {1,0,0}

	local scrollBar = container:createVerticalScrollPane()
	scrollBar.height = 400
	scrollBar.minHeight = 400
	scrollBar.maxHeight = 400
	scrollBar:setPropertyBool("PartScrollPane_hide_if_unneeded", true)

	mwse.log("\n--- Errors detected in CHIMES schemas. ---\n\n")
	for file, errorsTable in pairs(errorData) do
		local fileBlock = createUIBlock(scrollBar, "CHIMES:Error_FileBlock")
		local fileLabel = fileBlock:createTextSelect({id=tes3ui.registerID("CHIMES:Error_FileBlock_Label"), text = file .. "\n"})
		overrideColours(fileLabel, tes3ui.getPalette("normal_color"))

		mwse.log(file)
		mwse.log("\n")

		for _, error in pairs(errorsTable) do
			local errorBlock = createUIBlock(fileBlock, "CHIMES:Error_ErrorBlock")
			-- TODO: Figure out alignment
			local errorLabel = errorBlock:createTextSelect({id=tes3ui.registerID("CHIMES:Error_ErrorBlock_Label"), text = error})
			overrideColours(errorLabel, {0.8,0,0.1})
			mwse.log(string.format("\t\t%s", error))
		end
	end

	local reminderBlock = createUIBlock(errorMenu, "CHIMES:Error_ReminderBlock")
	local reminderLabel = reminderBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_ReminderBlock_Label"), text = errors.reminder})
	reminderBlock.borderAllSides = 8
	reminderLabel.color = tes3ui.getPalette("health_npc_color")

	local urlBlock = createUIBlock(errorMenu, "CHIMES:Error_URLBlock")
	urlBlock.borderAllSides = 8
	urlBlock.childAlignX = 0.5
	urlBlock:createHyperlink{
		text = messages.nexusLink,
		url = nexusUrl,
	}

	local okBlock = createUIBlock(errorMenu, "CHIMES:Error_OkBlock")
	okBlock.childAlignX = 0.5
	okBlock.borderAllSides = 4


    local okButtonId = tes3ui.registerID("CHIMES:ERROR_OkBlock_Button")
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

	errorMenu:updateLayout()
	scrollBar.widget:contentsChanged()
end

return ErrorMessage