local class = require("tew.CHIMES.proto.Class")
local Chart = require("tew.CHIMES.proto.Chart")

---@class CHIMESExploreChart : CHIMESChart
local Explore = class.create(Chart)
Explore.class = "CHIMESExploreChart"

return Explore