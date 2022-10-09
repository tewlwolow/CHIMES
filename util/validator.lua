local validator = {}

function validator.validate(instance)
	local function walk(chartTable, schemaTable)
		for k, v in pairs(chartTable) do
			print(k)
			print(v)
			if type(chartTable[k]) == schemaTable[k].type then
				print("good")
			else
				print("not good")
			end
			if type(v) == "table" then
				walk(v, schemaTable[k])
			end
		end
	end
	walk(instance.chart, instance.schema)
end

return validator