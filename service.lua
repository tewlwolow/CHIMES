local service = {}

-- IMPORTS --------------------------------------------------

local config = require("tew.CHIMES.config")
local log = require("tew.CHIMES.common").log
local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")

-------------------------------------------------------------

-- FUNCTION DEFINITIONS --

-- TILEST/NAME DETECTION METHODS --

function service.parseTileset(strings, folder, cell)
	local count = 0
	if strings and folder and cell then
		for stat in cell:iterateReferences(tes3.objectType.static) do
			for _, staticName in ipairs(strings) do
				if string.find(stat.object.id:lower(), staticName:lower()) then
					count = count + 1
					if count >= config.maxStatics then
						return folder
					end
				end
			end
		end
	end
end

function service.parseNames(strings, folder, cell)
	if strings and folder and cell and cell.name then
		for _, name in ipairs(strings) do
			if string.find(cell.name, name) then
				return folder
			end
		end
	end
end

function service.getCellType(item, cell)
	local method = item.method
	local folder = item.folder
	local strings = item.strings

	if method == "tileset" then
		return service.parseTileset(strings, folder, cell)
	elseif method == "names" then
		return service.parseNames(strings, folder, cell)
	end
end

-- PLAY CELL MUSIC JOB --
function service.playCell(chart, cell)
	local data = chart.data
	local cellTypes = {}
	local cellType
	for priority, item in pairs(data) do
		cellTypes[priority] = service.getCellType(item, cell)
	end
	if #cellTypes > 1 then
		log(messages.superMatch)
		for k, v in pairs(cellTypes) do
			log(string.format("%s: [%s], %s: [%s]", messages.priority, k, messages.cellType, v))
		end
		log(messages.priorityMessage)
	end

	local i = 0
	if #cellTypes > 0 then
		repeat
			i = i + 1
		until(cellTypes[i])
	end
	cellType = cellTypes[i]

	debug.log(tracks)
	debug.log(chart)
	debug.log(chart.chart)
	debug.log(cellType)
	debug.log(table.choice(tracks[chart.chart][cellType]))
end

return service