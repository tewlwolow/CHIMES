local class = require("tew.CHIMES.util.class")
local Chart = require("tew.CHIMES.components.Chart")

---@class CHIMESWeathersChart : CHIMESChart
local Weathers = class.create(Chart)
Weathers.schema.data.item.disable = { type = "boolean" }
Weathers.class = "CHIMESWeathersChart"

return Weathers