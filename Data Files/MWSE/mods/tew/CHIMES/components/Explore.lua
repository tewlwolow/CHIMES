local class = require("tew.CHIMES.util.class")
local Chart = require("tew.CHIMES.components.Chart")

---@class CHIMESExploreChart : CHIMESChart
local Explore = class.create(Chart)
Explore.class = "CHIMESExploreChart"

return Explore