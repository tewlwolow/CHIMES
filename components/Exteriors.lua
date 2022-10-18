local Class = require("tew.CHIMES.util.Class")
local Chart = require("tew.CHIMES.components.Chart")

---@class CHIMESExteriorsChart : CHIMESChart
local Exteriors = Class.create(Chart)
Exteriors.schema.data.item.method = { type = "string" }
Exteriors.schema.data.item.strings = { type = "table" }
Exteriors.class = "CHIMESExteriorsChart"

return Exteriors
