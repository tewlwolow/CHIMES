local PriorityMenu = {}

local resolver = require("tew.CHIMES.services.resolver")
local catalogue = require("tew.CHIMES.cache.catalogue")
local classNames = require("tew.CHIMES.util.common").classNames
local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")
local selected
local priority = resolver.loadPriority()
assert(priority)

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

local function createClassBlock(menu, classBlock)
	for index, class in pairs(priority) do
		local className = class.name
		if not table.empty(catalogue[className]) then
			createClickable(classBlock, classNames[className])
			local chartsBlock = createUIBlock(classBlock, "CHIMES:Priority_Charts_Container")
			chartsBlock.paddingLeft = math.floor(menu.width / 5)

			for _, chart in ipairs(catalogue[className]) do
				if not table.find(priority[index].charts, chart.name) then
					priority[index].charts[#priority[index].charts + 1] = chart.name
				end
			end
			resolver.savePriority(priority)

			for _, chartName in ipairs(class.charts) do
				createClickable(chartsBlock, chartName)
			end
		end
	end
end

function PriorityMenu.create()
	-- Close menu if triggered second time
	local menu = tes3ui.findMenu("CHIMES:PriorityMenu")
	if menu then
		menu:destroy()
		return
	end

	-- Create menu
	menu = tes3ui.createMenu{id = "CHIMES:PriorityMenu", dragFrame = true, loadable = false}
	menu.text = "CHIMES Priority Menu"
	menu.autoHeight = true
	menu.autoWidth = true
	menu.minWidth = 520
	menu.minHeight = 500

	local mainContainer = createUIBlock(menu, "CHIMES:Priority_MainContainer")
	mainContainer.flowDirection = "left_to_right"
	local contentBlock = createUIBlock(mainContainer, "CHIMES:Priority_ContentBlock")

	local descriptionBlock = createUIBlock(contentBlock, "CHIMES:Priority_DescriptionBlock")
	descriptionBlock.borderAllSides = 8
	local contentDescLabel = descriptionBlock:createLabel{
		id = "CHIMES:Priority_DescriptionBlock_Label",
		text = "Use arrows to modify the priority of the chart to be played.\nCharts closer to the top will be considered first."
	}
	contentDescLabel.wrapText = true

	local classBlock = createUIBorderBlock(contentBlock, "CHIMES:Priority_Classes_Container")
	createClassBlock(menu, classBlock)

	---
	local arrowBlock = createUIBlock(mainContainer, "CHIMES:Priority_ArrowBlock")
	arrowBlock.borderAllSides = 8
	arrowBlock.childAlignX = 0.5

	local arrowUp = arrowBlock:createImage{ path = "Textures\\menu_scroll_up.dds"}
	arrowUp.height = 32
    arrowUp.width = 32
    arrowUp.borderAllSides = 2
	arrowUp.absolutePosAlignX = 0.5
	arrowUp.visible = true
	arrowUp:registerAfter(tes3.uiEvent.mouseClick, function()
		if selected then
			tes3.messageBox{message = selected.text}
		end
	end)

	local arrowDown = arrowBlock:createImage{ path = "Textures\\menu_scroll_down.dds"}
	arrowDown.height = 32
    arrowDown.width = 32
    arrowDown.borderAllSides = 2
	arrowDown.absolutePosAlignX = 0.5
	arrowDown.visible = true
	arrowDown:registerAfter(tes3.uiEvent.mouseClick, function()
		if selected then
			tes3.messageBox{message = selected.text}
		end
	end)

	---
	local buttonsBlock = menu:createBlock()
	buttonsBlock.widthProportional = 1.0
	buttonsBlock.heightProportional = 1.0
	buttonsBlock.childAlignY = 1.0
	buttonsBlock.autoHeight = true

	local saveButton = buttonsBlock:createButton{text = messages.save}
	saveButton:registerAfter(tes3.uiEvent.mouseClick, function()
		tes3.messageBox{message = "Mibu"}
	end)

	local rightButton = buttonsBlock:createBlock()
	rightButton.widthProportional = 1.0
	rightButton.autoHeight = true
	rightButton.childAlignX = 1.0
	buttonsBlock:createButton{text = messages.close}
	buttonsBlock:registerAfter(tes3.uiEvent.mouseClick, function(e) menu:destroy() end)

	--- Ridiculous but needed
	menu:updateLayout()
	menu:updateLayout()
	menu:updateLayout()

	return menu
end

return PriorityMenu