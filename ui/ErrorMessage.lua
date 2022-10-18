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

	local headerBlock = createUIBlock(errorMenu, "CHIMES:Error_HeaderBlock")
	headerBlock.childAlignX = 0.5
	headerBlock.borderAllSides = 5
	headerBlock.borderBottom = 8

	local header = headerBlock:createImage{path = "Textures\\tew\\CHIMES\\chimes_logo.tga"}
	header.imageScaleX=0.6
	header.imageScaleY=0.6
	header.color = tes3ui.getPalette("health_npc_color")

	local titleBlock = createUIBlock(errorMenu, "CHIMES:Error_TitleBlock")
	titleBlock.borderAllSides = 8
	titleBlock.borderTop = 12
	titleBlock.childAlignX = 0.5
	local titleLabel = titleBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_TitleBlock_Label"), text = string.format("%s", errors.errorsFound)})
	titleLabel.color = {1,0,0}

	local errorsContainer = createUIBlock(errorMenu, "CHIMES:Error_ErrorsContainer")
	errorsContainer.heightProportional = 1.0

	for file, errorsTable in pairs(errorData) do
		if file ~= "" and next(errorsTable) ~= nil then
			local fileBlock = createUIBlock(errorsContainer, "CHIMES:Error_FileBlock")
			local fileLabel = fileBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_FileBlock_Label"), text = string.format("- [%s]", file)})
			fileLabel.color = tes3ui.getPalette("normal_color")
			mwse.log(string.format("- [%s]", file))

			for def, error in pairs(errorsTable) do
				if type(error) == "string" then
					local errorBlock = createUIBlock(fileBlock, "CHIMES:Error_ErrorBlock")
					errorBlock.childAlignX = 0.12
					local errorLabel = errorBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_ErrorBlock_Label"), text = string.format("%s", error)})
					errorLabel.color = {0.8,0,0.1}
					mwse.log(string.format("\t%s", error))
				elseif type(error) == "table" and next(error) ~= nil then
					local chartItemBlock = createUIBlock(fileBlock, "CHIMES:Error_ChartItemBlock")
					chartItemBlock.childAlignX = 0.06
					local chartLabel = chartItemBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_ChartItemBlock_Label"), text = string.format("- <%s>", def)})
					chartLabel.color = tes3ui.getPalette("disabled_color")
					mwse.log(string.format("- <%s>", def))
					for _, v in ipairs(error) do
						local errorBlock = createUIBlock(fileBlock, "CHIMES:Error_ErrorBlock")
						errorBlock.childAlignX = 0.15
						local errorLabel = errorBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_ErrorBlock_Label"), text = string.format("%s", v)})
						errorLabel.color = {0.8,0,0.1}
						mwse.log(string.format("\t%s", v))
					end
				end
			end
		end
	end

	local reminderBlock = createUIBlock(errorMenu, "CHIMES:Error_ReminderBlock")
	local reminderLabel = reminderBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_ReminderBlock_Label"), text = string.format("%s", errors.reminder)})
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
end

return ErrorMessage