local ui = {}

local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")
local errors = i18n("errors")

function ui.showErrorMessageBox(errorData)
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

	local headerBlock = errorMenu:createBlock({id=tes3ui.registerID("CHIMES:Error_HeaderBlock")})
	headerBlock.widthProportional = 1.0
	headerBlock.autoHeight = true
	headerBlock.childAlignX = 0.5
	headerBlock.borderAllSides = 5
	headerBlock.borderBottom = 8
	headerBlock.flowDirection = "top_to_bottom"

	local header = headerBlock:createImage{path = "Textures\\tew\\CHIMES\\chimes_logo.tga"}
	header.imageScaleX=0.6
	header.imageScaleY=0.6

	local titleBlock = errorMenu:createBlock({id=tes3ui.registerID("CHIMES:Error_TitleBlock")})
	titleBlock.borderAllSides = 8
	titleBlock.borderTop = 12
	titleBlock.autoHeight = true
	titleBlock.autoWidth = true
	titleBlock.widthProportional = 1.0
	titleBlock.childAlignX = 0.5
	titleBlock.flowDirection = "top_to_bottom"
	titleBlock.wrapText = true
	local titleLabel = titleBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_TitleBlock_Label"), text = string.format("%s", errors.errorsFound)})
	titleLabel.color = {1,0,0}

	local errorsContainer = errorMenu:createBlock({id=tes3ui.registerID("CHIMES:Error_ErrorsContainer")})
	errorsContainer.autoHeight = true
	errorsContainer.autoWidth = true
	errorsContainer.widthProportional = 1.0
	errorsContainer.heightProportional = 1.0
	errorsContainer.flowDirection = "top_to_bottom"
	errorsContainer.wrapText = true

	for file, errorsTable in pairs(errorData) do
		if file ~= "" and next(errorsTable) ~= nil then
			local fileBlock = errorsContainer:createBlock({id=tes3ui.registerID("CHIMES:Error_FileBlock")})
			fileBlock.autoHeight = true
			fileBlock.autoWidth = true
			fileBlock.widthProportional = 1.0
			fileBlock.flowDirection = "top_to_bottom"
			fileBlock.wrapText = true
			local fileLabel = fileBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_FileBlock_Label"), text = string.format("- [%s]", file)})
			fileLabel.color = tes3ui.getPalette("normal_color")

			for def, error in pairs(errorsTable) do
				if type(error) == "string" then
					local errorBlock = fileBlock:createBlock({id=tes3ui.registerID("CHIMES:Error_ErrorBlock")})
					errorBlock.autoHeight = true
					errorBlock.autoWidth = true
					errorBlock.widthProportional = 1.0
					errorBlock.childAlignX = 0.1
					errorBlock.flowDirection = "top_to_bottom"
					errorBlock.wrapText = true
					local errorLabel = errorBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_ErrorBlock_Label"), text = string.format("%s", error)})
					errorLabel.color = {0.8,0,0.1}
				elseif type(error) == "table" and next(error) ~= nil then
					local chartItemBlock = fileBlock:createBlock({id=tes3ui.registerID("CHIMES:Error_ChartItemBlock")})
					chartItemBlock.autoHeight = true
					chartItemBlock.autoWidth = true
					chartItemBlock.widthProportional = 1.0
					chartItemBlock.childAlignX = 0.06
					chartItemBlock.flowDirection = "top_to_bottom"
					chartItemBlock.wrapText = true
					local chartLabel = chartItemBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_ChartItemBlock_Label"), text = string.format("- <%s>", def)})
					chartLabel.color = tes3ui.getPalette("disabled_color")
					for _, v in ipairs(error) do
						local errorBlock = chartItemBlock:createBlock({id=tes3ui.registerID("CHIMES:Error_ErrorBlock")})
						errorBlock.autoHeight = true
						errorBlock.autoWidth = true
						errorBlock.widthProportional = 1.0
						errorBlock.childAlignX = 0.22
						errorBlock.flowDirection = "top_to_bottom"
						errorBlock.wrapText = true
						local errorLabel = errorBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_ErrorBlock_Label"), text = string.format("%s", v)})
						errorLabel.color = {0.8,0,0.1}
					end
				end
			end
		end
	end

	local reminderBlock = errorMenu:createBlock({id=tes3ui.registerID("CHIMES:Error_ReminderBlock")})
	local reminderLabel = reminderBlock:createLabel({id=tes3ui.registerID("CHIMES:Error_ReminderBlock_Label"), text = string.format("%s", errors.reminder)})
	reminderBlock.borderAllSides = 8
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

	local okBlock = errorMenu:createBlock({id=tes3ui.registerID("CHIMES:Error_OkBlock")})
	okBlock.widthProportional = 1.0
	okBlock.autoHeight = true
	okBlock.autoWidth = true
	okBlock.childAlignX = 0.5
	okBlock.borderAllSides = 4
    okBlock.flowDirection = "top_to_bottom"

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

return ui