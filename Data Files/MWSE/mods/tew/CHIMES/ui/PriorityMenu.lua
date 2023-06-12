-- contentPath = "menu_scroll_button_up.NIF"
-- local icon = block:createImage({ path = "icons\\" .. item.icon })
-- icon.absolutePosAlignX = 0.5
-- icon.absolutePosAlignY = 0.5

local PriorityMenu = {}

local resolver = require("tew.CHIMES.services.resolver")
local catalogue = require("tew.CHIMES.cache.catalogue")
local classNames = require("tew.CHIMES.util.common").classNames
local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")
local selected

local function createClickable(block, text)
	local item = block:createTextSelect{text = text}

	item.widthProportional = 1.0
	item.autoHeight = true
	item.borderBottom = 3
	item.widget.idle = tes3ui.getPalette("normal_color")
	item.widget.over = tes3ui.getPalette("normal_over_color")
	item.widget.pressed = tes3ui.getPalette("normal_pressed_color")

	item:registerAfter(tes3.uiEvent.mouseClick, function()
		if selected then
			selected.widget.idle = tes3ui.getPalette("normal_color")
		end
		item.widget.idle = tes3ui.getPalette("link_color")
		selected = item
		tes3.messageBox{message = selected.widget.text}
	end)
end

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

local function createUIBorderBlock(menu, id)
	local block = menu:createThinBorder{
		id  = id
	}
	block.autoHeight = true
	block.autoWidth = true
	block.widthProportional = 1.0
	block.flowDirection = "top_to_bottom"
	block.wrapText = true
	block.paddingAllSides = 8
	block.borderAllSides = 8
	return block
end

function PriorityMenu.create()
	-- Close menu if triggered second time
	local menu = tes3ui.findMenu("CHIMES_PriorityMenu")
	if menu then
		menu:destroy()
		return
	end

	-- Create menu
	menu = tes3ui.createMenu{id = "CHIMES_PriorityMenu", dragFrame = true, loadable = false}
	menu.text = "CHIMES Priority Menu"
	menu.width = 520
	menu.height = 720
	menu.minWidth = 480
	menu.minHeight = 720
	menu.autoHeight = true
	menu.autoWidth = true

	-- Right-align menu position
	menu.positionX = 0.5 * menu.maxWidth - menu.width
	menu.positionY = 0.5 * menu.height + 20

	local priority = resolver.loadPriority()

	assert(priority)

	local descriptionBlock = createUIBlock(menu, "CHIMES:Priority_DescriptionBlock")
	descriptionBlock.borderAllSides = 8
	local descriptionLabel = descriptionBlock:createLabel{
		id = "CHIMES:Priority_DescriptionBlock_Label",
		text = "Use arrows to modify the priority of the chart to be played.\nCharts closer to the top will be considered first."
	}
	descriptionLabel.wrapText = true

	local classBlock = createUIBorderBlock(menu, "CHIMES:Priority_Classes_Container")
	for _, className in pairs(priority) do
		if not table.empty(catalogue[className]) then

			createClickable(classBlock, classNames[className])

			local chartsBlock = createUIBlock(classBlock, "CHIMES:Priority_Charts_Container")
			chartsBlock.paddingLeft = math.floor(menu.width / 15)
			for _, chart in ipairs(catalogue[className]) do
				createClickable(chartsBlock, chart.name)
				tes3.messageBox{message = selected}

			end
		end

	end

	local buttonsBlock = menu:createBlock()
	buttonsBlock.widthProportional = 1.0
	buttonsBlock.heightProportional = 1.0
	buttonsBlock.childAlignY = 1.0
	buttonsBlock.autoHeight = true

	local saveButton = buttonsBlock:createButton{text = messages.save}
	saveButton:registerAfter(tes3.uiEvent.mouseClick, function(e)
		tes3.messageBox{message = "Mibu"}
	end)

	local rightButton = buttonsBlock:createBlock()
	rightButton.widthProportional = 1.0
	rightButton.autoHeight = true
	rightButton.childAlignX = 1.0
	buttonsBlock:createButton{text = messages.close}
	buttonsBlock:registerAfter(tes3.uiEvent.mouseClick, function(e) menu:destroy() end)

	menu:updateLayout()
	menu:updateLayout()

	return menu
end

return PriorityMenu