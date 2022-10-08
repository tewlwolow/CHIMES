local Chart = require("tew.CHIMES.components.Chart")
local Class = require("tew.CHIMES.util.Class")

---@class CHIMESBiomesChart : CHIMESChart
local Biomes = Class.create(Chart)
Biomes.schema.data.item.strings = { type = "table", required = true }

return Biomes