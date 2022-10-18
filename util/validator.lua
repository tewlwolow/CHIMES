local validator = {}
local schemaErrors = require("tew.CHIMES.util.schemaErrors")

function validator.validate(instance)
	-- Write off what we need for quicker access
	local class = instance.class
	local chart = instance.chart
	local schema = instance.schema
	local name = tostring(chart.name)

	-- Define our local error table
	local errors = {}

	-- Bloat the log with our beautiful message
	mwse.log("Validating chart: " .. name .. "of class" .. class .. ".")

	-- First let's make sure all the required fields are in place

	for k, v in pairs(schema) do
		if not ( (chart[k]) and (type(chart[k]) == v.type) ) then
			table.insert(
				errors,
				#errors,
				string.format(
					"Invalid value: <%s> for field: <%s>.\n\t\tExpected type: <%s>, got: <%s>.\n",
					tostring(chart[k]),
					tostring(k),
					tostring(v.type),
					tostring(type(chart[k]))
				)
			)
		end
	end


	-- Now to see if there is any extraneous data in the chart
	for k, v in pairs(chart) do
		if not schema[k] then
			table.insert(
				errors,
				#errors,
				string.format(
					"Field: <%s> with value: <%s> not found in schema.\n",
					tostring(k),
					tostring(v)
				)
			)
		end
	end

	-- Ok, let's check items in the data field
	for index, item in pairs(chart.data) do
		if not ( (schema.data.type == type(item)) ) then
			string.format(
				"Invalid type for data item with key <%s>.\n\t\tExpected type: <%s>, got: <%s>.\n",
				tostring(index),
				tostring(schema.data.type),
				tostring(type(item))
			)
		end
	end

	if not (class == "CHIMESWeathersChart") then -- That one gets special treatment
		for k, v in pairs(schema.data.item) do
			if k == "type" then goto continue end
			for index, item in pairs(chart.data) do
				if not (item[k] and type(item[k]) == v.type) then
					table.insert(
						errors,
						#errors,
						string.format(
							"Invalid value: <%s> for field: <%s> in item: <%s>.\n\t\tExpected type: <%s>, got: <%s>.\n",
							tostring(item[k]),
							tostring(k),
							tostring(index),
							tostring(v.type),
							tostring(type(item[k]))
						)
					)
				end
			end
			:: continue ::
		end
	else
		for index, item in pairs(chart.data) do
			if not ((item.folder) or (item.disable)) then
				table.insert(
					errors,
					#errors,
					string.format(
						"Missing one or more of the required fields for item <%s>.\n\t\tExpected either 'disable' or 'folder' fields.\n",
						tostring(index)
					)
				)
			else
				for k, v in pairs(schema.data.item) do
					if k == "type" then goto continue end
						if item[k] then
							if not (item[k] and type(item[k]) == v.type) then
								table.insert(
									errors,
									#errors,
									string.format(
										"Invalid value: <%s> for field: <%s> in item: <%s>.\n\t\tExpected type: <%s>, got: <%s>.\n",
										tostring(item[k]),
										tostring(k),
										tostring(index),
										tostring(v.type),
										tostring(type(item[k]))
									)
								)
							end
						end
					:: continue ::
				end
			end
		end
	end

	if not table.empty(errors, true) then
		if name == "nil" then
			schemaErrors[string.format("%s_%s", name, #schemaErrors)] = errors
		else
			schemaErrors[name] = errors
		end
	end
end

return validator