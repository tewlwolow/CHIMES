local validator = require("tew.CHIMES.util.validator")
-- local errors = require("tew.CHIMES.util.errors")
local Class = require("tew.CHIMES.util.Class")

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
local Chart = Class.create()
Chart.schema = schema

function Chart:_init(chart)
	self.chart = chart
	validator.validate(self)
end

return Chart
