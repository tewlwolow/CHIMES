local class = require("tew.CHIMES.util.class")
local Chart = require("tew.CHIMES.components.Chart")

---@class CHIMESBiomesChart : CHIMESChart
local Biomes = class.create(Chart)
Biomes.schema.data.item.strings = { type = "table" }
Biomes.class = "CHIMESBiomesChart"

return Biomes