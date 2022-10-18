local Class = require("tew.CHIMES.util.Class")
local Chart = require("tew.CHIMES.components.Chart")

---@class CHIMESWeathersChart : CHIMESChart
local Weathers = Class.create(Chart)
Weathers.schema.data.item.disable = { type = "boolean" }
Weathers.class = "CHIMESWeathersChart"

return Weathers