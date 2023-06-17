local cellParser = {}

local config = require("tew.CHIMES.options.config")
local log = require("tew.CHIMES.util.common").log
local i18n = mwse.loadTranslations("tew.CHIMES")
local messages = i18n("messages")


function cellParser.parseTileset(item, cell)
	local count = 0
	if item and cell then
		for stat in cell:iterateReferences(tes3.objectType.static) do
			for _, staticName in ipairs(item.strings) do
				if string.find(stat.object.id:lower(), staticName:lower()) then
					count = count + 1
					if count >= config.minStatics then
						return true
					end
				end
			end
		end
	end
end

function cellParser.parseNames(item, cell)
	if item and cell and cell.name then
		for _, name in ipairs(item.strings) do
			if string.find(cell.name, name) then
				return true
			end
		end
	end
end

function cellParser.isValidCell(item, cell)
	local method = item.method

	if method == "tileset" then
		return cellParser.parseTileset(item, cell)
	elseif method == "names" then
		return cellParser.parseNames(item, cell)
	end
end

function cellParser.getTown(item, cell)
	local method = item.method

	if method == "tileset" then
		return cellParser.parseTileset(item, cell)
	elseif method == "names" then
		return cellParser.parseNames(item, cell)
	end
end

-- function cellParser.playCell(chart, cell)
-- 	local data = chart.data
-- 	local cellTypes = {}
-- 	local cellType
-- 	for priority, item in pairs(data) do
-- 		cellTypes[priority] = cellParser.getCellType(item, cell)
-- 	end
-- 	if #cellTypes > 1 then
-- 		log(messages.superMatch)
-- 		for k, v in pairs(cellTypes) do
-- 			log(string.format("%s: [%s], %s: [%s]", messages.priority, k, messages.cellType, v))
-- 		end
-- 		log(messages.priorityMessage)
-- 	end

-- 	local i = 0
-- 	if #cellTypes > 0 then
-- 		repeat
-- 			i = i + 1
-- 		until(cellTypes[i])
-- 	end
-- 	cellType = cellTypes[i]

-- 	debug.log(chart)
-- 	debug.log(chart.chart)
-- 	debug.log(cellType)
-- end

return cellParser