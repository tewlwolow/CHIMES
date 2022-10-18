local Class = require("tew.CHIMES.util.Class")
local Chart = require("tew.CHIMES.components.Chart")

---@class CHIMESInteriorsChart : CHIMESChart
local Interiors = Class.create(Chart)
Interiors.schema.data.item.method = { type = "string" }
Interiors.schema.data.item.strings = { type = "table" }
Interiors.class = "CHIMESInteriorsChart"

return Interiors