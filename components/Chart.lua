local validator = require("tew.CHIMES.util.validator")
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

function Chart:_init(chart)
	self.schema = schema
	self.chart = chart
end

function Chart:validate()
	validator.validate(self)
end

return Chart
