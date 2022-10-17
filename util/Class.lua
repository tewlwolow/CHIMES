local Class = {}

function Class.create(base)

	local cls = table.deepcopy(base) -- Pseudo-inheritance

	-- Set class index method
	cls.__index, cls.__newindex = cls, cls

	-- So that we can call the tables directly
	setmetatable(cls, {__call = function (c, ...)
		local instance = setmetatable({}, c)
		
		-- Boot up constructor
		local init = instance._init
		if init then init(instance, ...) end
		return instance
	end})

	return cls
end

return Class