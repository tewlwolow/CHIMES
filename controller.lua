-- IMPORTS --------------------------------------------------

local tracks = require("tew.CHIMES.tracks")
local charts = require("tew.CHIMES.charts")
local service = require("tew.CHIMES.service")

-- CONDITION CHECKS --------------------------------------------------

local function resolveCellType(e)
	local cell = e.cell
	if cell and cell.isOrBehavesAsExterior then
		service.playCell(charts.exteriors.data, cell)
	else
		service.playCell(charts.interiors.data, cell)
	end
end

-- REGISTER EVENTS --------------------------------------------------
if tracks.interiors then
	event.register(tes3.event.cellChanged, resolveCellType)
end