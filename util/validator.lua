local validator = {}
local schemaErrors = require("tew.CHIMES.util.schemaErrors")

local i18n = mwse.loadTranslations("tew.CHIMES")
local errorMessages = i18n("errors")

function validator.validate(instance)
	-- Write off what we need for quicker access
	local class = instance.class
	local chart = instance.chart
	local schema = instance.schema
	local path = instance.path
	local name = tostring(chart.name)

	-- Define our local error table
	local errors = {}

	-- Bloat the log with our beautiful message
	mwse.log(string.format(
		errorMessages.validationStarted, name, class)
	)

	-- First let's make sure all the required fields are in place
	-- This is a simple shallow check
	for k, v in pairs(schema) do
		if not ( (chart[k]) and (type(chart[k]) == v.type) ) then
			table.insert(
				errors,
				#errors,
				string.format("\t%s\n\t%s\n",
					string.format(
						errorMessages.valueInvalid,
						tostring(chart[k]),
						tostring(k)
					),
					string.format(
						errorMessages.typeExpectedGot,
						tostring(v.type),
						tostring(type(chart[k]))
					)
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
				string.format("\t%s\n",
					string.format(
						errorMessages.extraChartField,
						tostring(k),
						tostring(v)
					)
				)
			)
		end
	end


	-- No bother if data field is invalid at this point
	if (type(chart.data) == "table") and not (table.empty(chart.data)) then
		-- Make sure all data items are properly wrapped in a table
		for index, item in pairs(chart.data) do
			if not ( (schema.data.type == type(item)) ) then
				table.insert(
					errors,
					#errors + index,
					string.format("\t%s\n\t%s\n",
						string.format(
							errorMessages.dataFieldInvalidType,
							tostring(index)
						),
						string.format(
							errorMessages.typeExpectedGot,
							tostring(schema.data.type),
							tostring(type(item))
						)
					)
				)
			end
		end

		-- Ok, let's check items in the data field now
		if not (class == "CHIMESWeathersChart") then -- That one gets special treatment
			for k, v in pairs(schema.data.item) do
				if k == "type" then goto continue end -- Only used for the previous check
				-- Inside the schema data item loop, let's check if all chart data items match
				for index, item in pairs(chart.data) do
					if not (item[k] and type(item[k]) == v.type) then
						table.insert(
							errors,
							#errors + index,
							string.format("\t%s\n\t%s\n",
								string.format(
									errorMessages.itemFieldInvalid,
									tostring(item[k]),
									tostring(k),
									tostring(index)
								),
								string.format(
									errorMessages.typeExpectedGot,
									tostring(v.type),
									tostring(type(item[k]))
								)
							)
						)
					end
				end
				:: continue ::
			end
		else
			-- We need a specialised check for weathers schema since it uses two mutually exclusive fields
			for index, item in pairs(chart.data) do
				-- Let's see if either is present
				if (item.folder == nil and item.disable == nil) then
					table.insert(
						errors,
						#errors + index,
						string.format("\t%s\n\t%s\n",
							string.format(
								errorMessages.missingRequired,
								tostring(index)
							),
							errorMessages.weatherRequiredFields
						)
					)
				-- Error out if both are
				elseif (item.folder and item.disable) then
					table.insert(
						errors,
						#errors,
						string.format("\t%s\n\t%s\n",
							string.format(
								errorMessages.mutuallyExclusive,
								tostring(index)
							),
							errorMessages.weatherRequiredFields
						)
					)
				else -- When there is only one of them, let's finally confirm whether the type matches
					for k, v in pairs(schema.data.item) do
						if k == "type" then goto continue end
							if item[k] then
								if not (item[k] and type(item[k]) == v.type) then
									table.insert(
										errors,
										#errors + index,
										string.format("\t%s\n\t%s\n",
											string.format(
												errorMessages.itemFieldInvalid,
												tostring(item[k]),
												tostring(k),
												tostring(index)
											),
											string.format(
												errorMessages.typeExpectedGot,
												tostring(v.type),
												tostring(type(item[k]))
											)
										)
									)
								end
							end
						:: continue ::
					end
				end
			end
		end
	end

	-- In case of any errors, update the global error dictionary
	if not table.empty(errors, true) then
		schemaErrors[string.format("%s (%s)", name, path)] = errors
	end
end

return validator