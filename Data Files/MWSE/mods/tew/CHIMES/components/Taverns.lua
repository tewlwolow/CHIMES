local class = require("tew.CHIMES.proto.Class")
local Chart = require("tew.CHIMES.proto.Chart")

---@class CHIMESTavernsChart : CHIMESChart
local Taverns = class.create(Chart)
Taverns.schema.useRaces = { type = "boolean" }
Taverns.schema.fallbackFolder = { type = "string" }
Taverns.class = "CHIMESTavernsChart"

return Taverns
