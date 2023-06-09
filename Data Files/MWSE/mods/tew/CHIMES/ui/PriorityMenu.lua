-- contentPath = "menu_scroll_button_up.NIF"

local PriorityMenu = {}

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

	-- Right-align menu position
	menu.positionX = 0.5 * menu.maxWidth - menu.width
	menu.positionY = 0.5 * menu.height + 20


	menu:updateLayout()
	menu:updateLayout()

	return menu
end

return PriorityMenu