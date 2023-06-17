local events = {}

local central = require("tew.CHIMES.controllers.central")

event.register(tes3.event.cellChanged, central.check)
event.register(tes3.event.weatherTransitionStarted, central.check)
-- event.register(tes3.event.musicSelectTrack, central.override)
event.register(tes3.event.combatStarted, central.purge)
event.register(tes3.event.combatStop, central.check)
event.register(tes3.event.load, central.purge)

return events