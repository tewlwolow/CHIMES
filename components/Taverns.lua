local Chart = require("tew.CHIMES.components.Chart")
local Class = require("tew.CHIMES.util.Class")

---@class CHIMESTavernsChart : CHIMESChart
local Taverns = Class.create(Chart)
Taverns.schema = {
	useRaces = { type = "boolean", required = true}
}
