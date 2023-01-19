local class = require("tew.CHIMES.util.class")
local Chart = require("tew.CHIMES.components.Chart")

---@class CHIMESExteriorsChart : CHIMESChart
local Exteriors = class.create(Chart)
Exteriors.schema.data.item.method = { type = "string" }
Exteriors.schema.data.item.strings = { type = "table" }
Exteriors.class = "CHIMESExteriorsChart"

return Exteriors
