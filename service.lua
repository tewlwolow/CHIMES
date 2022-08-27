local service = {}

local config = require("tew.CHIMES.config")
local log = require("tew.CHIMES.common").log


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
	return nil
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

	return nil
end

function service.playCell(data, cell)
	local cellTypes = {}
	local cellType
	for _, item in pairs(data) do
		table.insert(cellTypes, #cellTypes+1, service.getCellType(item, cell))
	end
	if #cellTypes > 1 then
		log("More than one cell type detected. You may want to verify your config to exclude cross-matches. Cell types detected: ")
		for _, v in ipairs(cellTypes) do
			log(v)
		end
	end

	-- TODO: Sort to ensure consistency
	cellType = cellTypes[1]
	debug.log(cellType)
end

return service