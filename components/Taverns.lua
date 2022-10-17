local Class = require("tew.CHIMES.util.Class")
local Chart = require("tew.CHIMES.components.Chart")

---@class CHIMESTavernsChart : CHIMESChart
local Taverns = Class.create(Chart)
Taverns.schema.useRaces = { type = "boolean" }

return Taverns
