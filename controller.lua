-- IMPORTS --------------------------------------------------

local tracks = require("tew.CHIMES.tracks")
local charts = require("tew.CHIMES.charts")
local service = require("tew.CHIMES.service")

-- CONDITION CHECKS --------------------------------------------------

local function interiorCheck()
	for _, item in pairs(charts.interiors.data) do
		mwse.log(item.method)
	end
end

local function exteriorCheck()

end

local function resolveCellType(e)
	if e.cell and e.cell.isOrBehavesAsExterior then
		exteriorCheck()
	else
		interiorCheck()
	end
end

-- REGISTER EVENTS --------------------------------------------------
if tracks.interiors then
	event.register(tes3.event.cellChanged, resolveCellType)
end