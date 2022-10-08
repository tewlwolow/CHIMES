local Chart = require("tew.CHIMES.components.Chart")
local Class = require("tew.CHIMES.util.Class")

---@class CHIMESWeathersChart : CHIMESChart
local Weathers = Class.create(Chart)
Weathers.schema.data.item.disable = { type = "boolean", required = false }
