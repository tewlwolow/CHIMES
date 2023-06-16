local events = {}

local central = require("tew.CHIMES.controllers.central")

event.register(tes3.event.cellChanged, central.check)
event.register(tes3.event.weatherTransitionStarted, central.check)
event.register(tes3.event.load, central.purge)

return events