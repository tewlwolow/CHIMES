local Class = require("tew.CHIMES.util.Class")
local Chart = require("tew.CHIMES.components.Chart")

---@class CHIMESBiomesChart : CHIMESChart
local Biomes = Class.create(Chart)
Biomes.schema.data.item.strings = { type = "table" }

return Biomes