local service = {}

function service.parseTileset(strings)
	
end

function service.parseNames(strings)

end

function service.resolveMethod(item)
	local method = item.method
	local strings = item.strings
	if method == "tileset" then
		service.parseTileset(strings)
	elseif method == "names" then
		service.parseNames(strings)
	end
end

return service