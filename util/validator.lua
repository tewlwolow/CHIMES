local validator = {}

function validator.validate(instance)
	print(instance.schema.data.item.strings.type)
end

return validator