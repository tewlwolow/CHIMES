local events = {}

local cell = require("tew.CHIMES.controllers.cell")
local weather = require("tew.CHIMES.controllers.weather")


event.register(tes3.event.cellChanged, cell.check())
event.register(tes3.event.loaded, cell.check())
event.register(tes3.event.weatherTransitionStarted, weather.check())


return events