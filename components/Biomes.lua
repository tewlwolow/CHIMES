local Class = require("tew.CHIMES.util.Class")
local Chart = require("tew.CHIMES.components.Chart")

---@class CHIMESBiomesChart : CHIMESChart
local Biomes = Class.create(Chart)
Biomes:_init()
Biomes.schema.data.item.strings = { type = "table", required = true }
Biomes:validate()

return Biomes