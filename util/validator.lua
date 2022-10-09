local validator = {}

function validator.validate(instance)
	print(instance.schema.data.item.strings.type)
	print(instance.chart.name)
end

return validator