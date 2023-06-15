local class = require("tew.CHIMES.proto.Class")
local Chart = require("tew.CHIMES.proto.Chart")

---@class CHIMESInteriorsChart : CHIMESChart
local Interiors = class.create(Chart)
Interiors.schema.data.item.method = { type = "string" }
Interiors.schema.data.item.strings = { type = "table" }
Interiors.class = "CHIMESInteriorsChart"

return Interiors