local PriorityMenu = {}

local resolver = require("tew.CHIMES.services.resolver")
local catalogue = require("tew.CHIMES.cache.catalogue")
local classNames = require("tew.CHIMES.util.common").classNames
local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")
local selected, previousSelectedText
local priority = resolver.loadPriority()
assert(priority)

-- name = "CHIMES:Priority_Charts_Container"
local function getNewSelected(classBlock)
	if not classBlock then return end
	local pane = classBlock:findChild("PartScrollPane_pane")
	for _, element in pairs(pane.children) do
		if element.text == previousSelectedText then
			selected = element
			element.widget.state = tes3.uiState.active
		end
	end
end

local function updateLayout(menu, classBlock)
	menu:updateLayout()
	menu:updateLayout()
	menu:updateLayout()
	classBlock.widget:contentsChanged()
end

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

-- local function createUIBorderBlock(menu, id)
-- 	local block = menu:createThinBorder{
-- 		id  = id
-- 	}
-- 	block.autoHeight = true
-- 	block.autoWidth = true
-- 	block.widthProportional = 1.0
-- 	block.flowDirection = "top_to_bottom"
-- 	block.wrapText = true
-- 	block.paddingAllSides = 8
-- 	block.borderAllSides = 8

-- 	return block
-- end

local function createScrollbar(menu)
	local scrollbar = menu:createVerticalScrollPane()
	scrollbar.height = 400
	scrollbar.minHeight = 400
	scrollbar.maxHeight = 400
	scrollbar.autoHeight = true
	scrollbar.autoWidth = true
	scrollbar:setPropertyBool("PartScrollPane_hide_if_unneeded", true)
	return scrollbar
end

local function updateClassBlock(classBlock)
	priority = resolver.loadPriority()
	assert(priority)
	for index, class in pairs(priority) do
		local className = class.name
		if not table.empty(catalogue[className]) then
			createClickable(classBlock, classNames[className])
			local chartsBlock = createUIBlock(classBlock, "CHIMES:Priority_Charts_Container")
			chartsBlock.paddingLeft = 15

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
	menu.minWidth = 525
	menu.minHeight = 600

	local mainContainer = createUIBlock(menu, "CHIMES:Priority_MainContainer")
	mainContainer.flowDirection = "left_to_right"
	local contentBlock = createUIBlock(mainContainer, "CHIMES:Priority_ContentBlock")

	local descriptionBlock = createUIBlock(contentBlock, "CHIMES:Priority_DescriptionBlock")
	descriptionBlock.borderAllSides = 8
	local contentDescLabel = descriptionBlock:createLabel{
		id = "CHIMES:Priority_DescriptionBlock_Label",
		text = "Use arrows to modify the priority of the chart to be played.\nCharts closer to the top will be considered first.\n\nChanges are saved automatically."
	}
	contentDescLabel.wrapText = true

	local classBlock  = createScrollbar(contentBlock)
	updateClassBlock(classBlock)

	---
	local arrowBlock = createUIBlock(mainContainer, "CHIMES:Priority_ArrowBlock")
	arrowBlock.borderAllSides = 8
	arrowBlock.widthProportional = 1.0
    arrowBlock.heightProportional = 1.0
	arrowBlock.childAlignX = 0.5
	arrowBlock.childAlignY = 0.5

	local arrowUp = arrowBlock:createImage{ path = "Textures\\menu_scroll_up.dds"}
	arrowUp.height = 32
    arrowUp.width = 32
    arrowUp.borderAllSides = 2
	arrowUp.absolutePosAlignX = 0.5
	arrowUp.visible = true
	arrowUp:registerAfter(tes3.uiEvent.mouseClick, function()
		tes3.playSound{sound="Menu Click"}
		if selected then
			priority = resolver.loadPriority()
			assert(priority)
			local text = table.find(classNames, selected.text) or selected.text
			local classKey
			for index, class in ipairs(priority) do
				classKey = table.find(class, text)
				if classKey then
					if index ~= 1 then
						local previous = priority[index - 1]
						priority[index - 1] = priority[index]
						priority[index] = previous
						previousSelectedText = selected.text
						selected = nil
						resolver.savePriority(priority)
						classBlock:destroy()
						classBlock  = createScrollbar(contentBlock)
						updateClassBlock(classBlock)
						getNewSelected(classBlock)
						updateLayout(menu, classBlock)
						break
					end
				else
					for subIndex, chart in ipairs(class.charts) do
						if chart == text then
							if subIndex ~= 1 then
								local previous = class.charts[subIndex - 1]
								class.charts[subIndex - 1] = class.charts[subIndex]
								class.charts[subIndex] = previous
								previousSelectedText = selected.text
								selected = nil
								resolver.savePriority(priority)
								classBlock:destroy()
								classBlock  = createScrollbar(contentBlock)
								updateClassBlock(classBlock)
								getNewSelected(classBlock)
								updateLayout(menu, classBlock)
								break
							end
						end
					end
				end
			end
		end
	end)

	local arrowDown = arrowBlock:createImage{ path = "Textures\\menu_scroll_down.dds"}
	arrowDown.height = 32
    arrowDown.width = 32
    arrowDown.borderAllSides = 2
	arrowDown.absolutePosAlignX = 0.5
	arrowDown.visible = true
	arrowDown:registerAfter(tes3.uiEvent.mouseClick, function()
		tes3.playSound{sound="Menu Click"}
		if selected then
			priority = resolver.loadPriority()
			assert(priority)
			local text = table.find(classNames, selected.text) or selected.text
			local classKey
			for index, class in ipairs(priority) do
				classKey = table.find(class, text)
				if classKey then
					if index ~= #priority then
						local next = priority[index + 1]
						priority[index + 1] = priority[index]
						priority[index] = next
						previousSelectedText = selected.text
						selected = nil
						resolver.savePriority(priority)
						classBlock:destroy()
						classBlock  = createScrollbar(contentBlock)
						updateClassBlock(classBlock)
						getNewSelected(classBlock)
						updateLayout(menu, classBlock)
						break
					end
				else
					for subIndex, chart in ipairs(class.charts) do
						if chart == text then
							if subIndex ~= #class.charts then
								local next = class.charts[subIndex + 1]
								class.charts[subIndex + 1] = class.charts[subIndex]
								class.charts[subIndex] = next
								previousSelectedText = selected.text
								selected = nil
								resolver.savePriority(priority)
								classBlock:destroy()
								classBlock  = createScrollbar(contentBlock)
								updateClassBlock(classBlock)
								getNewSelected(classBlock)
								updateLayout(menu, classBlock)
								break
							end
						end
					end
				end
			end
		end
	end)

	---
	local buttonsBlock = menu:createBlock()
	buttonsBlock.widthProportional = 1.0
	buttonsBlock.heightProportional = 1.0
	buttonsBlock.childAlignY = 1.0
	buttonsBlock.autoHeight = true

	local restoreButton = buttonsBlock:createButton{text = messages.restoreDefaults}
	restoreButton:registerAfter(tes3.uiEvent.mouseClick, function()
		tes3.messageBox{
			message = messages.restoreDefaultsConfirm,
			buttons = {
				tes3.findGMST(tes3.gmst.sYes).value,
				tes3.findGMST(tes3.gmst.sNo).value
			},
			callback = function(e)
				if (e.button == 0) then
					resolver.createPriority()
					tes3.messageBox{
						message = messages.defaultPriorityRestored
					}
					classBlock:destroy()
					classBlock  = createScrollbar(contentBlock)
					updateClassBlock(classBlock)
					updateLayout(menu, classBlock)
				end
			end
		}
	end)

	local rightButton = buttonsBlock:createBlock()
	rightButton.widthProportional = 1.0
	rightButton.autoHeight = true
	rightButton.childAlignX = 1.0
	buttonsBlock:createButton{text = messages.close}
	buttonsBlock:registerAfter(tes3.uiEvent.mouseClick, function(e) menu:destroy() end)

	--- Ridiculous but needed
	updateLayout(menu, classBlock)

	return menu
end

return PriorityMenu