local service = {}

local config = require("tew.CHIMES.config")
local log = require("tew.CHIMES.common").log
local language = require(config.language)
local messages = language.messages


function service.parseTileset(strings, folder, cell)

	local count = 0
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

function service.parseNames(strings, folder, cell)

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

function service.playCell(data, cell)
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
	repeat
		i = i + 1
	until(cellTypes[i])
	cellType = cellTypes[i]
end

return service