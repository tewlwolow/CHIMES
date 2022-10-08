local Chart = require("tew.CHIMES.components.Chart")
local Class = require("tew.CHIMES.util.Class")

---@class CHIMESInteriorsChart : CHIMESChart
local Interiors = Class.create(Chart)
Interiors.schema.data.item = {
	method = {type = "string", required = true},
	strings = {type = "table", required = true}
}
