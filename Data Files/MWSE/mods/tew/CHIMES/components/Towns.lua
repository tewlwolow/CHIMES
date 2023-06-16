local class = require("tew.CHIMES.proto.Class")
local Chart = require("tew.CHIMES.proto.Chart")

---@class CHIMESTownsChart : CHIMESChart
local Towns = class.create(Chart)
Towns.schema.data.item.method = { type = "string" }
Towns.schema.data.item.strings = { type = "table" }
Towns.class = "CHIMESTownsChart"

return Towns
