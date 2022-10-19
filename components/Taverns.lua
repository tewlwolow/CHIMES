local class = require("tew.CHIMES.util.class")
local Chart = require("tew.CHIMES.components.Chart")

---@class CHIMESTavernsChart : CHIMESChart
local Taverns = class.create(Chart)
Taverns.schema.useRaces = { type = "boolean" }
Taverns.class = "CHIMESTavernsChart"

return Taverns
