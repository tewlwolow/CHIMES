local Chart = require("tew.CHIMES.components.Chart")
local Class = require("tew.CHIMES.util.Class")

---@class CHIMESExteriorsChart : CHIMESChart
local Exteriors = Class.create(Chart)
Exteriors.schema.data.item = {
	method = {type = "string", required = true},
	strings = {type = "table", required = true}
}
