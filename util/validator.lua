local validator = {}

validator.errors = {}

function validator.validate(instance)
	mwse.log("Validating chart: " .. instance.chart.name)
	for k, v in pairs(instance.schema) do
		if not ( (instance.chart[k]) and (type(instance.chart[k]) == v.type) ) then
			if not validator.errors[instance.chart.name] then
				validator.errors[instance.chart.name] = {}
			end
			table.insert(
				validator.errors[instance.chart.name],
				#validator.errors[instance.chart.name]+1,
				string.format("Invalid value: %s for field: %s. Expected type: %s, got: %s.", v, k, v.type, type(instance.chart[k]))
			)
		end
	end

	for k, v in pairs(validator.errors) do
		if k and v and v[1] then
			print(k)
			print(v[1])
		end
	end
end

return validator