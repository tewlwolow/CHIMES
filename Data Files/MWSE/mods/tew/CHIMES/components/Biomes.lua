local class = require("tew.CHIMES.proto.Class")
local Chart = require("tew.CHIMES.proto.Chart")

---@class CHIMESBiomesChart : CHIMESChart
local Biomes = class.create(Chart)
Biomes.schema.data.item.strings = { type = "table" }
Biomes.class = "CHIMESBiomesChart"

return Biomes