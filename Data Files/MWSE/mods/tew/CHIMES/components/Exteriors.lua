local class = require("tew.CHIMES.proto.Class")
local Chart = require("tew.CHIMES.proto.Chart")

---@class CHIMESExteriorsChart : CHIMESChart
local Exteriors = class.create(Chart)
Exteriors.schema.data.item.method = { type = "string" }
Exteriors.schema.data.item.strings = { type = "table" }
Exteriors.class = "CHIMESExteriorsChart"

return Exteriors
