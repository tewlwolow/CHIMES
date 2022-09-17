-- IMPORTS --------------------------------------------------

local charts = require("tew.CHIMES.charts")
local service = require("tew.CHIMES.service")

-- CONDITION CHECKS --------------------------------------------------

local function resolveCellType(e)
	local cell = e.cell
	if cell and cell.isOrBehavesAsExterior then
		service.playCell(charts.exteriors, cell)
	else
		service.playCell(charts.interiors, cell)
	end
end

-- REGISTER EVENTS --------------------------------------------------
--event.register(tes3.event.cellChanged, resolveCellType)
