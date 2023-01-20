local validator = require("tew.CHIMES.util.validator")
local importer = require("tew.CHIMES.util.importer")

local schema = {
	name = { type = "string" },
	data = { type = "table",
		item = { type = "table",
			id = { type = "string" },
			folder = { type = "string" }
		}
	}
}

---@class CHIMESChart
local Chart = {}
Chart.schema = schema

function Chart:_init(chart, path)
	self.chart = chart
	self.path = path
	local valid = validator.validate(self)
	if valid then
		importer.import(self)
	end
end

return Chart
