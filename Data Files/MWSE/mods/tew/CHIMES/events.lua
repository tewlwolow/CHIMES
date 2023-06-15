local events = {}

local controllers = require("tew.CHIMES.controllers")

event.register(tes3.event.cellChanged, controllers.cell)
event.register(tes3.event.loaded, controllers.cell)
event.register(tes3.event.weatherTransitionStarted, controllers.weather)


return events