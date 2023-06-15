local class = require("tew.CHIMES.proto.Class")
local Chart = require("tew.CHIMES.proto.Chart")

---@class CHIMESWeathersChart : CHIMESChart
local Weathers = class.create(Chart)
Weathers.schema.data.item.disable = { type = "boolean" }
Weathers.class = "CHIMESWeathersChart"

return Weathers