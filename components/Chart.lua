-- local validator = require("tew.CHIMES.util.validator")
-- local errors = require("tew.CHIMES.util.errors")
local Class = require("tew.CHIMES.util.Class")

local schema = {
	name = { type = "string", required = true },
	data = { type = "table", required = true,
		item = { type = "table", required = true,
			id = { type = "string", required = true },
			folder = { type = "string", required = true }
		}
	}
}

---@class CHIMESChart
local Chart = Class.create()
Chart.schema = schema
function Chart:_init(chart)
	self.chart = chart
end

return Chart
